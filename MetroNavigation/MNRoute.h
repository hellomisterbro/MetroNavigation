//
//  MNRoute.h
//  MetroNavigation
//
//  Created by Nikita Kirichek on 4/17/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MNRoute : NSObject

@property (nonatomic, copy) NSArray *stationsSequence;
@property (nonatomic, copy) NSArray *edgesSequence;

+ (MNRoute *)route;
- (NSNumber *)totalDuration;

@end