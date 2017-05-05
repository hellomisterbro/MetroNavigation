//
//  MetroGraphLogicTest.m
//  MetroNavigation
//
//  Created by Nikita Kirichek on 4/16/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "MNMetro.h"


@interface MetroGraphLogicTest : XCTestCase
@end

@implementation MetroGraphLogicTest {
    
    MNMetro *cityA;
    
    MNStation *stationA;
    MNStation *stationB;
    MNStation *stationC;
    MNStation *stationD;
    MNStation *stationE;
    MNStation *stationF;
    MNStation *stationG;

}

- (void)setUp {
    
    [super setUp];
    
    cityA = [MNMetro metro];
    
    stationA = [MNStation stationWithIdentifier:@"A"];
    stationB = [MNStation stationWithIdentifier:@"B"];
    stationC = [MNStation stationWithIdentifier:@"C"];
    stationD = [MNStation stationWithIdentifier:@"D"];
    stationE = [MNStation stationWithIdentifier:@"E"];
    stationF = [MNStation stationWithIdentifier:@"F"];
    stationG = [MNStation stationWithIdentifier:@"G"];
    
    //test if it ignores duplicate stations
    MNStation *stationAClone = [MNStation stationWithIdentifier:@"A"];
    MNStation *stationGClone = [MNStation stationWithIdentifier:@"G"];
    
    [cityA addEdge:[MNEdge edgeWithDuration:@6] fromStation:stationA toStation:stationB];
    [cityA addEdge:[MNEdge edgeWithDuration:@9] fromStation:stationA toStation:stationD];
    [cityA addEdge:[MNEdge edgeWithDuration:@5] fromStation:stationB toStation:stationD];
    [cityA addEdge:[MNEdge edgeWithDuration:@3] fromStation:stationB toStation:stationE];
    [cityA addEdge:[MNEdge edgeWithDuration:@5] fromStation:stationC toStation:stationF];
    [cityA addEdge:[MNEdge edgeWithDuration:@7] fromStation:stationC toStation:stationD];
    [cityA addEdge:[MNEdge edgeWithDuration:@1] fromStation:stationD toStation:stationE];
    [cityA addEdge:[MNEdge edgeWithDuration:@3] fromStation:stationE toStation:stationF];
    [cityA addEdge:[MNEdge edgeWithDuration:@10] fromStation:stationE toStation:stationG];
    [cityA addEdge:[MNEdge edgeWithDuration:@4] fromStation:stationAClone toStation:stationC];
    [cityA addEdge:[MNEdge edgeWithDuration:@8] fromStation:stationF toStation:stationGClone];
}

- (void)testAddingStationsAnsEdges {
    XCTAssertEqual(7, (cityA.stations.count),
                   @"Bad Amount, metro should contain 7 stations, not %lu", (unsigned long)cityA.stations.count);
    XCTAssertEqual(11, (cityA.edges.count),
                   @"Bad Amount, metro should contain 11 edges, not %lu", (unsigned long)cityA.edges.count);
}

- (void)testMetro {
    
    MNEdge *edgeAB = [MNEdge edgeWithDuration:@6];
    
    edgeAB.firstStation = stationA;
    edgeAB.secondStation = stationB;
    
    MNEdge *resultEdge =  [cityA edgeFromStation:stationA toStation:stationB];
    
    XCTAssertEqualObjects(edgeAB, resultEdge,  @"Edge %@ is not equal to %@", edgeAB, resultEdge);
    XCTAssertEqualObjects(stationA, [resultEdge stationOppositeToStation:stationB],  @"Edge %@ is not equal to %@", edgeAB, resultEdge);
    
    edgeAB.duration = @1;
    
    XCTAssertNotEqualObjects(edgeAB, resultEdge, @"Edge %@ is equal to %@", edgeAB, resultEdge);
    
    XCTAssertEqualObjects(@6, [cityA durationFromStation:stationA toNeighboringStation:stationB], @"Incorrect duration for edge A - B");
    XCTAssertEqualObjects(@1, [cityA durationFromStation:stationD toNeighboringStation:stationE], @"Incorrect duration for edge D - E");
    XCTAssertEqualObjects(@10, [cityA durationFromStation:stationE toNeighboringStation:stationG], @"Incorrect duration for edge E - G");
    
    XCTAssertNil([cityA durationFromStation:stationG toNeighboringStation:stationC]);
    
}

