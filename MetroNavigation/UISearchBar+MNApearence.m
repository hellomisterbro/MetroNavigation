//
//  UISearchBar+MNApearence.m
//  MetroNavigation
//
//  Created by Nikita Kirichek on 5/5/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

#import "UISearchBar+MNApearence.h"
#import "UIColor+MNColors.h"

@implementation UISearchBar (MNAppearance)

- (void)configCustomMNApearence; {
    self.barTintColor = [UIColor lightGreenMNColor];
    self.backgroundColor = [UIColor whiteColor];
    self.translucent = NO;
}

@end
