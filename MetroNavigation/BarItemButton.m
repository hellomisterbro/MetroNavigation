//
//  RouterDescriptionButton.m
//  MetroNavigation
//
//  Created by Nikita Kirichek on 5/2/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

#import "BarItemButton.h"
#import "UIColor+MNColors.h"

@implementation BarItemButton


- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.tintColor = [UIColor lightGreenMNColor];
        
    }
    return self;
}

@end