- (void)testNeighboringStations {
    
    NSSet *predictedResultForA = [NSSet setWithArray:@[stationC, stationB, stationD]];
    NSSet *resultForA = [NSSet setWithArray:[cityA neighboringStationsToStation:stationA]];
    
//    NSSet *predictedResultForD = [NSSet setWithArray:@[stationA, stationB, stationC, stationE]];
//    NSSet *resultForD = [NSSet setWithArray:[cityA neighboringStationsToStation:stationD]];
    
    NSSet *predictedResultForG = [NSSet setWithArray:@[stationE, stationF]];
    NSSet *resultForG = [NSSet setWithArray:[cityA neighboringStationsToStation:stationG]];
    
    NSSet *predictedResultForC = [NSSet setWithArray:@[stationA, stationD, stationF]];
    NSSet *resultForC = [NSSet setWithArray:[cityA neighboringStationsToStation:stationC]];
    
    XCTAssertEqualObjects(predictedResultForA, resultForA,  @"Incorrect neighboring stations for the station A");
//    XCTAssertEqualObjects(predictedResultForD, resultForD,  @"Incorrect neighboring stations for the station D");
    XCTAssertEqualObjects(predictedResultForG, resultForG,  @"Incorrect neighboring stations for the station G");
    XCTAssertEqualObjects(predictedResultForC, resultForC,  @"Incorrect neighboring stations for the station C");
}

- (void)testShortestPathFirst {
    
    MNRoute *resultRoute =  [cityA shortestRouteFromStation:stationA toStation:stationG];
    
    MNRoute *predictedRoute = [MNRoute route];
    
    NSMutableArray *edgesSequence = [NSMutableArray array];
    NSMutableArray *stationsSequence = [NSMutableArray array];
    
    [edgesSequence addObject:[cityA edgeFromStation:stationA toStation:stationC]];
    [edgesSequence addObject:[cityA edgeFromStation:stationC toStation:stationF]];
    [edgesSequence addObject:[cityA edgeFromStation:stationF toStation:stationG]];
    
    [stationsSequence addObject:stationA];
    [stationsSequence addObject:stationC];
    [stationsSequence addObject:stationF];
    [stationsSequence addObject:stationG];
    
    predictedRoute.stationsSequence = stationsSequence;
    predictedRoute.edgesSequence = edgesSequence;
    
    XCTAssertEqualObjects(resultRoute, predictedRoute,  @"Incorrect shortest path from station A to station G");
    XCTAssertEqualObjects(resultRoute.totalDuration, @17,  @"Incorrect smallest duration from station A to station G");
    
}

//Testing the following graph - https://en.wikipedia.org/wiki/File:Shortest_path_with_direct_weights.svg
- (void)testShortestPathSecond {
    
    MNMetro *cityB = [MNMetro new];
    
    [cityB addEdge:[MNEdge edgeWithDuration:@4] fromStation:stationA toStation:stationB];
    [cityB addEdge:[MNEdge edgeWithDuration:@2] fromStation:stationA toStation:stationC];
    [cityB addEdge:[MNEdge edgeWithDuration:@5] fromStation:stationB toStation:stationC];
    [cityB addEdge:[MNEdge edgeWithDuration:@3] fromStation:stationC toStation:stationE];
    [cityB addEdge:[MNEdge edgeWithDuration:@4] fromStation:stationE toStation:stationD];
    [cityB addEdge:[MNEdge edgeWithDuration:@10] fromStation:stationB toStation:stationD];
    [cityB addEdge:[MNEdge edgeWithDuration:@11] fromStation:stationD toStation:stationF];
    
    MNRoute *resultRoute =  [cityB shortestRouteFromStation:stationA toStation:stationF];
    
    MNRoute *predictedRoute = [MNRoute route];
    
    NSMutableArray *edgesSequence = [NSMutableArray array];
    NSMutableArray *stationsSequence = [NSMutableArray array];
    
    [edgesSequence addObject:[cityB edgeFromStation:stationA toStation:stationC]];
    [edgesSequence addObject:[cityB edgeFromStation:stationC toStation:stationE]];
    [edgesSequence addObject:[cityB edgeFromStation:stationE toStation:stationD]];
    [edgesSequence addObject:[cityB edgeFromStation:stationD toStation:stationF]];
    
    [stationsSequence addObject:stationA];
    [stationsSequence addObject:stationC];
    [stationsSequence addObject:stationE];
    [stationsSequence addObject:stationD];
    [stationsSequence addObject:stationF];
    
    predictedRoute.stationsSequence = stationsSequence;
    predictedRoute.edgesSequence = edgesSequence;
    
    XCTAssertEqualObjects(resultRoute, predictedRoute,  @"Incorrect shortest path from station A to station F");
    XCTAssertEqualObjects(resultRoute.totalDuration, @20,  @"Incorrect smallest duration from station A to station F");
    
}

@end

