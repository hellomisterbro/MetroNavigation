//
//  MNStation.m
//  MetroNavigation
//
//  Created by Nikita Kirichek on 4/15/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

#import "MNStation.h"

@implementation MNStation


#pragma mark - NSObject

- (BOOL)isEqual:(id)other {
    if (other == self)
        return YES;
    
    if (!other || ![other isKindOfClass:[self class]])
        return NO;
    
    return [self isEqualToStation:other];
}

+ (MNStation *)stationFromJSON:(NSDictionary *)jsonStation {
    
    MNStation *station = [[MNStation alloc] initWithIdentifier:jsonStation[@"id"]];
    
    station.name = jsonStation[@"name"];
    station.posX = jsonStation[@"posX"];
    station.posY = jsonStation[@"posY"];
    
    return station;
}

#pragma mark - Class methods

+ (MNStation *)stationWithIdentifier:(NSString *)identifier {
    return [[MNStation alloc] initWithIdentifier:identifier];
}

#pragma mark - Instance methods

- (id)initWithIdentifier:(NSString *)identifier {
    self = [super init];
    
    if (self) {
        _identifier = [identifier copy];
    }
    
    return self;
}

- (BOOL)isEqualToStation:(MNStation *)aStation {
    if (self == aStation)
        return YES;
    
    if (![self.identifier isEqualToString:aStation.identifier])
        return NO;
    
    return YES;
}




@end
