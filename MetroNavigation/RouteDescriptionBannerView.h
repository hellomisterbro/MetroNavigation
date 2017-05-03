//
//  RouteDescriptionBannerView.h
//  MetroNavigation
//
//  Created by Nikita Kirichek on 4/29/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "StationButton.h"
#import "RouterDescriptionButton.h"

@class RouteDescriptionBannerView;

@protocol RouteDescriptionBannerViewDelegate <NSObject>

@required

- (void)cancelDidClickWithRouteDescriptionBanner:(RouteDescriptionBannerView *)routeDescBanner;
- (void)swipeStationDidClickWithRouteDescriptionBanner:(RouteDescriptionBannerView *)routeDescBanner;


@required


@end

@interface RouteDescriptionBannerView : UIView



@property (nonatomic, weak) IBOutlet StationButton *startStaion;
@property (nonatomic, weak) IBOutlet StationButton *endStaion;
@property (nonatomic, weak) IBOutlet UILabel *timelabel;
@property (nonatomic, weak) IBOutlet RouterDescriptionButton *cancelButton;
@property (nonatomic, weak) IBOutlet RouterDescriptionButton *detailsButton;

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *bottomRouteDescriptionContraint;

@property (nonatomic, weak) id<RouteDescriptionBannerViewDelegate> delegate;

- (void)setStartStationName:(NSString *)name;
- (void)setEndStationName:(NSString *)name;
- (void)setTotalDuration:(NSNumber *)totalDuration;

@end
