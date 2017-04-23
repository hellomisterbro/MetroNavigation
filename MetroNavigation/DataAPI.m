//
//  DataApi.m
//  MetroNavigation
//
//  Created by Nikita Kirichek on 4/19/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

#import "DataAPI.h"

#import <UIKit/UIKit.h>

NSString *const kKyivMetropolitanFileName = @"kyiv";
NSString *const kKyivMetropolitanImageName = @"kyiv-metro";


@implementation DataAPI

+ (MNMetro *)metroJSONFile:(NSString *)fileName {
    
    NSDataAsset *dataSet = [[NSDataAsset alloc] initWithName:fileName];
    
    NSError *error;
    id json = [NSJSONSerialization JSONObjectWithData:dataSet.data options:NSJSONReadingAllowFragments error:&error];

    if ([json isKindOfClass:[NSDictionary class]]) {
        return [MNMetro metroFromJSON:json];
    }
    
    return nil;
}

@end
