//
//  MetroImage.h
//  MetroNavigation
//
//  Created by Nikita Kirichek on 4/22/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MetroImageViewDelegate <NSObject>

@required

- (void)imageTouchedAtPoint:(CGPoint)point;

@required


@end

@interface MetroImageView : UIImageView

@property (nonatomic, weak) id<MetroImageViewDelegate> delegate;

- (void)addCircleOnImage:(CGPoint)point;

@end
