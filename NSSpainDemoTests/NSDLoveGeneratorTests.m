//
//  NSSpainDemoTests.m
//  NSSpainDemoTests
//
//  Created by Simone Civetta on 17/09/14.
//  Copyright (c) 2014 SimoneCivetta. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSDLoveGenerator.h"

@interface NSSpainDemoTests : XCTestCase

@end

@implementation NSSpainDemoTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testInit
{
    NSDLoveGenerator *generator = [NSDLoveGenerator generatorWithRepetitionCount:5];
    XCTAssertTrue([generator isKindOfClass:NSDLoveGenerator.class]);
}

- (void)testCount
{
    NSDLoveGenerator *generator = [[NSDLoveGenerator alloc] initWithLoveCount:5];
    XCTAssertEqual([[generator giveMeSomeLove] length], 20);
}

@end
