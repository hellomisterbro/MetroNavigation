//
//  MNStationSearchViewController.h
//  MetroNavigation
//
//  Created by Nikita Kirichek on 5/2/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MNBaseSearchListViewController.h"

typedef NS_ENUM(NSUInteger, MNStationToChange) {
    MNStationToChangeNone,
    MNStationToChangeStart,
    MNStationToChangeEnd
};

@class MNStationSearchViewController;

@protocol MNStationSearchViewControllerDelegate <NSObject>

- (void)stationChoosenWithSuccess:(BOOL)success inViewController:(MNStationSearchViewController *)citySearchViewController;

@end

@interface MNStationSearchViewController : MNBaseSearchListViewController

@property (nonatomic, weak) id <MNStationSearchViewControllerDelegate> delegate;

@property (nonatomic, assign) MNStationToChange stationToChangeType;

@end
