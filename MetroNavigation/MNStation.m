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
    
    MNStation *station = [[MNStation alloc] initWithNameIdentifier:jsonStation[@"name"]];
    
    station.posX = jsonStation[@"posX"];
    station.posY = jsonStation[@"posY"];
    
    return station;
}

#pragma mark - Class methods

+ (MNStation *)stationWithNameIdentifier:(NSString *)name {
    return [[MNStation alloc] initWithNameIdentifier:name];
}

#pragma mark - Instance methods

- (id)initWithNameIdentifier:(NSString *)name {
    self = [super init];
    
    if (self) {
        _nameIdentifier = [name copy];
    }
    
    return self;
}

- (BOOL)isEqualToStation:(MNStation *)aStation {
    if (self == aStation)
        return YES;
    
    if (![self.nameIdentifier isEqualToString:aStation.nameIdentifier])
        return NO;
    
    return YES;
}




@end
