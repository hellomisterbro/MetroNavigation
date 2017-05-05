//
//  MNLine+JSON.m
//  MetroNavigation
//
//  Created by Nikita Kirichek on 5/5/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

#import "MNLine+JSON.h"
#import "MNColor+JSON.h"

@implementation MNLine (JSON)

+ (MNLine *)lineFromJSON:(NSDictionary *)lineJSON {

    MNLine *line = [MNLine new];

    line.name = lineJSON[@"name"];
    
    NSDictionary *colorDictionary = lineJSON[@"color"];
    line.color = [MNColor colorFromJSON:colorDictionary];;

    return line;
}

@end
