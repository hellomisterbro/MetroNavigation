//
//  StationButton.m
//  MetroNavigation
//
//  Created by Nikita Kirichek on 5/3/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

#import "StationButton.h"
#import "UIColor+MNColors.h"

@implementation StationButton

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.backgroundColor = [UIColor lightGreenMNColor];
        self.layer.cornerRadius = 5;
        self.layer.shadowOffset = CGSizeMake(0, -0.5);
        self.layer.shadowRadius = 1;
        self.layer.shadowOpacity = 0.3;
        self.tintColor = [UIColor whiteColor];
        self.clipsToBounds = YES;
        
    }
    return self;
}

@end
