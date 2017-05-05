//
//  MNMetroStateHolder.h
//  MetroNavigation
//
//  Created by Nikita Kirichek on 5/2/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MNMetro.h"

@interface MNMetroStateHolder : NSObject

@property (nonatomic, copy) MNMetro *currentMetroState;

+ (MNMetroStateHolder *)sharedInstance;

@end
