//
//  RouteDescriptionBannerView.m
//  MetroNavigation
//
//  Created by Nikita Kirichek on 4/29/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

#import "RouteDescriptionBannerView.h"

@implementation RouteDescriptionBannerView

- (void)drawRect:(CGRect)rect {
    self.layer.shadowOffset = CGSizeMake(0, -2);
    self.layer.shadowRadius = 3;
    self.layer.shadowOpacity = 0.5;
}



@end
