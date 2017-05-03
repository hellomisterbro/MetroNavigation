//
//  RouteDescriptionBannerView.m
//  MetroNavigation
//
//  Created by Nikita Kirichek on 4/29/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

#import "RouteDescriptionBannerView.h"
#import "UIColor+MNColors.h"

@implementation RouteDescriptionBannerView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.layer.shadowOffset = CGSizeMake(0, -2);
        self.layer.shadowRadius = 3;
        self.layer.shadowOpacity = 0.5;
    }
    return self;
}

- (void)setStartStationName:(NSString *)name {
    [self.startStaion setTitle:name forState:UIControlStateNormal];
}

- (void)setEndStationName:(NSString *)name {
    [self.endStaion setTitle:name forState:UIControlStateNormal];
}

- (void)setTotalDuration:(NSNumber *)totalDuration {
    self.timelabel.text = [NSString stringWithFormat:@"~Approx. %.2f mins", [totalDuration doubleValue]];
}



- (IBAction)cancelClicked:(id)sender {
    [self.delegate cancelDidClickWithRouteDescriptionBanner:self];
}

- (IBAction)swipeClicked:(id)sender {
    [self.delegate swipeStationDidClickWithRouteDescriptionBanner:self];
}



@end
