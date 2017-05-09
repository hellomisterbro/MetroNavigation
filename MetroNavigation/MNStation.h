//
//  MNStation.h
//  MetroNavigation
//
//  Created by Nikita Kirichek on 4/15/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MNStation : NSObject <NSCopying, NSCoding>

@property (nonatomic, copy) NSString *name;

//unique station id
@property (nonatomic, copy) NSString *identifier;

//position on the image
@property (nonatomic, strong) NSNumber *posX;
@property (nonatomic, strong) NSNumber *posY;

//duration from line to lin if the station belongs to several lines
@property (nonatomic, strong) NSNumber *transferDuration;

+ (MNStation *)stationWithIdentifier:(NSString *)identifier;

- (instancetype)init NS_UNAVAILABLE;
- (id)initWithIdentifier:(NSString *)identifier NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;

- (BOOL)isEqualToStation:(MNStation *)aStation;

@end
