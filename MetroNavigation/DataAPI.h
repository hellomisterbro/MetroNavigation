//
//  DataApi.h
//  MetroNavigation
//
//  Created by Nikita Kirichek on 4/19/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MNMetro.h"

extern NSString *const kKyivMetropolitanName ;
extern NSString *const kKyivMoscowMetropolitanName ;
extern NSString *const kPetersburgMetropolitanName;
extern NSString *const kRigaMetropolitanName;
extern NSString *const kBrusselsMetropolitanName;

@interface DataAPI : NSObject

+ (MNMetro *)metroJSONFile:(NSString *)fileName;
+ (MNMetro *)metroWithName:(NSString *)metroName;
+ (NSString *)imageMetroNameWithMetroName:(NSString *)metroName;
+ (NSArray *)metroNames;
+ (NSDictionary *)metroNamesWithIDs;

@end
