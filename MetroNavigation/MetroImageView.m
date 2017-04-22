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
    
    [self.delegate imageTouchedAtPoint:imageTouchPoint];
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

- (void)addCircleOnImage:(CGPoint)point {
    
    CGPoint viewPoint = [self viewPointFromImagePoint:point];
    
    CAShapeLayer *circleLayer = [CAShapeLayer layer];

    [circleLayer setBounds:CGRectMake(0.0f, 0.0f, [self bounds].size.width,
                                      [self bounds].size.height)];

    [circleLayer setPosition:CGPointMake([self bounds].size.width/2.0f,
                                         [self bounds].size.height/2.0f)];

    CGFloat raious = 10.0f;
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:
                          CGRectMake(viewPoint.x - raious / 2, viewPoint.y - raious / 2, raious, raious)];

    [circleLayer setPath:[path CGPath]];

    [circleLayer setStrokeColor:[[UIColor redColor] CGColor]];

    [circleLayer setLineWidth:2.0f];
    
    [[self layer] addSublayer:circleLayer];
}


@end
