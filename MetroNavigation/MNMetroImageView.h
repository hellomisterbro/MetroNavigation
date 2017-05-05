//
//  MNMetroImage.h
//  MetroNavigation
//
//  Created by Nikita Kirichek on 4/22/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MNMetroImageView;

@protocol MNMetroImageViewDelegate <NSObject>

@required

- (void)imageTouchedAtPoint:(CGPoint)point metroImageView:(MNMetroImageView *)metroImageView;

@end

@interface MNMetroImageView : UIImageView

@property (nonatomic, weak) id<MNMetroImageViewDelegate> delegate;

- (CGRect)rectToZoom;

- (void)addStartPinAtPoint:(CGPoint)point;
- (void)addEndPinAtPoint:(CGPoint)point;
- (void)addInterMediatePinAtPoint:(CGPoint)point;
- (void)removeStartPin;
- (void)removeEndPin;
- (void)removeAllIntermediatePins;
- (void)cleanImageFromPins;

@end
