#!/bin/bash
source "$HOME/.rvm/scripts/rvm"
rvm use ruby-2.0.0-p0

export LC_CTYPE=en_US.UTF-8

rm -rf ${PWD}/build

BUILD_CMD_PREFIX="-workspace ${PROJECT_NAME}.xcodeproj -configuration Debug -arch x86_64 ARCHS=x86_64 VALID_ARCHS=x86_64 ONLY_ACTIVE_ARCH=YES SHARED_PRECOMPS_DIR=${PWD}/build/PrecompiledHeaders SYMROOT=${PWD}/build OBJROOT=${PWD}/build SYMROOT=${PWD}/build CONFIGURATION_BUILD_DIR=${PWD}/build/Debug-iphonesimulator"

printf "\n============================"
printf "\nCreating output directory...\n"
if [[ ! (-d "sonar-reports") ]]; then
	mkdir sonar-reports
fi

printf "\n==========="
printf "\nCleaning...\n"
/usr/bin/xcodebuild "${BUILD_CMD_PREFIX}" -scheme "${DEFAULT_SCHEME}" -sdk "${DEFAULT_SDK}" clean | xcpretty

printf "\n=============================="
printf "\nExtracting compile commands...\n"
/usr/bin/xcodebuild "${BUILD_CMD_PREFIX}" -scheme "${DEFAULT_SCHEME}" -sdk "${DEFAULT_SDK}" > xcodebuild.log

printf "\n======================================="
printf "\nGenerating JSON Compilation database...\n"
/usr/local/bin/oclint-xcodebuild

printf "\n====================="
printf "\nRunning unit tests...\n"
#/usr/bin/xcodebuild "${BUILD_CMD_PREFIX}" -scheme "${TEST_SCHEME}" -sdk "${TEST_SDK}" -destination "${KIF_DESTINATION}" test | xcpretty -tc

printf "\n================="
printf "\nRunning OCLint...\n"
/usr/local/bin/oclint-json-compilation-database -d "${PWD}/${PROJECT_NAME}" -- -report-type pmd -o sonar-reports/oclint.xml

printf "\n========================="
printf "\nUploading to SonarQube...\n"
/usr/local/bin/sonar-runner

exit $?