//
//  MNMetro+JSON.h
//  MetroNavigation
//
//  Created by Nikita Kirichek on 5/2/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

#import "MNMetro.h"

@interface MNMetro (JSON)

+ (MNMetro *)metroFromJSON:(NSDictionary *)metroJSON;

@end
