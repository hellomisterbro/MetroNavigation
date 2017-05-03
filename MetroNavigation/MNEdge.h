//
//  MNEdge.h
//  MetroNavigation
//
//  Created by Nikita Kirichek on 4/15/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MNStation.h"

@interface MNEdge : NSObject <NSCopying>

@property (nonatomic, strong) MNStation *firstStation;
@property (nonatomic, strong) MNStation *secondStation;
@property (nonatomic, strong) NSNumber *duration;

+ (MNEdge *)edgeWithDuration:(NSNumber *)duration;


- (id)initWithDuration:(NSNumber *)duration;
- (BOOL)isEqualToEdge:(MNEdge *)anEdge;
- (MNStation *)stationOppositeToStation:(MNStation *)aStation;
- (BOOL)containStation:(MNStation *)aStation;

@end
