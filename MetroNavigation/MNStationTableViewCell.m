//
//  MNStationTableViewCell.m
//  MetroNavigation
//
//  Created by Nikita Kirichek on 5/2/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

#import "MNStationTableViewCell.h"
#import "UIColor+MNColors.h"

@implementation MNStationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [UITableViewCell appearance].tintColor = [UIColor lightGreenMNColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    self.accessoryType = selected ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    
    self.accessoryView.tintColor = [UIColor lightGreenMNColor];
}

@end
