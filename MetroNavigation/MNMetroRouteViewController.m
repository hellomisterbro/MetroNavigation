//
//  MNMetroRouteViewController.m
//  MetroNavigation
//
//  Created by Nikita Kirichek on 4/21/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

#import "MNMetro.h"
#import "MNDataAPI.h"
#import "MNMetroStateHolder.h"

#import "MNMetroRouteViewController.h"
#import "MNCitySearchViewController.h"
#import "MNStationSearchViewController.h"

NSString *const detailsSegueName = @"MNDisplayRouteListSegue";
NSString *const cityChangeSegueName = @"MNCityChangeSegue";
NSString *const stationChangeSegueName = @"MNStationChangeSegue";

NSString *const keyPathForCurrentMetroState = @"currentMetroState";

@interface MNMetroRouteViewController () <UIScrollViewDelegate, MetroImageViewDelegate, UIViewControllerTransitioningDelegate, RouteDescriptionBannerViewDelegate, MNStationSearchViewControllerDelegate>

//currently selected start station
@property (nonatomic, strong) MNStation* startStation;

//currently selected end station
@property (nonatomic, strong) MNStation* endStation;

//calculated short path
@property (nonatomic, strong) MNRoute* route;

//update all pins in image view
- (void)updateImagePins;

//update controllers state (image, pins etc.).
//Typically need calling when metro state is changed
- (void)updateControllerState;

//displaing and hiding banner correspondingly
- (void)displayRouteDescriptionBanner;
- (void)hideRouteDescriptionBanner;

//zooming scroll view for convinient look of the route
- (void)zoomToSelectedRoute;

//getting CGPoint value from the MNStation object's posX and posY properties 
- (CGPoint)pointFromStation:(MNStation *)station;

@end

@implementation MNMetroRouteViewController

// MARK: - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self updateControllerState];
    
    self.routeDescriptionBannerView.delegate = self;
    self.metroImage.delegate = self;
    
    CGFloat bannerHeight = CGRectGetHeight(self.routeDescriptionBannerView.frame);
    self.routeDescriptionBannerView.bottomRouteDescriptionContraint.constant = -bannerHeight;
    
    //updating the controller state if global metro is changed
    [MNMetroStateHolder.sharedInstance addObserver:self forKeyPath:keyPathForCurrentMetroState options:NSKeyValueObservingOptionNew context:nil];
    
}

// MARK: - IBAction

- (IBAction)handleRouteDescriptionBannerPan:(id)sender {
    [self hideRouteDescriptionBanner];
}

// MARK: - Segues

- (IBAction)applyNoneChanges:(UIStoryboardSegue*)unwindSegue {}

- (IBAction)updateMetroWithUnwindSegue:(UIStoryboardSegue*)segue {}

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
    
    MNMetro *metro = MNMetroStateHolder.sharedInstance.currentMetroState;
    
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
            //setting the route if two pins selected
            self.route = [metro shortestRouteFromStation:self.startStation toStation:self.endStation];
        }
        
        [self updateImagePins];
    }
    
}

- (IBAction)handleDoubleTap : (UIGestureRecognizer*) sender {
    
    if (self.scrollView.zoomScale > 1.0f) {
        [self.scrollView zoomToRect:self.metroImage.frame animated:YES];
    } else {
        [self.scrollView scrollToPoint: [sender locationInView:self.scrollView] withScale:5];
    }
}


- (void)updateImagePins {
    
    //clean the image
    [self.metroImage cleanImageFromPins];
    
    //set first pin
    if (self.startStation) {
        CGPoint startStationPoint = [self pointFromStation:self.startStation];
        [self.metroImage addStartPinAtPoint:startStationPoint];
    }
    
    //set second pin
    if (self.endStation) {
        
        CGPoint endStationPoint = [self pointFromStation:self.endStation];
        [self.metroImage addEndPinAtPoint:endStationPoint];
    }
    
    if (self.route) {
        
        //setting intermediates pins
        
        for (MNStation *station in self.route.stationsSequence) {
            
            if (![station isEqual:self.startStation] && ![station isEqual:self.endStation]) {
                
                CGPoint intermidiatePoint = [self pointFromStation:station];
                [self.metroImage addInterMediatePinAtPoint:intermidiatePoint];
                
            }
        }
        
        //zoom to for convinient look of the route
        [self zoomToSelectedRoute];
        
        //display banner for the further interecations
        [self displayRouteDescriptionBanner];
    }
}

// MARK: - CitySearchViewControllerDelegate

-(void)stationChoosenWithSuccess:(BOOL)success inViewController:(MNStationSearchViewController *)citySearchViewController {
    
}

// MARK: - RouteDescriptionBannerViewDelegate

-(void)swipeStationDidClickWithRouteDescriptionBanner:(RouteDescriptionBannerView *)routeDescBanner {
   
    MNStation *endStation = self.endStation;
   
    self.endStation = self.startStation;
    self.startStation = endStation;
    
    //update swiped pins
    [self updateImagePins];
    
    //dispay route banner correctly
    [self displayRouteDescriptionBanner];
}

- (void)cancelDidClickWithRouteDescriptionBanner:(RouteDescriptionBannerView *)routeDescBanner {
    [self hideRouteDescriptionBanner];
}

// MARK: - RouteDescriptionBannerView Interactions

- (void)displayRouteDescriptionBanner {
    [self.view layoutIfNeeded];
    
    //banner configuration
    [self.routeDescriptionBannerView setStartStationName:self.startStation.name];
    [self.routeDescriptionBannerView setEndStationName:self.endStation.name];
    [self.routeDescriptionBannerView setTotalDuration:self.route.totalDuration];
    
    //updating contrains for seeing for displaying the banner
    self.routeDescriptionBannerView.bottomRouteDescriptionContraint.constant = 0;
    
    //updating views to fit the contrains
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)hideRouteDescriptionBanner {
    [self.view layoutIfNeeded];
    
    //updating contrains for hiding the banner
    CGFloat bannerHeight = CGRectGetHeight(self.routeDescriptionBannerView.frame);
    self.routeDescriptionBannerView.bottomRouteDescriptionContraint.constant = -bannerHeight;
    
    //updating views to fit the contrains
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];
}

// MARK: - Updating Controller

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    //updating the controller state if global metro is changed
    if ([keyPath isEqualToString:keyPathForCurrentMetroState]) {
        
        [self updateControllerState];
    }
}


- (void)updateControllerState {
    
    MNMetro *metro = MNMetroStateHolder.sharedInstance.currentMetroState;
    
    //deleting the pins
    self.startStation = nil;
    self.endStation = nil;
    
    self.route = nil;
    
    //changin the image
    NSString *imageName = [DataAPI imageMetroNameWithMetroIdentifier:metro.ID];
    self.metroImage.image = [UIImage imageNamed:imageName];
    
    //changin the city button title
    [self.cityButton setTitle:metro.name forState:UIControlStateNormal];
    
    //updating the image with the corresponing pins
    [self updateImagePins];
    
    //hide route description banner
    [self hideRouteDescriptionBanner];
    
    [self.scrollView zoomToRect:self.metroImage.frame animated:YES];
}


// MARK: - Local Helpers

- (CGPoint)pointFromStation:(MNStation *)station {
    return CGPointMake([station.posX doubleValue], [station.posY doubleValue]);
}

@end


