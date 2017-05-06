//
//  MNRoute.h
//  MetroNavigation
//
//  Created by Nikita Kirichek on 4/17/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MNStation.h"
#import "MNEdge.h"
#import "MNLineRoute.h"
#import "MNMetro.h"

@class MNMetro;
@class MNLineRoute;

@interface MNRoute : NSObject

@property (nonatomic, copy) NSArray <MNStation *> *stationsSequence;
@property (nonatomic, copy) NSArray <MNEdge *> *edgesSequence;
@property (nonatomic, copy) MNMetro *metro;

+ (MNRoute *)route;
- (NSNumber *)totalDuration;
- (NSInteger)totalTransfers;
- (NSArray <MNLineRoute *> *)lineRoutes;

@end
