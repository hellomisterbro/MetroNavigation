//
//  MNLine.h
//  MetroNavigation
//
//  Created by Nikita Kirichek on 5/5/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MNColor.h"

@interface MNLine : NSObject <NSCopying>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) MNColor *color;

@end
