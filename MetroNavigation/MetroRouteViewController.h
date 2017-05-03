//
//  MetroRouteViewController.h
//  MetroNavigation
//
//  Created by Nikita Kirichek on 4/21/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MetroImageView.h"
#import "MetroImageScrollView.h"
#import "RouteDescriptionBannerView.h"
#import "CityButton.h"


@interface MetroRouteViewController : UIViewController

@property (weak, nonatomic) IBOutlet MetroImageScrollView *scrollView;
@property (weak, nonatomic) IBOutlet MetroImageView *metroImage;
@property (weak, nonatomic) IBOutlet RouteDescriptionBannerView *routeDescriptionBannerView;
@property (weak, nonatomic) IBOutlet CityButton *cityButton;

@end
