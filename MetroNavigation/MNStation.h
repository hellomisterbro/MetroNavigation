//
//  MNStation.h
//  MetroNavigation
//
//  Created by Nikita Kirichek on 4/15/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MNStation : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, strong) NSNumber *posX;
@property (nonatomic, strong) NSNumber *posY;

+ (MNStation *)stationWithIdentifier:(NSString *)identifier;
+ (MNStation *)stationFromJSON:(NSDictionary *)jsonStation;

- (id)initWithIdentifier:(NSString *)identifier;
- (BOOL)isEqualToStation:(MNStation *)aStation;

@end
