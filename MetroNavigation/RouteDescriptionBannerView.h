//
//  RouteDescriptionBannerView.h
//  MetroNavigation
//
//  Created by Nikita Kirichek on 4/29/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StationLabel.h"

@class RouteDescriptionBannerView;

@protocol RouteDescriptionBannerViewDelegate <NSObject>

@required

- (void)cancelDidClickWithRouteDescriptionBanner:(RouteDescriptionBannerView *)routeDescBanner;
- (void)detailsDidClickWithRouteDescriptionBanner:(RouteDescriptionBannerView *)routeDescBanner;
- (void)swipeStationDidClickWithRouteDescriptionBanner:(RouteDescriptionBannerView *)routeDescBanner;

@required


@end

@interface RouteDescriptionBannerView : UIView

@property (nonatomic, weak) IBOutlet StationLabel *startStaion;
@property (nonatomic, weak) IBOutlet StationLabel *endStaion;
@property (nonatomic, weak) IBOutlet UILabel *timelabel;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *bottomRouteDescriptionContraint;

@property (nonatomic, weak) id<RouteDescriptionBannerViewDelegate> delegate;

- (void)setStartStationName:(NSString *)name;
- (void)setEndStationName:(NSString *)name;
- (void)setTotalDuration:(NSNumber *)totalDuration;

@end
