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


// MARK: - Initializers


+ (MNMetro *)metro {
    return [[MNMetro alloc] init];
}


- (instancetype)init {
    self = [super init];
    
    if (self) {
        _edges = [NSMutableArray array];
        _stations = [NSMutableArray array];
        _lines = [NSMutableArray array];
    }
    
    return self;
}

- (id)initWithName:(NSString *)name {
    self = [super init];
    
    if (self) {
        _edges = [NSMutableArray array];
        _stations = [NSMutableArray array];
        _lines = [NSMutableArray array];
        _name = [name copy];
    }
    
    return self;
}

// MARK: - Comparison

- (BOOL)isEqual:(id)other {
    if (other == self) {
        return YES;
    }
    
    if (!other || ![other isKindOfClass:[self class]]) {
        return NO;
    }
    
    return [self isEqualToMetro:other];
}

- (BOOL)isEqualToMetro:(MNMetro *)aMetro {
    if (self == aMetro)
        return YES;
    
    if (![self.ID isEqualToString:aMetro.ID]) {
        return NO;
    }
    
    if (![self.name isEqualToString:aMetro.name]) {
        return NO;
    }
    
    if (![self.edges isEqual:aMetro.edges]) {
        return NO;
    }
    
    if (![self.stations isEqual:aMetro.stations]){
        return NO;
    }
    
    if (![self.lines isEqual:aMetro.lines]){
        return NO;
    }
    
    return YES;
}

// MARK: - NSCoping

- (id)copyWithZone:(NSZone *)zone {
    
    MNMetro *metro = [MNMetro metro];
    
    metro.edges = [[NSArray alloc] initWithArray:self.edges copyItems:YES];
    metro.stations = [[NSArray alloc] initWithArray:self.edges copyItems:YES];
    metro.lines = [[NSArray alloc] initWithArray:self.lines copyItems:YES];
    
    metro.name = self.name;
    metro.ID = self.ID;
    metro.name = self.name;
    
    return metro;
}

// MARK: - NSCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.stations = [aDecoder decodeObjectForKey:@"stations"];
        self.edges = [aDecoder decodeObjectForKey:@"edges"];
        self.ID = [aDecoder decodeObjectForKey:@"ID"];
        self.lines = [aDecoder decodeObjectForKey:@"lines"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.stations forKey:@"stations"];
    [aCoder encodeObject:self.edges forKey:@"edges"];
    [aCoder encodeObject:self.ID forKey:@"ID"];
    [aCoder encodeObject:self.lines forKey:@"lines"];
}



// MARK: - Metro Interaction Methods


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
    
    NSMutableArray *neighboringStations = [NSMutableArray new];
    
    for (MNEdge *edge in self.edges) {
        
        if ([edge containStation:aStation]) {
            
            [neighboringStations addObject:[edge stationOppositeToStation:aStation]];
        }
    }
    
    return neighboringStations;
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

- (MNLine *)lineByNamed:(NSString *)aName {
    
    for (MNLine *line in self.lines) {
        
        if ([line.name isEqualToString:aName]) {
            return line;
        }
    }
    
    return nil;
}

// MARK: - Dijkstra shortestpath algorithm


- (MNRoute *)shortestRouteFromStation:(MNStation *)sourceStation toStation:(MNStation *)targetStation {
    //The smallest amount of time to the origin for each station in the graph
    NSMutableArray <MNStation *> *unvisitedStations = [NSMutableArray arrayWithArray:self.stations];
    
    NSMutableDictionary <NSString *, NSNumber*> *durationFromSource = [NSMutableDictionary dictionaryWithCapacity:self.stations.count];
    
    NSMutableDictionary <NSString *, MNStation*> *previousStationInOptimalPath = [NSMutableDictionary dictionaryWithCapacity:self.stations.count];
    
    
    for (MNStation *station in unvisitedStations) {
        
        [durationFromSource setValue:INFINITY_FOR_SHORTEST_PATH_PROBLEM forKey:station.identifier];
    }
    
    [durationFromSource setValue:@0 forKey:sourceStation.identifier];
    
    MNStation *currentlyExaminedStation = nil;
    
    while ([unvisitedStations count] > 0) {
        
        //check the station that we didnt visit yet and that gives us the minimum duration from source to itself
        MNStation *stationWithMinDuration = [self stationWithMinDurationInDictionary:durationFromSource fromSet:unvisitedStations];
        
        if (stationWithMinDuration == nil) {
            break;
            
        } else {
            
            if ([stationWithMinDuration isEqual:targetStation]) {
                
                currentlyExaminedStation = targetStation;
                break;
                
            } else {
                
                [unvisitedStations removeObject:stationWithMinDuration];
                
                MNStation *previousStation = previousStationInOptimalPath[stationWithMinDuration.identifier];
                MNEdge *edgeFromStationWithMinDurationToItsPrevious = [self edgeFromStation:previousStation toStation:stationWithMinDuration];
                
                for (MNStation *neighboringStation in [self neighboringStationsToStation:stationWithMinDuration]) {
                    
                    NSNumber *alt = @([durationFromSource[stationWithMinDuration.identifier] doubleValue] + [[self durationFromStation:stationWithMinDuration toNeighboringStation:neighboringStation] doubleValue]);
                    
                    NSNumber *durationFromNeighborToOrigin = durationFromSource[neighboringStation.identifier];
                    
                    //Take into account the tranfer
                    MNEdge *edgeFromStationWithMinDurationToNeighbour = [self edgeFromStation:neighboringStation toStation:stationWithMinDuration];
                    if ([edgeFromStationWithMinDurationToNeighbour needsTranserWithEdge:edgeFromStationWithMinDurationToItsPrevious]) {
                        alt = @([alt doubleValue] + [stationWithMinDuration.transferDuration doubleValue]);
                    }
                    
                    if ([durationFromNeighborToOrigin isEqualToNumber:INFINITY_FOR_SHORTEST_PATH_PROBLEM] ||
                        [alt compare:durationFromNeighborToOrigin] == NSOrderedAscending) {
                        
                        [durationFromSource setValue:alt forKey:neighboringStation.identifier];
                        [previousStationInOptimalPath setValue:stationWithMinDuration forKey:neighboringStation.identifier];
                    }
                }
            }
        }
    }
    
    
    if (currentlyExaminedStation == nil || ![currentlyExaminedStation isEqual:targetStation]) {
        
        return nil;
        
    } else {
        
        MNRoute *route = [MNRoute route];
        
        route.metro = self;
        
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

//Returns the line for a station
//IMPORTANT: only works for specific strucure of graph (when one station cannot belong to several lines).
- (MNLine *)lineForStation:(MNStation *)aStation {
    
    for (MNStation *neighboringStation in [self neighboringStationsToStation:aStation]) {
        
        MNEdge *neighboringEdge = [self edgeFromStation:aStation toStation:neighboringStation];
        
        if (!neighboringEdge.isTransferEdge) {
            return [self lineByNamed:[neighboringEdge.lineNames firstObject]];
        }
    }
    
    return nil;
}

@end

