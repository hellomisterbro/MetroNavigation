//
//  MNStationSearchViewController.h
//  MetroNavigation
//
//  Created by Nikita Kirichek on 5/2/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MNBaseSearchListViewController.h"

@class MNStationSearchViewController;

@protocol MNStationSearchViewControllerDelegate <NSObject>

@required
- (void)stationChoosenWithSuccess:(BOOL)success inViewController:(MNStationSearchViewController *)citySearchViewController;

@end

@interface MNStationSearchViewController : MNBaseSearchListViewController

@property (nonatomic, strong) id <MNStationSearchViewControllerDelegate> delegate;

@end
