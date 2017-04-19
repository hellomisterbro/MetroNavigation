//
//  MNStation.h
//  MetroNavigation
//
//  Created by Nikita Kirichek on 4/15/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MNStation : NSObject

@property (nonatomic, copy) NSString *nameIdentifier;
@property (nonatomic, strong) NSNumber *posX;
@property (nonatomic, strong) NSNumber *posY;

+ (MNStation *)stationWithNameIdentifier:(NSString *)name;
+ (MNStation *)stationFromJSON:(NSDictionary *)jsonStation;

- (id)initWithNameIdentifier:(NSString *)name;
- (BOOL)isEqualToStation:(MNStation *)aStation;

@end
