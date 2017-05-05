//
//  MNColor+JSON.m
//  MetroNavigation
//
//  Created by Nikita Kirichek on 5/5/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

#import "MNColor+JSON.h"

@implementation MNColor (JSON)

+ (MNColor *)colorFromJSON:(NSDictionary *)colorJSON {
    
    MNColor *color = [MNColor new];
    
    color.red = colorJSON[@"red"];
    color.green = colorJSON[@"green"];
    color.blue = colorJSON[@"blue"];
    
    return color;
}


@end
