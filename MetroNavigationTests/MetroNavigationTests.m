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
#import "MNLineRoute.h"

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
    
    NSNumber *predictedLinesQty = @3;
    NSNumber *realLinesQty = @(metro.lines.count);
    
    XCTAssertNotNil(metro, @"Parsing json returned nil.");
    
    XCTAssertEqualObjects(predictedStationsQty, realStationsQty,
                          @"Number of stations should be %@, not %@",
                          predictedStationsQty,realStationsQty);
    
    XCTAssertEqualObjects(predictedEdgeQty, realEdgeQty,
                          @"Number of edges should be %@, not %@",
                          predictedEdgeQty,realEdgeQty);
    
    XCTAssertEqualObjects(predictedEdgeQty, realEdgeQty,
                          @"Number of edges should be %@, not %@",
                          predictedLinesQty,realLinesQty);
    
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
    
    MNEdge *edge = [metro edgeFromStation:klovska toStation:pecherska];
    
    XCTAssertNotNil(edge, @"Can not find edge between klovska and pecherska");
    XCTAssertEqualObjects([edge.lineNames firstObject], @"green", @"Wrong name of the line.");

    NSNumber *predictedDuration = @(1.3);
    NSNumber *realDuration = [metro durationFromStation:klovska toNeighboringStation:pecherska];
    
    NSNumber *predictedShortPathDuration = @(5.2);
    MNRoute *route = [metro shortestRouteFromStation:pecherska toStation:teartralna];
    NSNumber *realShortPathDuration = [metro shortestRouteFromStation:pecherska toStation:teartralna].totalDuration;
    
    XCTAssertEqualObjects(predictedDuration, realDuration,
                          @"Number of stations should be %@, not %@",
                          predictedDuration,realDuration);
    
    XCTAssertEqualObjects(predictedShortPathDuration, realShortPathDuration,
                          @"Number of stations should be %@, not %@",
                          predictedShortPathDuration,realShortPathDuration);
    
    NSArray <MNLineRoute *> *detailedRoutes = route.lineRoutes;
    
    
    NSNumber *predictedLineRoutesQty = @2;
    NSNumber *realLineRoutesQty = @(detailedRoutes.count);
    
    XCTAssertEqualObjects(predictedLineRoutesQty, realLineRoutesQty,
                          @"Number of routelines should be %@, not %@",
                          predictedLineRoutesQty, realLineRoutesQty);
    
    for (MNLineRoute *detailedRoute in detailedRoutes) {
        
        if ([detailedRoute.line.name isEqualToString:@"red"]) {
            
            NSNumber *predictedStationQty = @1;
            NSNumber *realLineStationQty = @(detailedRoute.stationSequence.count);
            
            XCTAssertEqualObjects(predictedStationQty, realLineStationQty,
                                  @"Number of edges should be %@, not %@",
                                  predictedStationQty, realLineStationQty);
            
        } else if ([detailedRoute.line.name isEqualToString:@"green"]) {
            
            NSNumber *predictedStationQty = @4;
            NSNumber *realLineStationQty = @(detailedRoute.stationSequence.count);
            
            XCTAssertEqualObjects(predictedStationQty, realLineStationQty,
                                  @"Number of edges should be %@, not %@",
                                  predictedStationQty, realLineStationQty);
            
        }
    }

    
}

