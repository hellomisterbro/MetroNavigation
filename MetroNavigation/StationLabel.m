//
//  StationLabel.m
//  MetroNavigation
//
//  Created by Nikita Kirichek on 4/29/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

#import "StationLabel.h"
#import "UIColor+MNColors.h"

@implementation StationLabel


- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.backgroundColor = [UIColor lightBlueMNColor];
        self.layer.cornerRadius = 5;
        self.layer.shadowOffset = CGSizeMake(0, -0.5);
        self.layer.shadowRadius = 1;
        self.layer.shadowOpacity = 0.3;
        self.textColor = [UIColor whiteColor];
        self.clipsToBounds = YES;
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
