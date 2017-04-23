//
//  MetroImage.m
//  MetroNavigation
//
//  Created by Nikita Kirichek on 4/22/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

#import "MetroImageView.h"

@implementation MetroImageView


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint viewTouchPoint = [touch locationInView:self];
    
    CGPoint imageTouchPoint = [self imagePointFromViewPoint:viewTouchPoint];
    
    [self.delegate imageTouchedAtPoint:imageTouchPoint metroImageView:self];
}


- (CGPoint)imagePointFromViewPoint:(CGPoint)viewPoint {
    
    CGSize imageSize = self.image.size;
    CGSize viewSize  = self.bounds.size;
    
    CGPoint imagePoint;
    
    if (viewSize.height > viewSize.width) {
        
        CGFloat ratio = imageSize.width / viewSize.width;
        
        CGFloat distanceFromTopToImage = (viewSize.height - imageSize.height / ratio) / 2;
        
        imagePoint.x = viewPoint.x  * ratio;
        imagePoint.y = (viewPoint.y - distanceFromTopToImage)  * ratio;
        
    } else {
        
        CGFloat ratio = imageSize.height / viewSize.height;
        
        CGFloat distanceFromLeadingEdgeToImage = (viewSize.width - imageSize.width / ratio) / 2;
        
        imagePoint.x = (viewPoint.x - distanceFromLeadingEdgeToImage)  * ratio;
        imagePoint.y = viewPoint.y * ratio;
    }
    
    return imagePoint;
}

- (CGPoint)viewPointFromImagePoint:(CGPoint)imagePoint {
    
    CGSize imageSize = self.image.size;
    CGSize viewSize  = self.bounds.size;
    
    CGPoint viewPoint;
    
    if (viewSize.height > viewSize.width) {
        
        CGFloat ratio = imageSize.width / viewSize.width;
        
        CGFloat distanceFromTopToImage = (viewSize.height - imageSize.height / ratio) / 2;
        
        viewPoint.x = imagePoint.x  / ratio;
        viewPoint.y = (imagePoint.y / ratio + distanceFromTopToImage);
        
    } else {
        
        CGFloat ratio = imageSize.height / viewSize.height;
        
        CGFloat distanceFromLeadingEdgeToImage = (viewSize.width - imageSize.width / ratio) / 2;
        
        viewPoint.x = (imagePoint.x / ratio + distanceFromLeadingEdgeToImage) ;
        viewPoint.y = imagePoint.y / ratio;
    }
    
    return viewPoint;
}


- (void)removeCircleOnImage:(CGPoint)point {

}

- (CAShapeLayer *)addCircleOnImageWithPoint:(CGPoint)point {
    
    CGPoint viewPoint = [self viewPointFromImagePoint:point];
    
    CAShapeLayer *circleLayer = [CAShapeLayer layer];

    circleLayer.bounds = self.bounds;
    
    circleLayer.position = CGPointMake(CGRectGetWidth(self.bounds) / 2.0f, CGRectGetHeight(self.bounds) / 2);

    CGFloat radious = 10.0f;
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:
                          CGRectMake(viewPoint.x - radious / 2.0f, viewPoint.y - radious / 2.0f, radious, radious)];

    circleLayer.path = path.CGPath;
    
    circleLayer.strokeColor = [UIColor redColor].CGColor;

    circleLayer.lineWidth = 2.0f;
    
    [self.layer addSublayer:circleLayer];
    
    return circleLayer;
}

- (void)layoutSubviews {
    [self.delegate updatePinsWithMetroImageView:self];
}

@end
