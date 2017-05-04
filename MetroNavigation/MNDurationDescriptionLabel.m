//
//  MNDurationDescriptionLabel.m
//  MetroNavigation
//
//  Created by Nikita Kirichek on 5/4/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

#import "MNDurationDescriptionLabel.h"

@implementation MNDurationDescriptionLabel

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.textColor = [UIColor grayColor];
    }
    return self;
}

@end
