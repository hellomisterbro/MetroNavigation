//
//  DataApi.m
//  MetroNavigation
//
//  Created by Nikita Kirichek on 4/19/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

#import "DataAPI.h"
#import "MNMetro+JSON.h"

#import <UIKit/UIKit.h>

NSString *const kKyivMetropolitanName = @"Kyiv";
NSString *const kMoscowMetropolitanName = @"Moscow";
NSString *const kPetersburgMetropolitanName = @"St. Petersburg";
NSString *const kRigaMetropolitanName = @"Riga";
NSString *const kBrusselsMetropolitanName = @"Brussels";

NSString *const kKyivMetropolitanIdentifier = @"101";
NSString *const kMoscowMetropolitanIdentifier = @"102";
NSString *const kPetersburgMetropolitanIdentifier = @"103";
NSString *const kRigaMetropolitanIdentifier = @"104";
NSString *const kBrusselsMetropolitanIdentifier = @"104";


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
//todelete
+ (MNMetro *)metroWithName:(NSString *)metroName {
    NSDictionary *filesForNames = @{kKyivMetropolitanName: @"kyiv",
                                    kMoscowMetropolitanName : @"moscow",
                                    kPetersburgMetropolitanName : @"petersburg",
                                    kRigaMetropolitanName : @"riga",
                                    kBrusselsMetropolitanName : @"brussels"};
   
    return [DataAPI metroJSONFile:filesForNames[metroName]];
}

+ (MNMetro *)metroWithIdentifier:(NSString *)metroIdentifier {
    NSDictionary *filesForNames = @{kKyivMetropolitanIdentifier: @"kyiv",
                                    kMoscowMetropolitanIdentifier : @"moscow",
                                    kPetersburgMetropolitanIdentifier : @"petersburg",
                                    kRigaMetropolitanIdentifier : @"riga",
                                    kBrusselsMetropolitanIdentifier : @"brussels"};
    
    return [DataAPI metroJSONFile:filesForNames[metroIdentifier]];
}

+ (NSString *)imageMetroNameWithMetroIdentifier:(NSString *)metroName {
    NSDictionary *imagesForNames = @{kKyivMetropolitanIdentifier: @"kyiv-metro",
                                     kMoscowMetropolitanIdentifier : @"moscow-metro",
                                     kPetersburgMetropolitanIdentifier : @"petersburg",
                                     kRigaMetropolitanIdentifier : @"riga",
                                     kBrusselsMetropolitanIdentifier : @"brussels"};
    
    return imagesForNames[metroName];
}

//todelete
+ (NSString *)imageMetroNameWithMetroName:(NSString *)metroName {
    NSDictionary *imagesForNames = @{kKyivMetropolitanName: @"kyiv-metro",
                                    kMoscowMetropolitanName : @"moscow-metro",
                                    kPetersburgMetropolitanName : @"petersburg",
                                    kRigaMetropolitanName : @"riga",
                                    kBrusselsMetropolitanName : @"brussels"};
    
    return imagesForNames[metroName];
}


+ (NSArray *)metroNames {
    return @[kKyivMetropolitanName, kMoscowMetropolitanName, kPetersburgMetropolitanName, kBrusselsMetropolitanName];
}

+ (NSDictionary *)metroNamesWithIDs {
    return @{ @"Kiev Metropolitan": kKyivMetropolitanIdentifier,
              @"Moscow Metro": kMoscowMetropolitanIdentifier,
              @"Petersbutg Subway": kPetersburgMetropolitanIdentifier,
              @"Riga": kBrusselsMetropolitanIdentifier,
              @"Brussels": kBrusselsMetropolitanIdentifier};
}

@end
