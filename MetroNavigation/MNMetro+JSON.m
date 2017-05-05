//
//  MNMetro+JSON.m
//  MetroNavigation
//
//  Created by Nikita Kirichek on 5/2/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

#import "MNMetro+JSON.h"
#import "MNEdge+JSON.h"
#import "MNLine+JSON.h"

@implementation MNMetro (JSON)

+ (MNMetro *)metroFromJSON:(NSDictionary *)metroJSON {
    
    NSString *ID = metroJSON[@"id"];
    NSString *name = metroJSON[@"name"];
    NSArray *edges = metroJSON[@"edges"];
    NSArray *lines = metroJSON[@"lines"];
    
    MNMetro *metro = [[MNMetro alloc] initWithName:name];
    
    metro.ID = ID;
    
    for (NSDictionary *edgeDictionary in edges) {
        MNEdge *edge = [MNEdge edgeFromJSON:edgeDictionary];
        [metro addEdge:edge fromStation:edge.firstStation toStation:edge.secondStation];
    }
    
    NSMutableArray *resultLines = [NSMutableArray array];
    
    for (NSDictionary *lineDictionary in lines) {
        MNLine *line = [MNLine lineFromJSON:lineDictionary];
        [resultLines addObject:line];
    }
    
    return metro;
}


@end
