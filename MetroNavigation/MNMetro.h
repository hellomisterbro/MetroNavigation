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
#import "MNColor.h"
#import "MNLine.h"


@interface MNMetro : NSObject <NSCopying>

@property (nonatomic, copy) NSArray <MNEdge *> *edges;
@property (nonatomic, copy) NSArray <MNStation *> *stations;
@property (nonatomic, copy) NSArray<MNLine *> *lines;

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *ID;

+ (MNMetro *)metro;

- (id)initWithName:(NSString *)name;
- (void)addEdge:(MNEdge *)anEdge fromStation:(MNStation *)aStation toStation:(MNStation *)anotherStation;
- (NSArray *)neighboringStationsToStation:(MNStation *)aStation;
- (MNEdge *)edgeFromStation:(MNStation *)aStation toStation:(MNStation *)anotherStation;
- (NSNumber *)durationFromStation:(MNStation *)sourceStation toNeighboringStation:(MNStation *)targetStation;
- (MNRoute *)shortestRouteFromStation:(MNStation *)sourceStation toStation:(MNStation *)targetStation;
- (MNStation *)stationWithImagePositionX:(double)x positionY:(double)y radious:(double)radious;

@end
