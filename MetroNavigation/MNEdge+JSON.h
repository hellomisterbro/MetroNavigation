//
//  MNEdge+JSON.h
//  MetroNavigation
//
//  Created by Nikita Kirichek on 5/2/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

#import "MNStation.h"
#import "MNEdge.h"

@interface MNEdge (JSON)

+ (MNEdge *)edgeFromJSON:(NSDictionary *)edgeJSON;

@end
