//
//  MNEdge.m
//  MetroNavigation
//
//  Created by Nikita Kirichek on 4/15/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

#import "MNEdge.h"

@implementation MNEdge

#pragma mark - Initializers

+ (MNEdge *)edgeWithDuration:(NSNumber *)duration  {
    return [[MNEdge alloc] initWithDuration:duration];
}

- (id)initWithDuration:(NSNumber *)duration {
   
    self = [super init];
    
    if (self) {
        _duration = duration;
    }
    
    return self;
}

#pragma mark - Comparison

- (BOOL)isEqual:(id)other {
   
    if (other == self) {
        return YES;
    }
    
    if (!other || ![other isKindOfClass:[self class]]) {
        return NO;
    }
    
    return [self isEqualToEdge:other];
}

- (BOOL)isEqualToEdge:(MNEdge *)anEdge {
   
    if (self == anEdge){
        return YES;
    }
    
    if (![self.firstStation isEqual:anEdge.firstStation] &&
        ![self.firstStation isEqual:anEdge.secondStation]) {
        return NO;
    }
    
    if (![self.secondStation isEqual:anEdge.secondStation] &&
        ![self.secondStation isEqual:anEdge.firstStation]) {
        return NO;
    }
    
    if (![self.duration isEqual:anEdge.duration]) {
        return NO;
    }
    
    return YES;
}

#pragma mark - NSCoping

- (id)copyWithZone:(NSZone *)zone {
   
    MNEdge *edge = [MNEdge edgeWithDuration:self.duration];
    
    edge.firstStation = self.firstStation;
    edge.secondStation = self.secondStation;
    
    return edge;
}

#pragma mark - Description

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ - %@ [%@]",
            self.firstStation.identifier,
            self.secondStation.identifier,
            self.duration];
}

#pragma mark - Graph Interction

- (MNStation *)stationOppositeToStation:(MNStation *)aStation {
    
    if ([aStation isEqual:_firstStation]) {
        return _secondStation;
        
    } else if ([aStation isEqual:_secondStation]) {
        return _firstStation;
    }
    
    return nil;
}

- (BOOL)containStation:(MNStation *)aStation {
    
    if ([aStation isEqual:_firstStation] ||
        [aStation isEqual:_secondStation]) {
        
        return YES;
    }
    
    return NO;
}




@end
