//
//  MNTransferTimeLabel.m
//  MetroNavigation
//
//  Created by Nikita Kirichek on 5/7/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

#import "MNTransferTimeLabel.h"
#import "UIColor+MNColors.h"

@implementation MNTransferTimeLabel

- (void)awakeFromNib {
    [super awakeFromNib];
    self.textColor = [UIColor lightGrayColor];
}

- (void)setTransferDuration:(NSNumber *)aTransferDuration {
    self.text = [NSString stringWithFormat:@"+ %.2f mins transfer", [aTransferDuration doubleValue]];
}

@end
