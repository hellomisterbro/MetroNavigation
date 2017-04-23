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

- (void)addFirstPinAtPoint:(CGPoint)point;
- (void)addSecondPinAtPoint:(CGPoint)point;

- (void)removeFirstPin;
- (void)removeSecondPin;;

@end
