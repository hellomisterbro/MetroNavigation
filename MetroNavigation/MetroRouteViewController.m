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
NSString *const keyPathForCurrentMetroState = @"MNStationChangeSegue";

@interface MetroRouteViewController () <UIScrollViewDelegate, MetroImageViewDelegate, UIViewControllerTransitioningDelegate, RouteDescriptionBannerViewDelegate, StationSearchViewControllerDelegate>

//currently selected start station
@property (nonatomic, strong) MNStation* startStation;

//currently selected end station
@property (nonatomic, strong) MNStation* endStation;

//calculated short path
@property (nonatomic, strong) MNRoute* route;

@end

@implementation MetroRouteViewController

// MARK: - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self updateControllerState];
    
    self.routeDescriptionBannerView.delegate = self;
    self.metroImage.delegate = self;
    
    CGFloat bannerHeight = CGRectGetHeight(self.routeDescriptionBannerView.frame);
    self.routeDescriptionBannerView.bottomRouteDescriptionContraint.constant = -bannerHeight;
    
    [MetroStateHolder.sharedInstance addObserver:self forKeyPath:keyPathForCurrentMetroState options:NSKeyValueObservingOptionNew context:nil];
    
}

// MARK: - IBAction

- (IBAction)handleRouteDescriptionBannerPan:(id)sender {
    [self hideRouteDescriptionBanner];
}

// MARK: - Segues

- (IBAction)applyNoneChanges:(UIStoryboardSegue*)unwindSegue{}

- (IBAction)updateMetroWithUnwindSegue:(UIStoryboardSegue*)segue{
//    self.metro = MetroStateHolder.sharedInstance.currentMetroState;
}

// MARK: - Scroll View Interactions

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return  self.metroImage;
}

- (void)zoomToSelectedRoute {
    
    if (self.route) {
        
        //Zoom map to the route
        CGRect rectToZoom = self.metroImage.rectToZoom;
        
        CGFloat predictedScale = [self.scrollView scaleAfterZoomingToRect:rectToZoom];
        
        //Take into account the banner that will be presented
        rectToZoom.size.height += CGRectGetHeight(self.routeDescriptionBannerView.frame) / predictedScale;
        
        [self.scrollView zoomToRect:rectToZoom animated:YES];
    }
}

// MARK: - Metro Image View Interactions

- (void)imageTouchedAtPoint:(CGPoint)point metroImageView:(MetroImageView *)metroImageView {
    
    MNMetro *metro = MetroStateHolder.sharedInstance.currentMetroState;
    
    MNStation *selectedStation =  [metro stationWithImagePositionX:point.x positionY:point.y radious:15];
    
    if (selectedStation) {
        
        if (!self.startStation && !self.endStation) {
            //set first pin if no station selected
            self.startStation = selectedStation;
            
        } else if ([self.startStation isEqual:selectedStation] && self.endStation) {
            //replace start station with end station
            
            self.startStation = self.endStation;
            self.endStation = nil;
            
        }  else if ([self.startStation isEqual:selectedStation] && !self.endStation) {
            //remove start station
            
            self.startStation = nil;
            
        } else if (self.startStation && !self.endStation) {
            //set second pin

            self.endStation = selectedStation;
            
        } else if ([self.endStation isEqual:selectedStation]) {
            //remove second pin
            
            self.endStation = nil;
        }
        
        self.route = nil;
        
        if (self.startStation && self.endStation) {
            self.route = [metro shortestRouteFromStation:self.startStation toStation:self.endStation];
        }
        
        [self updateImagePins];
    }
    
}

- (void)updateImagePins {
    
    [self.metroImage cleanImageFromPins];
    
    if (self.startStation) {
        CGPoint startStationPoint = [self pointFromStation:self.startStation];
        [self.metroImage addStartPinAtPoint:startStationPoint];
    }
    
    if (self.endStation) {
        
        CGPoint endStationPoint = [self pointFromStation:self.endStation];
        [self.metroImage addEndPinAtPoint:endStationPoint];
    }
    
    if (self.route) {
        for (MNStation *station in self.route.stationsSequence) {
            
            if (![station isEqual:self.startStation] && ![station isEqual:self.endStation]) {
                
                CGPoint intermidiatePoint = [self pointFromStation:station];
                [self.metroImage addInterMediatePinAtPoint:intermidiatePoint];
                
            }
        }
        
        [self zoomToSelectedRoute];
        [self displayRouteDescriptionBanner];
    }
}

// MARK: - CitySearchViewControllerDelegate

-(void)stationChoosenWithSuccess:(BOOL)success inViewController:(StationSearchViewController *)citySearchViewController {
    
}

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

// MARK: - Updating Controller

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:keyPathForCurrentMetroState]) {
        [self updateControllerState];
    }
}


- (void)updateControllerState {
    
    MNMetro *metro = MetroStateHolder.sharedInstance.currentMetroState;
    
    self.startStation = nil;
    self.endStation = nil;
    
    NSString *imageName = [DataAPI imageMetroNameWithMetroIdentifier:metro.ID];
    self.metroImage.image = [UIImage imageNamed:imageName];
    
    [self.cityButton setTitle:metro.name forState:UIControlStateNormal];
    
    [self updateImagePins];
}


// MARK: - Local Helpers

- (CGPoint)pointFromStation:(MNStation *)station {
    return CGPointMake([station.posX doubleValue], [station.posY doubleValue]);
}

@end


