//
//  MNMetro+JSON.m
//  MetroNavigation
//
//  Created by Nikita Kirichek on 5/2/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

#import "MNMetro+JSON.h"
#import "MNEdge+JSON.h"

@implementation MNMetro (JSON)

+ (MNMetro *)metroFromJSON:(NSDictionary *)metroJSON {
    
    NSString *ID = metroJSON[@"id"];
    NSString *name = metroJSON[@"name"];
    NSArray *edges = metroJSON[@"edges"];
    
    MNMetro *metro = [[MNMetro alloc] initWithName:name];
    
    metro.ID = ID;
    
    for (id object in edges) {
        MNEdge *edge = [MNEdge edgeFromJSON:object];
        [metro addEdge:edge fromStation:edge.firstStation toStation:edge.secondStation];
    }
    
    return metro;
}


@end
