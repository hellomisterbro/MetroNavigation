//
//  MNStation+JSON.h
//  MetroNavigation
//
//  Created by Nikita Kirichek on 5/2/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

#import "MNStation.h"

@interface MNStation (JSON)

+ (MNStation *)stationFromJSON:(NSDictionary *)jsonStation;

@end
