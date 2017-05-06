//
//  MNRouteDescriptionBannerView.h
//  MetroNavigation
//
//  Created by Nikita Kirichek on 4/29/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MNStationButton.h"
#import "MNBarItemButton.h"
#import "MNDurationDescriptionLabel.h"

@class MNRouteDescriptionBannerView;

@protocol MNRouteDescriptionBannerViewDelegate <NSObject>

@required

- (void)cancelDidClickWithRouteDescriptionBanner:(MNRouteDescriptionBannerView *)routeDescBanner;
- (void)swipeStationDidClickWithRouteDescriptionBanner:(MNRouteDescriptionBannerView *)routeDescBanner;


@required


@end

@interface MNRouteDescriptionBannerView : UIView

@property (nonatomic, weak) IBOutlet MNStationButton *startStaion;
@property (nonatomic, weak) IBOutlet MNStationButton *endStaion;
@property (nonatomic, weak) IBOutlet MNDurationDescriptionLabel *timelabel;
@property (nonatomic, weak) IBOutlet MNBarItemButton *cancelButton;
@property (nonatomic, weak) IBOutlet MNBarItemButton *detailsButton;

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *bottomRouteDescriptionContraint;

@property (nonatomic, weak) id <MNRouteDescriptionBannerViewDelegate> delegate;

- (void)setStartStationName:(NSString *)name;
- (void)setEndStationName:(NSString *)name;
@end
