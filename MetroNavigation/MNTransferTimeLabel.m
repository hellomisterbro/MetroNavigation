//
//  MNTransferTimeLabel.m
//  MetroNavigation
//
//  Created by Nikita Kirichek on 5/7/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

#import "MNTransferTimeLabel.h"

@implementation MNTransferTimeLabel

- (void)setTransferDuration:(NSNumber *)aTransferDuration {
    self.text = [NSString stringWithFormat:@"+ %.2f mins", [aTransferDuration doubleValue]];
}

@end
