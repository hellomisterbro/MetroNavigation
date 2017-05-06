//
//  MNDetailedRouteForLine.m
//  MetroNavigation
//
//  Created by Nikita Kirichek on 5/6/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

#import "MNLineRoute.h"

@implementation MNLineRoute

- (NSNumber *)duration {
    
    MNStation *previousStation;
    
    double totalDuration = 0;
    
    for (MNStation *currentStation in self.stationSequence) {
        
        totalDuration += [[self.metro durationFromStation:currentStation toNeighboringStation:previousStation] doubleValue];
        previousStation = currentStation;
    }
    
    return @(totalDuration);
}

@end
