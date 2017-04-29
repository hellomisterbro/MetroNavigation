//
//  RouteDescriptionBannerView.h
//  MetroNavigation
//
//  Created by Nikita Kirichek on 4/29/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StationLabel.h"

@interface RouteDescriptionBannerView : UIView

@property (nonatomic, weak) IBOutlet StationLabel *startStaion;
@property (nonatomic, weak) IBOutlet StationLabel *endStaion;
@property (nonatomic, weak) IBOutlet UILabel *timelabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomRouteDescriptionContraint;

@end
