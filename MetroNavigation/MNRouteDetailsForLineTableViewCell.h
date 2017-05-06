//
//  MNRouteDetailsForLineTableViewCell.h
//  MetroNavigation
//
//  Created by Nikita Kirichek on 5/6/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MNDurationDescriptionLabel.h"

@interface MNRouteDetailsForLineTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *metroLineImageView;
@property (weak, nonatomic) IBOutlet UILabel *startStationLabel;
@property (weak, nonatomic) IBOutlet UILabel *endStationLabel;
@property (weak, nonatomic) IBOutlet MNDurationDescriptionLabel *timeDescriptionForLineLabel;
@property (weak, nonatomic) IBOutlet MNDurationDescriptionLabel *timeDescriptionForTransferLabel;

@end
