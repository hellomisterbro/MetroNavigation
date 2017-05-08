//
//  MNStationTableViewCell.h
//  MetroNavigation
//
//  Created by Nikita Kirichek on 5/2/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MNCircleHolder.h"

@interface MNStationTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *stationNameLabel;
@property (weak, nonatomic) IBOutlet MNCircleHolder *circleHolderView;

@end
