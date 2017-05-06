//
//  UIColor+CustomColors.m
//  MetroNavigation
//
//  Created by Nikita Kirichek on 5/1/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

#import "UIColor+MNColors.h"
#import "MNColor.h"

@implementation UIColor (MNColors)

+ (UIColor *)lightGreenMNColor {
    
     UIColor *lightBlueMNColor= [UIColor colorWithRed:80.0f / 255.0f
                                                green:227.0f / 255.0f
                                                 blue:194.0f / 255.0f
                                                alpha:1.0f];

    return lightBlueMNColor;
}

+ (UIColor *)colorWithMNColor:(MNColor *)aColor {
    
    UIColor *color= [UIColor colorWithRed:[aColor.red floatValue] / 255.0f
                                    green:[aColor.green floatValue] / 255.0f
                                     blue:[aColor.blue floatValue] / 255.0f
                                    alpha:1.0f];
    return color;
}

@end
