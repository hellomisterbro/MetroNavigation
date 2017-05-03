//
//  RouterDescriptionButton.m
//  MetroNavigation
//
//  Created by Nikita Kirichek on 5/2/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

#import "RouterDescriptionButton.h"
#import "UIColor+MNColors.h"

@implementation RouterDescriptionButton


- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.tintColor = [UIColor lightBlueMNColor];
        
    }
    return self;
}

@end