- (void)testReadingMilanoMetroFromFile {
    
    MNMetro *milanoMetro = [DataAPI metroJSONFile:@"milano"];
    
    NSNumber *predictedStationsQty = @106;
    NSNumber *realStationsQty = @(milanoMetro.stations.count);
    
    NSNumber *predictedEdgeQty = @109;
    NSNumber *realEdgeQty = @(milanoMetro.edges.count);
    
    
    XCTAssertNotNil(milanoMetro, @"Parsing json returned nil.");
    
    XCTAssertEqualObjects(predictedStationsQty, realStationsQty,
                          @"Number of stations should be %@, not %@",
                          predictedStationsQty,realStationsQty);
    
    XCTAssertEqualObjects(predictedEdgeQty, realEdgeQty,
                          @"Number of edges should be %@, not %@",
                          predictedEdgeQty,realEdgeQty);
    
    NSPredicate *duomoPredicate = [NSPredicate predicateWithFormat:@"identifier = %@", @"312"];
    NSPredicate *missoriPredicate = [NSPredicate predicateWithFormat:@"identifier = %@", @"313"];
    NSPredicate *sanbilaPredicate = [NSPredicate predicateWithFormat:@"identifier = %@", @"114"];
    NSPredicate *sandonatePredicate = [NSPredicate predicateWithFormat:@"identifier = %@", @"321"];
    NSPredicate *lambratePredicate = [NSPredicate predicateWithFormat:@"identifier = %@", @"420"];
    
    MNStation *duomo = [milanoMetro.stations filteredArrayUsingPredicate:duomoPredicate].firstObject;
    MNStation *missori = [milanoMetro.stations filteredArrayUsingPredicate:missoriPredicate].firstObject;
    MNStation *sanbila = [milanoMetro.stations filteredArrayUsingPredicate:sanbilaPredicate].firstObject;
    MNStation *sandonate = [milanoMetro.stations filteredArrayUsingPredicate:sandonatePredicate].firstObject;
    MNStation *lambrate = [milanoMetro.stations filteredArrayUsingPredicate:lambratePredicate].firstObject;
    
    XCTAssertNotNil(duomo, @"Cannot find station with station the identifier 312.");
    XCTAssertNotNil(missori, @"Cannot find station with station the identifier 313.");
    XCTAssertNotNil(sanbila, @"Cannot find station with station the identifier 114.");
    
    XCTAssertEqualObjects(duomo.name, @"Duomo", @"The name of station with 312 id is not 'Duomo'");
    XCTAssertEqualObjects(missori.name, @"Missori", @"The name of station with 313 id is not 'Missori'");
    XCTAssertEqualObjects(sanbila.name, @"San babila", @"The name of station with 114 id is not 'San babila'");
    
    MNEdge *edge = [milanoMetro edgeFromStation:duomo toStation:missori];
    
    XCTAssertNotNil(edge, @"Can not find edge between 'duomo' and 'missori'");
    XCTAssertEqualObjects([edge.lineNames firstObject], @"yellow", @"Wrong name of the line.");
    
    NSNumber *predictedDuration = @(1.3);
    NSNumber *realDuration = [milanoMetro durationFromStation:duomo toNeighboringStation:missori];
    
    NSNumber *predictedShortPathDuration = @(30.800000000000004);
    MNRoute *route = [milanoMetro shortestRouteFromStation:sandonate toStation:lambrate];
    NSNumber *realShortPathDuration = route.totalDuration;
    
    XCTAssertEqualObjects(predictedDuration, realDuration,
                          @"Duration from duomo to missoru %@, not %@",
                          predictedDuration,realDuration);
    
    XCTAssertEqualObjects(predictedShortPathDuration, realShortPathDuration,
                          @"Number of stations should be %@, not %@",
                         predictedShortPathDuration, realShortPathDuration);
    
    NSArray <MNLineRoute *> *detailedRoutes = route.lineRoutes;
    
    
    NSNumber *predictedLineRoutesQty = @3;
    NSNumber *realLineRoutesQty = @(detailedRoutes.count);
    
    XCTAssertEqualObjects(predictedLineRoutesQty, realLineRoutesQty,
                          @"Number of routelines should be %@, not %@",
                          predictedLineRoutesQty, realLineRoutesQty);
    
    for (MNLineRoute *detailedRoute in detailedRoutes) {
        
        if ([detailedRoute.line.name isEqualToString:@"red"]) {
            
            NSNumber *predictedStationQty = @6;
            NSNumber *realLineStationQty = @(detailedRoute.stationSequence.count);
            
            XCTAssertEqualObjects(predictedStationQty, realLineStationQty,
                                  @"Number of stations for red should be %@, not %@",
                                  predictedStationQty, realLineStationQty);
            
        } else if ([detailedRoute.line.name isEqualToString:@"green"]) {
            
            NSNumber *predictedStationQty = @3;
            NSNumber *realLineStationQty = @(detailedRoute.stationSequence.count);
            
            XCTAssertEqualObjects(predictedStationQty, realLineStationQty,
                                  @"Number of stations fore green should be %@, not %@",
                                  predictedStationQty, realLineStationQty);
            
        } else if ([detailedRoute.line.name isEqualToString:@"yellow"]) {
            
            NSNumber *predictedStationQty = @10;
            NSNumber *realLineStationQty = @(detailedRoute.stationSequence.count);
            
            XCTAssertEqualObjects(predictedStationQty, realLineStationQty,
                                  @"Number of stations for yellow should be %@, not %@",
                                  predictedStationQty, realLineStationQty);
            
        }
    }
    
}

- (void)testStateHolder {
    
}


@end
