//
//  MetroImage.m
//  MetroNavigation
//
//  Created by Nikita Kirichek on 4/22/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

#import "MetroImageView.h"
#import "DataAPI.h"

#define kRadiousForPin 10.0f

NSString *const kMetroNavigationStartPinName = @"start";
NSString *const kMetroNavigationEndPinName = @"end";
NSString *const kMetroNavigationIntermediatePinName = @"intermediate";

@interface MetroImageView ()

@property (nonatomic, strong) CAShapeLayer* firstPin;
@property (nonatomic, strong) CAShapeLayer* secondPin;

@end

@implementation MetroImageView

//MARK: UIView

- (void)layoutSubviews {
    [self.delegate updatePinsWithMetroImageView:self];
}


//MARK: UIResponder

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint viewTouchPoint = [touch locationInView:self];
    
    CGPoint imageTouchPoint = [self imagePointFromViewPoint:viewTouchPoint];
    
    [self.delegate imageTouchedAtPoint:imageTouchPoint metroImageView:self];
}

//MARK: Image Points Convertions

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


//MARK: Pin Handlers

- (CAShapeLayer *)imageAsLayer:(UIImage *)image withPoint:(CGPoint)point {
    
    CAShapeLayer *circleLayer = [CAShapeLayer layer];
    
    CGFloat radious = kRadiousForPin;
    
    circleLayer.frame = CGRectMake(point.x - radious / 2.0f, point.y - radious / 2.0f, radious, radious);
    
    circleLayer.contents = (id)image.CGImage;
    
    return circleLayer;
}


- (void)addStartPinAtPoint:(CGPoint)point {
    [self removeStartPin];
    
    CGPoint imagePoint = [self viewPointFromImagePoint:point];
    UIImage *image = [UIImage imageNamed:kMetroNavigationStartPinName];
    
    self.firstPin = [self imageAsLayer:image withPoint:imagePoint];
    [self.layer addSublayer:self.firstPin];
}

- (void)addEndPinAtPoint:(CGPoint)point {
    [self removeEndPin];
    
    CGPoint imagePoint = [self viewPointFromImagePoint:point];
    UIImage *image = [UIImage imageNamed:kMetroNavigationEndPinName];
    
    self.secondPin = [self imageAsLayer:image withPoint:imagePoint];
    [self.layer addSublayer:self.secondPin];
    
}

- (void)addInterMediatePinAtPoint:(CGPoint)point {
    CGPoint imagePoint = [self viewPointFromImagePoint:point];
    UIImage *image = [UIImage imageNamed:kMetroNavigationIntermediatePinName];
    
    CALayer *pin = [self imageAsLayer:image withPoint:imagePoint];
    [self.layer addSublayer:pin];

}

- (void)removeStartPin {
    [self.firstPin removeFromSuperlayer];
    self.firstPin = nil;
}

- (void)removeEndPin {
    [self.secondPin removeFromSuperlayer];
    self.secondPin = nil;
}

@end
