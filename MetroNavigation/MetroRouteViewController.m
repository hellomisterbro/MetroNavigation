//
//  MetroRouteViewController.m
//  MetroNavigation
//
//  Created by Nikita Kirichek on 4/21/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

#import "MNMetro.h"
#import "DataAPI.h"
#import "MetroStateHolder.h"

#import "MetroRouteViewController.h"
#import "CitySearchViewController.h"
#import "StationSearchViewController.h"

NSString *const detailsSegueName = @"MNDisplayRouteListSegue";
NSString *const cityChangeSegueName = @"MNCityChangeSegue";
NSString *const stationChangeSegueName = @"MNStationChangeSegue";

@interface MetroRouteViewController () <UIScrollViewDelegate, MetroImageViewDelegate, UIViewControllerTransitioningDelegate, RouteDescriptionBannerViewDelegate, StationSearchViewControllerDelegate>

@property (nonatomic, strong) MNMetro* metro;
@property (nonatomic, strong) MNRoute* route;

@property (nonatomic, strong) MNStation* startStation;
@property (nonatomic, strong) MNStation* endStation;



@end

@implementation MetroRouteViewController

// MARK: - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.metro = [MetroStateHolder sharedInstance].currentMetroState;
    self.metroImage.image = [UIImage imageNamed:[DataAPI imageMetroNameWithMetroName:kKyivMetropolitanName]];;
    
    [self.cityButton setTitle:@"Kyiv" forState:UIControlStateNormal];
    
    self.metroImage.delegate = self;
    
    self.routeDescriptionBannerView.delegate = self;
    

    
    CGFloat bannerHeight = CGRectGetHeight(self.routeDescriptionBannerView.frame);
    self.routeDescriptionBannerView.bottomRouteDescriptionContraint.constant = -bannerHeight;

}

// MARK: - IBAction

- (IBAction)handleRouteDescriptionBannerPan:(id)sender {
    [self hideRouteDescriptionBanner];
}

- (IBAction)applyNoneChanges:(UIStoryboardSegue*)unwindSegue{}

- (IBAction)updateMetroWithUnwindSegue:(UIStoryboardSegue*)segue{
    self.metro = MetroStateHolder.sharedInstance.currentMetroState;
}


// MARK: - CitySearchViewControllerDelegate

-(void)stationChoosenWithSuccess:(BOOL)success inViewController:(StationSearchViewController *)citySearchViewController {
    
}

// MARK: - StationSearchViewControllerDelegate

// MARK: - RouteDescriptionBannerViewDelegate

-(void)swipeStationDidClickWithRouteDescriptionBanner:(RouteDescriptionBannerView *)routeDescBanner {
    MNStation *endStation = self.endStation;
    
    self.endStation = self.startStation;
    self.startStation = endStation;
    
    CGPoint startPoint = [self pointFromStation:self.startStation];
    CGPoint endPint = [self pointFromStation:self.endStation];
    
    [self.metroImage addStartPinAtPoint:startPoint];
    [self.metroImage addEndPinAtPoint:endPint];
    
    [self displayRouteDescriptionBanner];
}

- (void)cancelDidClickWithRouteDescriptionBanner:(RouteDescriptionBannerView *)routeDescBanner {
    [self hideRouteDescriptionBanner];
}

// MARK: - UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return  self.metroImage;
}

// MARK: - MetroImageViewDelegate

- (void)imageTouchedAtPoint:(CGPoint)point metroImageView:(MetroImageView *)metroImageView {
    
    MNStation *selectedStation =  [self.metro stationWithImagePositionX:point.x positionY:point.y radious:15];
    
    if (selectedStation) {
        
        MNStation *start = self.startStation;
        MNStation *end = self.endStation;
        
        CGPoint selectedStationPoint = [self pointFromStation:selectedStation];;
        
        //set first pin if no station selected
        if (!start && !end) {
            self.startStation = selectedStation;
            [self.metroImage addStartPinAtPoint:selectedStationPoint];
            
            //remove first pin and set the second one to its place
        } else if ([start isEqual:selectedStation]) {
            
            self.startStation = end;
            [self.metroImage removeStartPin];
            
            if (self.endStation) {
                [self.metroImage removeEndPin];
                [self.metroImage addStartPinAtPoint:[self pointFromStation:end]];
                self.endStation = nil;
            }
            
            [self.metroImage removeAllIntermediatePins];
            
            //set second pin
        } else if (start && !end) {
            self.endStation = selectedStation;
            [self.metroImage addEndPinAtPoint:selectedStationPoint];
            
            //remove second pin
        } else if ([end isEqual:selectedStation]) {
            [self.metroImage removeEndPin];
            self.endStation = nil;
            [self.metroImage removeAllIntermediatePins];
        }
        
        //two pin selected
        if (self.startStation && self.endStation) {
            [self displayShortPathRoute];
        } else {
            [self hideRouteDescriptionBanner];
        }
        
    }
    
}




- (void)displayShortPathRoute {
    
    self.route = [self.metro shortestRouteFromStation:self.startStation toStation:self.endStation];
    
    for (MNStation *station in self.route.stationsSequence) {
        
        if (![station isEqual:self.startStation] && ![station isEqual:self.endStation]) {
            
            CGPoint intermidiatePoint = [self pointFromStation:station];
            [self.metroImage addInterMediatePinAtPoint:intermidiatePoint];
        }
    }
    
    if (self.route) {
        
        //Zoom map to the route
        CGRect rectToZoom = self.metroImage.rectToZoom;
        
        CGFloat predictedScale = [self.scrollView scaleAfterZoomingToRect:rectToZoom];
       
        //Take into account the banner that will be presented
        rectToZoom.size.height += CGRectGetHeight(self.routeDescriptionBannerView.frame) / predictedScale;
        
        [self.scrollView zoomToRect:rectToZoom animated:YES];
        [self displayRouteDescriptionBanner];
    }
}



// MARK: - RouteDescriptionBannerView Interactions

- (void)displayRouteDescriptionBanner {
    [self.view layoutIfNeeded];
    
    [self.routeDescriptionBannerView setStartStationName:self.startStation.name];
    [self.routeDescriptionBannerView setEndStationName:self.endStation.name];
    [self.routeDescriptionBannerView setTotalDuration:self.route.totalDuration];
    
    self.routeDescriptionBannerView.bottomRouteDescriptionContraint.constant = 0;
   
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)hideRouteDescriptionBanner {
    [self.view layoutIfNeeded];
    
    self.routeDescriptionBannerView.bottomRouteDescriptionContraint.constant = -CGRectGetHeight(self.routeDescriptionBannerView.frame);
   
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];
}

// MARK: - Local Helpers

- (CGPoint)pointFromStation:(MNStation *)station {
    return CGPointMake([station.posX doubleValue], [station.posY doubleValue]);
}

@end


