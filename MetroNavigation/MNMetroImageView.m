//
//  MNMetroImage.m
//  MetroNavigation
//
//  Created by Nikita Kirichek on 4/22/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

#import "MNMetroImageView.h"
#import "MNDataAPI.h"

#define kDiameterForPin 10.0f

NSString *const kMetroNavigationStartPinName = @"start";
NSString *const kMetroNavigationEndPinName = @"end";
NSString *const kMetroNavigationIntermediatePinName = @"intermediate";

@interface MNMetroImageView ()

@property (nonatomic, strong) CAShapeLayer* firstPin;
@property (nonatomic, strong) CAShapeLayer* secondPin;
@property (nonatomic, strong) NSMutableArray* intermediatePins;

@end

@implementation MNMetroImageView

//MARK: Initialization code

- (void)awakeFromNib {
    [super awakeFromNib];
    self.intermediatePins = [NSMutableArray new];
}

//MARK: UIResponder

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint viewTouchPoint = [touch locationInView:self];
    
    CGPoint imageTouchPoint = [self imagePointFromViewPoint:viewTouchPoint];
    
    NSLog(@"\"posX\":%f , \"posY\":%f", imageTouchPoint.x, imageTouchPoint.y);
    
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
    
    CGFloat radious = kDiameterForPin;
    
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
    
    CAShapeLayer *pin = [self imageAsLayer:image withPoint:imagePoint];
    [self.intermediatePins addObject:pin];
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

-(void)removeAllIntermediatePins {
    for (CAShapeLayer *shapeLayer in self.intermediatePins) {
        [shapeLayer removeFromSuperlayer];
    }
    self.intermediatePins = [NSMutableArray new];
}

- (void)cleanImageFromPins {
    [self removeStartPin];
    [self removeEndPin];
    [self removeAllIntermediatePins];
}


//MARK: Zooming

- (CGRect)rectToZoom {
    
    //if the route is not built, nothing to show
    if (!self.firstPin && !self.secondPin) {
        return CGRectNull;
    }
    
    NSMutableArray *allPins = [self.intermediatePins mutableCopy];
    
    [allPins addObject:self.firstPin];
    [allPins addObject:self.secondPin];
    
    CGFloat minX = CGFLOAT_MAX, minY = CGFLOAT_MAX, maxX = CGFLOAT_MIN, maxY = CGFLOAT_MIN;
    
    for (CAShapeLayer *pin in allPins) {
        
        CGFloat pinMinX = CGRectGetMinX(pin.frame);
        CGFloat pinMinY = CGRectGetMinY(pin.frame);
        CGFloat pinMaxX = CGRectGetMaxX(pin.frame);
        CGFloat pinMaxY = CGRectGetMaxY(pin.frame);
        
        if (pinMinX + pin.frame.size.width < minX) {
            minX = pinMinX;
        }
        if (pinMinY < minY) {
            minY = pinMinY;
        }
        if (pinMaxX > maxX) {
            maxX = pinMaxX;
        }
        if (pinMaxY > maxY) {
            maxY = pinMaxY;
        }
    }
    
    CGRect strictRectToZoom = CGRectMake(minX, minY, maxX - minX, maxY - minY);
    
    //Make it with indents
    
    CGRect rectToZoomWithIndents = strictRectToZoom;
   
    const NSInteger indent = 10;
    
    rectToZoomWithIndents.size.width += 2 * indent;
    rectToZoomWithIndents.size.height += 2 * indent;
    
    rectToZoomWithIndents.origin.x -= indent;
    rectToZoomWithIndents.origin.y -= indent;
    
    return rectToZoomWithIndents;
}

@end
