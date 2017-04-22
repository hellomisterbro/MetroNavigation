//
//  MNMetro.m
//  MetroNavigation
//
//  Created by Nikita Kirichek on 4/15/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

#import "MNMetro.h"
#import "MNEdge.h"
#import <math.h>

#define INFINITY_FOR_SHORTEST_PATH_PROBLEM @(-1)

@implementation MNMetro


#pragma mark - NSObject

- (instancetype)init {
    
    self = [super init];
    
    if (self) {
        
        _edges = [NSMutableArray array];
        _stations = [NSMutableArray array];
    }
    
    return self;
}

- (BOOL)isEqual:(id)other {
    
    if (other == self)
        return YES;
    
    if (!other || ![other isKindOfClass:[self class]])
        return NO;
    
    return [self isEqualToMetro:other];
}


#pragma mark - Class methods

+ (MNMetro *)metro {
    return [[MNMetro alloc] init];
}

+ (MNMetro *)metroFromJSON:(NSDictionary *)metroJSON {
    
    NSString *name = metroJSON[@"name"];
    NSArray *edges = metroJSON[@"edges"];
    
    MNMetro *metro = [[MNMetro alloc] initWithName:name];
    
    for (id object in edges) {
        MNEdge *edge = [MNEdge edgeFromJSON:object];
        [metro addEdge:edge fromStation:edge.firstStation toStation:edge.secondStation];
    }
    
    return metro;
}


#pragma mark - Instance methods

- (id)initWithName:(NSString *)name {
    
    self = [super init];
    
    if (self) {
        
        _edges = [NSMutableArray array];
        _stations = [NSMutableArray array];
        _name = [name copy];
    }
    
    return self;
}

- (BOOL)isEqualToMetro:(MNMetro *)aMetro {
    if (self == aMetro)
        return YES;
    
    if (![self.name isEqualToString:aMetro.name])
        return NO;
    
    if (![self.edges isEqual:aMetro.edges])
        return NO;
    
    if (![self.stations isEqual:aMetro.stations])
        return NO;
    
    return YES;
}

- (MNStation *)stationWithImagePositionX:(double)x positionY:(double)y radious:(double)radious {
    
    for (MNStation *station in self.stations) {
        
        BOOL doesFitCircle = (pow(x - [station.posX doubleValue], 2) + pow(y - [station.posY doubleValue], 2)) < pow(radious, 2);
        
        if (doesFitCircle) {
            
            return station;
        }
    }
    
    return nil;
}

- (void)addEdge:(MNEdge *)anEdge fromStation:(MNStation *)aStation toStation:(MNStation *)anotherStation {
    
    if ([aStation isEqual:anotherStation] ||
        [self edgeFromStation:aStation toStation:anotherStation]) {
        return;
    }
    
    anEdge.firstStation = aStation;
    anEdge.secondStation = anotherStation;
    
    if (![self.stations containsObject:aStation]) {
        self.stations = [self.stations arrayByAddingObject:aStation];
    }
    
    if (![self.stations containsObject:anotherStation]) {
        self.stations = [self.stations arrayByAddingObject:anotherStation];
    }

    self.edges = [self.edges arrayByAddingObject:anEdge];
}

- (NSArray *)neighboringStationsToStation:(MNStation *)aStation {
    
    NSMutableArray *relatedStations = [NSMutableArray new];
    
    for (MNEdge *edge in self.edges) {
        
        if ([edge containStation:aStation]) {
            
            [relatedStations addObject:[edge stationOppositeToStation:aStation]];
        }
    }
    
    return relatedStations;
}

- (MNEdge *)edgeFromStation:(MNStation *)aStation toStation:(MNStation *)anotherStation {
    
    for (MNEdge *edge in self.edges) {
        
        if ([edge containStation:aStation] && [edge containStation:anotherStation]) {
            
            return edge;
        }
    }
    
    return nil;
}

- (NSNumber *)durationFromStation:(MNStation *)sourceStation toNeighboringStation:(MNStation *)targetStation
{
    MNEdge *graphEdge = [self edgeFromStation:sourceStation toStation:targetStation];

    return (graphEdge) ? graphEdge.duration : nil;
}


