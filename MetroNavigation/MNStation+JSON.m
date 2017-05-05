//
//  MNStation+JSON.m
//  MetroNavigation
//
//  Created by Nikita Kirichek on 5/2/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

#import "MNStation+JSON.h"

@implementation MNStation (JSON)

+ (MNStation *)stationFromJSON:(NSDictionary *)jsonStation {
    
    MNStation *station = [[MNStation alloc] initWithIdentifier:jsonStation[@"id"]];
    
    station.name = jsonStation[@"name"];
    station.posX = jsonStation[@"posX"];
    station.posY = jsonStation[@"posY"];
    
    return station;
}

@end
