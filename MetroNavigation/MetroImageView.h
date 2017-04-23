//
//  MetroImage.h
//  MetroNavigation
//
//  Created by Nikita Kirichek on 4/22/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MetroImageView;

@protocol MetroImageViewDelegate <NSObject>

@required

- (void)imageTouchedAtPoint:(CGPoint)point metroImageView:(MetroImageView *)metroImageView;
- (void)updatePinsWithMetroImageView:(MetroImageView *)metroImageView;

@end

@interface MetroImageView : UIImageView

@property (nonatomic, weak) id<MetroImageViewDelegate> delegate;

@property (nonatomic, strong) CAShapeLayer* circleFirstStation;
@property (nonatomic, strong) CAShapeLayer* circleSecondStation;

- (CAShapeLayer *)addCircleOnImageWithPoint:(CGPoint)point;

@end