- (MNRoute *)shortestRouteFromStation:(MNStation *)sourceStation toStation:(MNStation *)targetStation {
    
    //The smallest amount of time to the origin for each station in the graph
    NSMutableArray *unvisitedStations = [NSMutableArray arrayWithArray:self.stations];
    
    NSMutableDictionary *durationFromSource = [NSMutableDictionary dictionaryWithCapacity:self.stations.count];
    
    NSMutableDictionary *previousStationInOptimalPath = [NSMutableDictionary dictionaryWithCapacity:self.stations.count];
    
    
    for (MNStation *station in unvisitedStations) {
        
        [durationFromSource setValue:INFINITY_FOR_SHORTEST_PATH_PROBLEM forKey:station.identifier];
    }
    
    [durationFromSource setValue:@0 forKey:sourceStation.identifier];
    
    MNStation *currentlyExaminedStation = nil;
    
    while ([unvisitedStations count] > 0) {
        
        MNStation *stationWithMinDuration = [self stationWithMinDurationInDictionary:durationFromSource fromSet:unvisitedStations];
        
        if (stationWithMinDuration == nil) {
            
            break;
            
        } else {
            
            if ([stationWithMinDuration isEqual:targetStation]) {
                
                currentlyExaminedStation = targetStation;
                break;
                
            } else {
                
                [unvisitedStations removeObject:stationWithMinDuration];
                
   
                for (MNStation *neighboringStation in [self neighboringStationsToStation:stationWithMinDuration]) {
                    
                    NSNumber *alt = [NSNumber numberWithFloat:
                                     [[durationFromSource objectForKey:stationWithMinDuration.identifier] floatValue] +
                                     [[self durationFromStation:stationWithMinDuration toNeighboringStation:neighboringStation] floatValue]];
                    
                    NSNumber *durationFromNeighborToOrigin = [durationFromSource objectForKey:neighboringStation.identifier];
                    
                    if ([durationFromNeighborToOrigin isEqualToNumber:INFINITY_FOR_SHORTEST_PATH_PROBLEM] ||
                        [alt compare:durationFromNeighborToOrigin] == NSOrderedAscending) {
                        
                        [durationFromSource setValue:alt forKey:neighboringStation.identifier];
                        [previousStationInOptimalPath setValue:stationWithMinDuration forKey:neighboringStation.identifier];
                    }
                }
            }
        }
    }
    
    if ( currentlyExaminedStation == nil || ! [currentlyExaminedStation isEqual:targetStation]) {
        
        return nil;
        
    } else {

        MNRoute *route = [MNRoute route];
        
        NSMutableArray *stationsSequence = [route.stationsSequence mutableCopy];
        NSMutableArray *edgesSequence = [route.edgesSequence mutableCopy];
        
        MNStation *lastStepStation = targetStation;
        MNStation *currentStation;
        
        [stationsSequence addObject:targetStation];
        
        while ((currentStation = [previousStationInOptimalPath objectForKey:lastStepStation.identifier])) {
            
            MNEdge* edgerFromLastToPrevious = [self edgeFromStation:lastStepStation toStation:currentStation];
            
            [edgesSequence insertObject:edgerFromLastToPrevious atIndex:0];
            [stationsSequence insertObject:currentStation atIndex:0];
            
            lastStepStation = currentStation;
        }
        
        route.stationsSequence = stationsSequence;
        route.edgesSequence = edgesSequence;
        
        return route;
    }
    
}

- (MNStation *)stationWithMinDurationInDictionary:(NSDictionary *)durationFromSource fromSet:(NSArray *)stations {
    
    MNStation *resultStation;
    NSNumber *minimumDistance;
    
    for (MNStation *station in stations) {
        
        NSNumber *currentTestValue = [durationFromSource objectForKey:station.identifier];
        
        if (![currentTestValue isEqualToNumber:INFINITY_FOR_SHORTEST_PATH_PROBLEM]) {
            
            if (minimumDistance == nil || [minimumDistance compare:currentTestValue] == NSOrderedDescending) {
                
                resultStation = station;
                minimumDistance = currentTestValue;
            }
        }
    }
    
    return resultStation;
}

@end

