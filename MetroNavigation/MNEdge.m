//
//  MNEdge.m
//  MetroNavigation
//
//  Created by Nikita Kirichek on 4/15/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

#import "MNEdge.h"

@implementation MNEdge


#pragma mark - NSObject

- (BOOL)isEqual:(id)other {
    if (other == self)
        return YES;
    
    if (!other || ![other isKindOfClass:[self class]])
        return NO;
    
    return [self isEqualToEdge:other];
}


- (NSString *)description {
    
    return [NSString stringWithFormat:@"%@ - %@ [%@]",
            self.firstStation.identifier,
            self.secondStation.identifier,
            self.duration];
}


#pragma mark - Class methods

+ (MNEdge *)edgeFromJSON:(NSMutableDictionary *)edgeJSON {
    
    MNEdge *edge = [MNEdge edgeWithDuration:@([edgeJSON[@"duration"] doubleValue])];
    
    edge.firstStation = [MNStation stationFromJSON:edgeJSON[@"first"]];
    edge.secondStation = [MNStation stationFromJSON:edgeJSON[@"second"]];
    
    return edge;
}

+ (MNEdge *)edgeWithDuration:(NSNumber *)duration  {
    return [[MNEdge alloc] initWithDuration:duration];
}


#pragma mark - Instance methods

- (id)initWithDuration:(NSNumber *)duration {
    self = [super init];
    
    if (self) {
        _duration = duration;
    }
    
    return self;
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
