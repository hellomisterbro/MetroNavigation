//
//  MNCircleHolder.h
//  MetroNavigation
//
//  Created by Nikita Kirichek on 5/8/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MNCircleHolder : UIView

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *widthConstraint;

- (void)addCircleWithColor:(UIColor *)color;
- (void)removeAllColors;

@end
