//
//  CityButton.m
//  MetroNavigation
//
//  Created by Nikita Kirichek on 5/2/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

#import "CityButton.h"
#import "UIColor+MNColors.h"

@implementation CityButton

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.backgroundColor = [UIColor lightGreenMNColor];
        self.tintColor = [UIColor whiteColor];
        self.layer.cornerRadius = 5;
        self.clipsToBounds = YES;
    }
    return self;
}
@end
