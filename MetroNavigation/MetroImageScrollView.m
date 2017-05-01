//
//  MetroImageScrollView.m
//  MetroNavigation
//
//  Created by Nikita Kirichek on 4/29/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

#import "MetroImageScrollView.h"

@implementation MetroImageScrollView


- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        self.maximumZoomScale = 5.0;
    }
    return self;
}


- (CGFloat)scaleAfterZoomingToRect:(CGRect)rect {
    
    CGFloat ratio = CGRectGetHeight(self.frame) / CGRectGetHeight(rect);
    CGFloat scale = (ratio < self.maximumZoomScale) ? ratio : self.maximumZoomScale;
    
    return scale;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
