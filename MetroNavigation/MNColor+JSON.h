//
//  MNColor+JSON.h
//  MetroNavigation
//
//  Created by Nikita Kirichek on 5/5/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MNColor.h"

@interface MNColor (JSON)

+ (MNColor *)colorFromJSON:(NSDictionary *)colorJSON;

@end
