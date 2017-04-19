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


#pragma mark - NSObject

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


#pragma mark - Class Methods

+ (MNRoute *)route {
    return [[MNRoute alloc] init];
}


#pragma mark - Instance Methods

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
    
    for (MNEdge *edge in self.edgesSequence) {
        totalDuration += [edge.duration doubleValue];
    }
    
    return @(totalDuration);
}

@end
