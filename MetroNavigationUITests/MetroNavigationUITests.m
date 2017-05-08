//
//  MetroNavigationUITests.m
//  MetroNavigationUITests
//
//  Created by Nikita Kirichek on 4/19/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "XCUIElement+Helpers.h"

@interface MetroNavigationUITests : XCTestCase

@property (nonatomic, strong) XCUIApplication *app;

@end

@implementation MetroNavigationUITests

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    
    self.app = [XCUIApplication new] ;
    [self.app launch];
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testSelectingStations {
    
    XCUIApplication *app = [XCUIApplication new];
    XCUIElement *kyivMetroImage = app.images[@"kyiv-metro"];

    
    [app.navigationBars[@"Kyiv Metro"].buttons[@"More cities"] tap];
    [app.tables.staticTexts[@"Kiev Metropolitan"] tap];
    [app.navigationBars[@"Choose Metro"].buttons[@"Done"] tap];

    [kyivMetroImage tapAtPointX:123.4f y:308.0f];
    [kyivMetroImage tapAtPointX:226.7f y:231.1f];
    
    XCTAssertTrue([app.buttons[@"Tarasa Shevchenka"] exists], @"Tapped station was not Tarasa Shevchenka.");
    XCTAssertTrue([app.buttons[@"Politechnichnyi Instytut"] exists], @"Tapped station was not Tarasa Shevchenka.");

    
    [app.buttons[@"Details"] tap];
    [app.navigationBars[@"Route Details"].buttons[@"Done"] tap];
    
    
    
}


@end
