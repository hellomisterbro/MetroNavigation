//
//  StationSearchViewController.h
//  MetroNavigation
//
//  Created by Nikita Kirichek on 5/2/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseSearchListViewController.h"

@class StationSearchViewController;

@protocol StationSearchViewControllerDelegate <NSObject>

@required
- (void)stationChoosenWithSuccess:(BOOL)success inViewController:(StationSearchViewController *)citySearchViewController;

@end

@interface StationSearchViewController : BaseSearchListViewController

@property (nonatomic, strong) id <StationSearchViewControllerDelegate> delegate;

@end
