//
//  MetroNavigationTests.m
//  MetroNavigationTests
//
//  Created by Nikita Kirichek on 4/19/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MNMetro.h"
#import "DataAPI.h"

@interface MetroNavigationTests : XCTestCase

@end

@implementation MetroNavigationTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testReadingMetroFromFile {
    MNMetro *metro = [DataAPI metroJSONFile:@"kyiv"];
    XCTAssertNotNil(metro, @"Can not get json");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
