//
//  MetroNavigationTests.m
//  MetroNavigationTests
//
//  Created by Nikita Kirichek on 4/19/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MNMetro.h"
#import "MNDataAPI.h"

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

- (void)testReadingKyivMetroFromFile {
    
    MNMetro *metro = [DataAPI metroJSONFile:@"kyiv"];
    
    NSNumber *predictedStationsQty = @54;
    NSNumber *realStationsQty = @(metro.stations.count);
    
    NSNumber *predictedEdgeQty = @54;
    NSNumber *realEdgeQty = @(metro.stations.count);
    
    
    XCTAssertNotNil(metro, @"Parsing json returned nil.");
    
    XCTAssertEqualObjects(predictedStationsQty, realStationsQty,
                          @"Number of stations should be %@, not %@",
                          predictedStationsQty,realStationsQty);
    
    XCTAssertEqualObjects(predictedEdgeQty, realEdgeQty,
                          @"Number of edges should be %@, not %@",
                          predictedEdgeQty,realEdgeQty);
    
    NSPredicate *teatralnaPredicate = [NSPredicate predicateWithFormat:@"identifier = %@", @"109"];
    NSPredicate *pecherskaPredicate = [NSPredicate predicateWithFormat:@"identifier = %@", @"310"];
    NSPredicate *klovskaPredicate = [NSPredicate predicateWithFormat:@"identifier = %@", @"311"];

    MNStation *teartralna = [metro.stations filteredArrayUsingPredicate:teatralnaPredicate].firstObject;
    MNStation *pecherska = [metro.stations filteredArrayUsingPredicate:pecherskaPredicate].firstObject;
    MNStation *klovska = [metro.stations filteredArrayUsingPredicate:klovskaPredicate].firstObject;
    
    XCTAssertNotNil(teartralna, @"Cannot find station with station the identifier 109.");
    XCTAssertNotNil(pecherska, @"Cannot find station with station the identifier 310.");
    XCTAssertNotNil(klovska, @"Cannot find station with station the identifier 311.");
    
    XCTAssertEqualObjects(teartralna.name, @"Teatralna", @"The name of station with 109 id is not 'Teatralna'");
    XCTAssertEqualObjects(pecherska.name, @"Pecherska", @"The name of station with 310 id is not 'Pecherska'");
    XCTAssertEqualObjects(klovska.name, @"Klovska", @"The name of station with 311 id is not 'Klovska'");
    
    NSNumber *predictedDuration = @(1.3);
    NSNumber *realDuration = [metro durationFromStation:klovska toNeighboringStation:pecherska];
    
    NSNumber *predictedShortPathDuration = @(5.2);
    NSNumber *realShortPathDuration = [metro shortestRouteFromStation:pecherska toStation:teartralna].totalDuration;
    
    XCTAssertEqualObjects(predictedDuration, realDuration,
                          @"Number of stations should be %@, not %@",
                          predictedDuration,realDuration);
    
    XCTAssertEqualObjects(predictedShortPathDuration, realShortPathDuration,
                          @"Number of stations should be %@, not %@",
                          predictedShortPathDuration,realShortPathDuration);
    
    
}

- (void)testReadingMilanoMetroFromFile {
    
    MNMetro *metro = [DataAPI metroJSONFile:@"milano"];
    
    NSNumber *predictedStationsQty = @113;
    NSNumber *realStationsQty = @(metro.stations.count);
    
    NSNumber *predictedEdgeQty = @108;
    NSNumber *realEdgeQty = @(metro.stations.count);
    
    
    XCTAssertNotNil(metro, @"Parsing json returned nil.");
    
    XCTAssertEqualObjects(predictedStationsQty, realStationsQty,
                          @"Number of stations should be %@, not %@",
                          predictedStationsQty,realStationsQty);
    
    XCTAssertEqualObjects(predictedEdgeQty, realEdgeQty,
                          @"Number of edges should be %@, not %@",
                          predictedEdgeQty,realEdgeQty);
    
    
    
}


@end
