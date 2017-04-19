//
//  MNMetro.h
//  MetroNavigation
//
//  Created by Nikita Kirichek on 4/15/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MNStation.h"
#import "MNEdge.h"
#import "MNRoute.h"


@interface MNMetro : NSObject

@property (nonatomic, copy) NSArray *edges;
@property (nonatomic, copy) NSArray *stations;
@property (nonatomic, copy) NSString *name;

+ (MNMetro *)metro;
+ (MNMetro *)metroFromJSON:(NSDictionary *)metroJSON;

- (id)initWithName:(NSString *)name;
- (void)addEdge:(MNEdge *)anEdge fromStation:(MNStation *)aStation toStation:(MNStation *)anotherStation;
- (NSArray *)neighboringStationsToStation:(MNStation *)aStation;
- (MNEdge *)edgeFromStation:(MNStation *)aStation toStation:(MNStation *)anotherStation;
- (NSNumber *)durationFromStation:(MNStation *)sourceStation toNeighboringStation:(MNStation *)targetStation;
- (MNRoute *)shortestRouteFromStation:(MNStation *)sourceStation toStation:(MNStation *)targetStation;

@end
