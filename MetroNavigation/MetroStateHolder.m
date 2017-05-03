//
//  MetroStateHolder.m
//  MetroNavigation
//
//  Created by Nikita Kirichek on 5/2/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

#import "MetroStateHolder.h"
#import "DataAPI.h"
#import "MNMetro+NSCoding.h"

NSString *const kCityMetroStateKeyForUserDefaults = @"MNCityMetroStateKey";

@implementation MetroStateHolder

@synthesize currentMetroState = _currentMetroState;

+ (MetroStateHolder *)sharedInstance {
    
    static MetroStateHolder *cityMetroStateHolder;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        cityMetroStateHolder = [[MetroStateHolder alloc] init];
    });
    
    return cityMetroStateHolder;
}

- (void)setCurrentMetroState:(MNMetro *)currentMetroState {
    [self storeCurrentMetroState:currentMetroState];
    _currentMetroState = currentMetroState;
}

- (MNMetro *)currentMetroState {
    MNMetro *metroStateToReturn = _currentMetroState;
    
    if ((metroStateToReturn = _currentMetroState) ||
        (metroStateToReturn = [self loadLastStoredMetroState]) ||
        (metroStateToReturn = [self defaultMetroState])) {
        
        _currentMetroState = metroStateToReturn;
        
        return _currentMetroState;
    }
    return nil;
}

- (MNMetro *)loadLastStoredMetroState {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedObject = [defaults objectForKey:kCityMetroStateKeyForUserDefaults];
   
    if (encodedObject) {
        MNMetro *loadedMetro = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
        return loadedMetro;
    }
    
    return nil;
   
}

- (void)storeCurrentMetroState:(MNMetro *)metroToStore {
    
    NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:metroToStore];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:encodedObject forKey:kCityMetroStateKeyForUserDefaults];
    [defaults synchronize];
}

- (MNMetro *)defaultMetroState {
    return [DataAPI metroWithName:kKyivMetropolitanName];
}

@end
