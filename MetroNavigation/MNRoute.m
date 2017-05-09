//
//  MNRoute.m
//  MetroNavigation
//
//  Created by Nikita Kirichek on 4/17/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

#import "MNRoute.h"
#import "MNStation.h"
#import "MNEdge.h"

@implementation MNRoute


// MARK: - NSObject

- (instancetype)init {
    self = [super init];
    if (self) {
        _stationsSequence = [NSMutableArray array];
        _edgesSequence = [NSMutableArray array];
    }
    return self;
}

- (BOOL)isEqual:(id)other {
    if (other == self)
        return YES;
    
    if (!other || ![other isKindOfClass:[self class]])
        return NO;
    
    return [self isEqualToRoute:other];
}

// MARK: - Class Methods

+ (MNRoute *)route {
    return [[MNRoute alloc] init];
}

// MARK: - Instance Methods

- (BOOL)isEqualToRoute:(MNRoute *)aRoute {
    if (self == aRoute){
        return YES;
    }
    
    if (![self.edgesSequence isEqual:aRoute.edgesSequence]) {
        return NO;
    }
    
    if (![self.stationsSequence isEqual:aRoute.stationsSequence]) {
        return NO;
    }
    
    return YES;
}

- (NSNumber *)totalDuration {
    
    double totalDuration = 0;
    
    MNEdge *previousEdge = nil;
    for (MNEdge *currentEdge in self.edgesSequence) {
        
        totalDuration += [currentEdge.duration doubleValue];
        
        if ([previousEdge needsTranserWithEdge:currentEdge]) {
            NSNumber *transferDuration = [previousEdge commonStationWithEdge:currentEdge].transferDuration;
            totalDuration += [transferDuration doubleValue];
        }
        
        previousEdge = currentEdge;
    }
    
    return @(totalDuration);
}

- (NSInteger)totalTransfers {
    
    NSInteger totalTransfersCount = 0;
    
    MNEdge *previousEdge = nil;
    for (MNEdge *currentEdge in self.edgesSequence) {
        
        if (currentEdge.isTransferEdge) {
            totalTransfersCount++;
        }
        
        if ([previousEdge needsTranserWithEdge:currentEdge]) {
            totalTransfersCount++;
        }
        
        previousEdge = currentEdge;
    }
    
    return totalTransfersCount;
}

- (NSArray <MNLineRoute *> *)routeLines {
    
    NSMutableArray <MNLineRoute*> *lineRoutes = [NSMutableArray array];
    
    NSMutableArray *stationsSequence = [self.stationsSequence mutableCopy];
    
    while (stationsSequence.count) {
        
        NSMutableArray *lineStationSequence = [NSMutableArray new];
        
        MNStation *previousStation = nil;
        MNEdge *previousEdge = nil;
        
        MNLineRoute *lineRoute = [MNLineRoute new];
        lineRoute.metro = self.metro;
        
        [lineRoutes addObject:lineRoute];
        
        for (MNStation *currentStation in stationsSequence) {
            
            MNEdge *edgeFromCurrentToPrevious = [self.metro edgeFromStation:currentStation toStation:previousStation];
            
            //transfer found
            if (edgeFromCurrentToPrevious.isTransferEdge) {
                
                lineRoute.stationSequence = lineStationSequence;
                [stationsSequence removeObjectsInArray:lineStationSequence];
                
                lineRoute.line = [self.metro lineForStation:previousStation];
                
                lineRoute.transferToNextDuration = edgeFromCurrentToPrevious.duration;
                
                break;
            }
            
            //transfer found
            if ([edgeFromCurrentToPrevious needsTranserWithEdge:previousEdge]) {
                lineRoute.stationSequence = lineStationSequence;
                [stationsSequence removeObjectsInArray:lineStationSequence];
                [stationsSequence insertObject:previousStation atIndex:0];
                
                lineRoute.line = [self.metro lineNamed:[previousEdge.lineNames firstObject]];
                
                lineRoute.transferToNextDuration = previousStation.transferDuration;
                
                break;
            }
            
            [lineStationSequence addObject:currentStation];
            
            if ([currentStation isEqual:stationsSequence.lastObject]) {
                [stationsSequence removeObjectsInArray:lineStationSequence];
                lineRoute.stationSequence = lineStationSequence;
                
                //if no previous, connect it to the station that  
                if (!previousStation) {
                    previousStation = lineRoutes.lastObject.stationSequence.lastObject;
                    edgeFromCurrentToPrevious = [self.metro edgeFromStation:currentStation toStation:previousStation];;
                }
                
                if (edgeFromCurrentToPrevious.isTransferEdge) {
                    
                    lineRoute.line = [self.metro lineForStation:previousStation];
                    
                } else {
                    
                    lineRoute.line = [self.metro lineNamed:[edgeFromCurrentToPrevious.lineNames firstObject]];
                }
            }
            
            previousStation = currentStation;
            previousEdge = edgeFromCurrentToPrevious;
        }
        
    }
    
    return lineRoutes;
}

@end

