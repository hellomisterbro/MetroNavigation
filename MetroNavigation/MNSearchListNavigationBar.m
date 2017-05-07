//
//  MNSearchListNavigationBar.m
//  MetroNavigation
//
//  Created by Nikita Kirichek on 5/5/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

#import "MNSearchListNavigationBar.h"
#import "UIColor+MNColors.h"

@implementation MNSearchListNavigationBar


- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.barTintColor = [UIColor lightGreenMNColor];
    self.tintColor = [UIColor whiteColor];
    [self setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
}

@end
