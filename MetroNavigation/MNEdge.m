//
//  MNEdge.m
//  MetroNavigation
//
//  Created by Nikita Kirichek on 4/15/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

#import "MNEdge.h"

@implementation MNEdge

// MARK: - Initializers

+ (MNEdge *)edgeWithDuration:(NSNumber *)duration  {
    return [[MNEdge alloc] initWithDuration:duration];
}

- (id)initWithDuration:(NSNumber *)duration {
   
    self = [super init];
    
    if (self) {
        _duration = duration;
        _lineNames = [NSArray array];
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

// MARK: - NSCoping

- (id)copyWithZone:(NSZone *)zone {
   
    MNEdge *edge = [MNEdge edgeWithDuration:self.duration];
    
    edge.firstStation = self.firstStation;
    edge.secondStation = self.secondStation;
    edge.duration = self.duration;
    edge.lineNames = self.lineNames;
    
    return edge;
}


// MARK: - NSCodying

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.firstStation = [aDecoder decodeObjectForKey:@"firstStation"];
        self.secondStation = [aDecoder decodeObjectForKey:@"secondStation"];
        self.duration = [aDecoder decodeObjectForKey:@"duration"];
        self.lineNames = [aDecoder decodeObjectForKey:@"lineNames"];
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.firstStation forKey:@"firstStation"];
    [aCoder encodeObject:self.secondStation forKey:@"secondStation"];
    [aCoder encodeObject:self.duration forKey:@"duration"];
    [aCoder encodeObject:self.lineNames forKey:@"lineNames"];
}

// MARK: - Description

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ - %@ [%@]",
            self.firstStation.name,
            self.secondStation.name,
            self.duration];
}

// MARK: - Graph Interction

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

- (MNStation *)commonStationWithEdge:(MNEdge *)aEdge {
    
    if ([self containStation:aEdge.firstStation]) {
        return aEdge.firstStation;
    }
    
    if ([self containStation:aEdge.secondStation]) {
        return aEdge.secondStation;
    }
    
    return nil;
}

- (BOOL)needsTranserWithEdge:(MNEdge *)aEdge {
    
    if (!aEdge) {
        return NO;
    }
    
    NSSet *selfLinesSet = [NSSet setWithArray:self.lineNames];
    NSSet *edgeLinesSet = [NSSet setWithArray:aEdge.lineNames];
    
    return ![selfLinesSet isSubsetOfSet:edgeLinesSet] && ![edgeLinesSet isSubsetOfSet:selfLinesSet];
}

- (BOOL)isTransferEdge {
    return self.lineNames.count > 1;
}

@end
