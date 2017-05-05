//
//  MNMetroImageScrollView.m
//  MetroNavigation
//
//  Created by Nikita Kirichek on 4/29/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

#import "MNMetroImageScrollView.h"

@implementation MNMetroImageScrollView


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


- (void)scrollToPoint:(CGPoint)zoomPoint withScale:(CGFloat)scale {
    
    CGRect rectToZoom;
    
    //obviously the resulting size and width will be in scale time smaller than the current ones
    rectToZoom.size.width = CGRectGetWidth(self.frame) / scale;
    rectToZoom.size.height = CGRectGetHeight(self.frame) / scale;
    
    //move rect so passed zoomPoint will be the center of the resulting rect
    rectToZoom.origin.x = zoomPoint.x - (CGRectGetWidth(rectToZoom) / 2.0f);
    rectToZoom.origin.y = zoomPoint.y - (CGRectGetHeight(rectToZoom) / 2.0f);
    
    [self zoomToRect:rectToZoom animated:YES];
}

@end
