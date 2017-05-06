//
//  MNLineRoute.h
//  MetroNavigation
//
//  Created by Nikita Kirichek on 5/6/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MNStation.h"
#import "MNLine.h"
#import "MNMetro.h"

@class MNMetro;

@interface MNLineRoute : NSObject

@property (nonatomic, copy) NSArray<MNStation *> *stationSequence;

@property (nonatomic, copy) MNMetro *metro;
@property (nonatomic, copy) MNLine *line;

@property (nonatomic, strong) NSNumber *duration;
@property (nonatomic, strong) NSNumber *transferToNextDuration;

@end
