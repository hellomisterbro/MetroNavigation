//
//  MNStationSearchViewController.h
//  MetroNavigation
//
//  Created by Nikita Kirichek on 5/2/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MNBaseSearchListViewController.h"

#import "MNStation.h"

typedef NS_ENUM(NSUInteger, MNStationToChangeType) {
    MNStationToChangeNone,
    MNStationToChangeStart,
    MNStationToChangeEnd
};

@class MNStationSearchViewController;

@protocol MNStationSearchViewControllerDelegate <NSObject>

- (void)didChooseStation:(MNStation *)station withType:(MNStationToChangeType)stationToChange inViewController:(MNStationSearchViewController *)citySearchViewController;

@end

@interface MNStationSearchViewController : MNBaseSearchListViewController

@property (nonatomic, weak) id <MNStationSearchViewControllerDelegate> delegate;

@property (nonatomic, assign) MNStationToChangeType stationToChangeType;
@property (nonatomic, strong) MNStation *stationToExclude;

@end
