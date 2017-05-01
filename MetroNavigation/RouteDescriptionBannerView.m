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

- (void)setStartStationName:(NSString *)name {
    self.startStaion.text = name;
}

- (void)setEndStationName:(NSString *)name {
    self.endStaion.text = name;
}

- (void)setTotalDuration:(NSNumber *)totalDuration {
    self.timelabel.text = [NSString stringWithFormat:@"Total Duration %.2f", [totalDuration doubleValue]];
}

- (IBAction)detailsClicked:(id)sender {
    [self.delegate detailsDidClickWithRouteDescriptionBanner:self];
}

- (IBAction)cancelClicked:(id)sender {
    [self.delegate cancelDidClickWithRouteDescriptionBanner:self];
}

- (IBAction)swipeClicked:(id)sender {
    [self.delegate swipeStationDidClickWithRouteDescriptionBanner:self];
}



@end
