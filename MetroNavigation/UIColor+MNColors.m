//
//  UIColor+CustomColors.m
//  MetroNavigation
//
//  Created by Nikita Kirichek on 5/1/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

#import "UIColor+MNColors.h"

@implementation UIColor (MNColors)

+ (UIColor *)lightBlueMNColor {
    
    static UIColor *lightBlueMNColor;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        lightBlueMNColor = [UIColor colorWithRed:80.0f / 255.0f
                                           green:227.0f / 255.0f
                                            blue:194.0f / 255.0f
                                           alpha:1.0f];
    });
    
    return lightBlueMNColor;
}

@end
