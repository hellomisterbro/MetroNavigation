//
//  MNEdge+JSON.m
//  MetroNavigation
//
//  Created by Nikita Kirichek on 5/2/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

#import "MNEdge+JSON.h"
#import "MNStation+JSON.h"

@implementation MNEdge (JSON)

+ (MNEdge *)edgeFromJSON:(NSDictionary *)edgeJSON {
    
    MNEdge *edge = [MNEdge edgeWithDuration:@([edgeJSON[@"duration"] doubleValue])];
    
    edge.firstStation = [MNStation stationFromJSON:edgeJSON[@"first"]];
    edge.secondStation = [MNStation stationFromJSON:edgeJSON[@"second"]];
    
    NSMutableArray *linesNames = [NSMutableArray array];
    
    for (NSString *lineName in edgeJSON[@"line"]) {
        [linesNames addObject:lineName];
    }
    
    edge.lineNames = linesNames;
    
    return edge;
}

@end
