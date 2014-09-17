#!/bin/bash
source "$HOME/.rvm/scripts/rvm"
rvm use ruby-2.0.0-p0

export LC_CTYPE=en_US.UTF-8

rm -rf ${PWD}/sonar-reports
rm -rf ${PWD}/DerivedData

BUILD_CMD_SUFFIX="-project ${PROJECT_NAME}.xcodeproj -derivedDataPath ${PWD}/DerivedData -configuration Debug" 

printf "\n============================"
printf "\nCreating output directory...\n"
if [[ ! (-d "${PWD}/sonar-reports") ]]; then
	mkdir ${PWD}/sonar-reports
fi

printf "\n==========="
printf "\nCleaning...\n"
/usr/bin/xcodebuild ${BUILD_CMD_SUFFIX} -scheme "${DEFAULT_SCHEME}" -sdk "${DEFAULT_SDK}" clean | xcpretty

printf "\n=============================="
printf "\nExtracting compile commands...\n"
/usr/bin/xcodebuild ${BUILD_CMD_SUFFIX} -scheme "${DEFAULT_SCHEME}" -sdk "${DEFAULT_SDK}" > xcodebuild.log

printf "\n======================================="
printf "\nGenerating JSON Compilation database...\n"
/usr/local/bin/oclint-xcodebuild

printf "\n====================="
printf "\nRunning unit tests...\n"
GCC_GENERATE_TEST_COVERAGE_FILES=YES GCC_INSTRUMENT_PROGRAM_FLOW_ARCS=YES /usr/bin/xcodebuild ${BUILD_CMD_SUFFIX} -scheme "${DEFAULT_SCHEME}" -sdk "${DEFAULT_SDK}" test | xcpretty -tc --report junit --output "${PWD}/sonar-reports/TEST-report.xml"

printf "\n================"
printf "\nRunning gcovr...\n"
./scripts/gcovr -r . ${PWD}/DerivedData/Build/Intermediates/"${DEFAULT_SCHEME}".build/Debug-iphonesimulator/"${DEFAULT_TARGET}".build/Objects-normal/i386 --exclude .*Tests.* --xml > "${PWD}/sonar-reports/coverage.xml" 

printf "\n================="
printf "\nRunning OCLint...\n"
/usr/local/bin/oclint-json-compilation-database -d "${PWD}/${PROJECT_NAME}" -- -report-type pmd -o sonar-reports/oclint.xml

printf "\n========================="
printf "\nUploading to SonarQube...\n"
/usr/local/bin/sonar-runner -Dsonar.verbose=true -X

exit $?