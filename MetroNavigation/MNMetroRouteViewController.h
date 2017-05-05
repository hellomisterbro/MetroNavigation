//
//  MNMetroRouteViewController.h
//  MetroNavigation
//
//  Created by Nikita Kirichek on 4/21/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MNMetroImageView.h"
#import "MNMetroImageScrollView.h"
#import "MNRouteDescriptionBannerView.h"
#import "MNCityButton.h"


@interface MNMetroRouteViewController : UIViewController

@property (weak, nonatomic) IBOutlet MNMetroImageScrollView *scrollView;
@property (weak, nonatomic) IBOutlet MNMetroImageView *metroImage;
@property (weak, nonatomic) IBOutlet MNRouteDescriptionBannerView *routeDescriptionBannerView;
@property (weak, nonatomic) IBOutlet MNCityButton *cityButton;

@end
