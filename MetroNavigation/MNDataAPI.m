//
//  DataApi.m
//  MetroNavigation
//
//  Created by Nikita Kirichek on 4/19/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

#import "MNDataAPI.h"
#import "MNMetro+JSON.h"

#import <UIKit/UIKit.h>

NSString *const kKyivMetropolitanIdentifier = @"911";
NSString *const kMilanoMetropolitanIdentifier = @"100";


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

+ (MNMetro *)metroWithIdentifier:(NSString *)metroIdentifier {
    NSDictionary *filesForNames = @{kKyivMetropolitanIdentifier: @"kyiv",
                                    kMilanoMetropolitanIdentifier : @"milano"};
    
    return [DataAPI metroJSONFile:filesForNames[metroIdentifier]];
}

+ (NSString *)imageMetroNameWithMetroIdentifier:(NSString *)metroName {
    NSDictionary *imagesForNames = @{kKyivMetropolitanIdentifier: @"kyiv-metro",
                                     kMilanoMetropolitanIdentifier : @"milano-metro"};
    
    return imagesForNames[metroName];
}



+ (NSDictionary *)metroNamesWithIDs {
    return @{ @"Kiev Metropolitan": kKyivMetropolitanIdentifier,
              @"Milano Metro": kMilanoMetropolitanIdentifier};
}

@end
