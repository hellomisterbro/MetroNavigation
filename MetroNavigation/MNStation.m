//
//  MNStation.m
//  MetroNavigation
//
//  Created by Nikita Kirichek on 4/15/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

#import "MNStation.h"

@implementation MNStation

// MARK: - Initializers

- (id)initWithIdentifier:(NSString *)identifier {
    self = [super init];
    
    if (self) {
        _identifier = [identifier copy];
    }
    
    return self;
}

+ (MNStation *)stationWithIdentifier:(NSString *)identifier {
    return [[MNStation alloc] initWithIdentifier:identifier];
}

// MARK: - Comparison

- (BOOL)isEqual:(id)other {
    if (other == self) {
        return YES;
    }
    
    if (!other || ![other isKindOfClass:[self class]]) {
        return NO;
    }
    
    return [self isEqualToStation:other];
}

- (BOOL)isEqualToStation:(MNStation *)aStation {
    if (self == aStation){
        return YES;
    }
    
    if (![self.identifier isEqualToString:aStation.identifier]) {
        return NO;
    }
    
    return YES;
}

// MARK: - NSCoping

- (id)copyWithZone:(NSZone *)zone {
    MNStation *station = [MNStation stationWithIdentifier:self.identifier];
    
    station.name = self.name;
    station.posX = self.posX;
    station.posY = self.posY;
    station.transferDuration = self.transferDuration;
    
    return station;
}

// MARK: - NSCodying

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.identifier = [aDecoder decodeObjectForKey:@"identifier"];
        self.posX = [aDecoder decodeObjectForKey:@"posX"];
        self.posY = [aDecoder decodeObjectForKey:@"posY"];
        self.transferDuration = [aDecoder decodeObjectForKey:@"transferDuration"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.identifier forKey:@"identifier"];
    [aCoder encodeObject:self.posX forKey:@"posX"];
    [aCoder encodeObject:self.posY forKey:@"posY"];
    [aCoder encodeObject:self.transferDuration forKey:@"transferDuration"];
}

@end
