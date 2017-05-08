//
//  MNCircleHolder.m
//  MetroNavigation
//
//  Created by Nikita Kirichek on 5/8/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

#import "MNCircleHolder.h"

const int kIndentValueForCircles = 4;

@interface MNCircleHolder()

@property (nonatomic, strong) NSMutableArray <UIColor *> *circles;
@property (nonatomic, strong) NSNumber *startValueForWidthContstaint;

@end

@implementation MNCircleHolder

- (void)awakeFromNib {
    [super awakeFromNib];
    self.circles = [NSMutableArray array];
    self.startValueForWidthContstaint = @(self.widthConstraint.constant);
}

- (void)drawRect:(CGRect)rect {
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    rect.size.width = rect.size.width / self.circles.count - kIndentValueForCircles;
    
    CGFloat x = 0;

    for (UIColor *color in self.circles) {
        
        rect.origin.x = x;
        
        CGContextAddEllipseInRect(ctx, rect);
        CGContextSetFillColor(ctx, CGColorGetComponents(color.CGColor));
        CGContextFillPath(ctx);
        
        x += rect.size.width + kIndentValueForCircles;
    }
}

- (void)addCircleWithColor:(UIColor *)color {
    [self.circles addObject:color];

        
    self.widthConstraint.constant = ([self.startValueForWidthContstaint floatValue] + kIndentValueForCircles) * self.circles.count;
    
    [self layoutIfNeeded];
    [self setNeedsDisplay];
}

- (void)removeAllColors {
    
    self.layer.sublayers = nil;
    [self.circles removeAllObjects];
}

@end
