//
//  MNRouteDetailsViewController.h
//  MetroNavigation
//
//  Created by Nikita Kirichek on 5/6/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MNRoute.h"
#import "MNDurationDescriptionLabel.h"

@interface MNRouteDetailsViewController : UITableViewController

@property (nonatomic, strong) MNRoute *route;
@property (weak, nonatomic) IBOutlet MNDurationDescriptionLabel *totalDurationLabel;

@end
