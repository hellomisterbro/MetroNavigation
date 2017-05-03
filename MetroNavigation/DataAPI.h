//
//  DataApi.h
//  MetroNavigation
//
//  Created by Nikita Kirichek on 4/19/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MNMetro.h"

extern NSString *const kKyivMetropolitanIdentifier;
extern NSString *const kMoscowMetropolitanIdentifier;
extern NSString *const kPetersburgMetropolitanIdentifier;
extern NSString *const kRigaMetropolitanIdentifier;
extern NSString *const kBrusselsMetropolitanIdentifier;


@interface DataAPI : NSObject

+ (MNMetro *)metroJSONFile:(NSString *)fileName;
+ (MNMetro *)metroWithIdentifier:(NSString *)metroIdentifier;
+ (NSString *)imageMetroNameWithMetroIdentifier:(NSString *)metroName;
+ (NSDictionary *)metroNamesWithIDs;

@end
