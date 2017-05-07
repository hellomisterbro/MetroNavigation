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
#import "MNRouteDetailsViewController.h"

NSString *const kEndStationChangeSegueName = @"MNEndStationChangeSegue";
NSString *const kStartStationChangeSegueName = @"MNStartStationChangeSegue";
NSString *const kShowDetailsSegue = @"MNShowDetailsSegue";

NSString *const kKeyPathForCurrentMetroState = @"currentMetroState";

const int kMinDiameterForPinDetecting = 20;


@interface MNMetroRouteViewController () <UIScrollViewDelegate, MNMetroImageViewDelegate, MNRouteDescriptionBannerViewDelegate, MNStationSearchViewControllerDelegate>

//currently selected start station
@property (nonatomic, strong) MNStation* startStation;

//currently selected end station
@property (nonatomic, strong) MNStation* endStation;

//calculated short path
@property (nonatomic, strong) MNRoute* route;

//The following method updates all image pins due to the passed parameters -  startStation, end Station
//Builds a route if end station is not nill
//If the route is built the appropriate banner is displayed, if not - is hidden
- (void)updatePinsAndRouteDisplayingWithStartStation:(MNStation *)aStartStation endStation:(MNStation *)anEndStation;

//update controllers state (image, pins etc.).
//Typically need calling when global metro state is changed
- (void)updateControllerState;

//displaing and hiding banner correspondingly
- (void)displayRouteDescriptionBanner;
- (void)hideRouteDescriptionBanner;

//Zooms to the route. Takes into account all the pins presented on image view and the banner, that will be displayed afterwards.
//Does nothing, if the pins doesnt currently exist.
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
    [MNMetroStateHolder.sharedInstance addObserver:self forKeyPath:kKeyPathForCurrentMetroState options:NSKeyValueObservingOptionNew context:nil];
    
}

-(void)viewDidAppear:(BOOL)animated {
    
    [self updatePinsAndRouteDisplayingWithStartStation:self.startStation endStation:self.endStation];
}

// MARK: - IBAction

- (IBAction)handleRouteDescriptionBannerPan:(id)sender {
    [self hideRouteDescriptionBanner];
}

- (IBAction)handleDoubleTap : (UIGestureRecognizer*) sender {
    
    CGFloat scaleToZoom = 3;
    
    //Zoom in - if currently all the image is displayed, if not - zoom out
    if (self.scrollView.zoomScale > 1.0f) {
        [self.scrollView zoomToRect:self.metroImage.frame animated:YES];
    } else {
        [self.scrollView scrollToPoint: [sender locationInView:self.scrollView] withScale:scaleToZoom];
    }
}


// MARK: - Segues

- (IBAction)applyNoneChanges:(UIStoryboardSegue*)unwindSegue {}

- (IBAction)updateStationsWithUnwindSegue:(UIStoryboardSegue*)segue {}

- (IBAction)updateMetroWithUnwindSegue:(UIStoryboardSegue*)segue {}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    BOOL isStartStationChangeSegue = [segue.identifier isEqualToString:kStartStationChangeSegueName];
    BOOL isEndStationChangeSegue = [segue.identifier isEqualToString:kEndStationChangeSegueName];
    BOOL isShowDetailSegue = [segue.identifier isEqualToString:kShowDetailsSegue];
    
    if (isStartStationChangeSegue || isEndStationChangeSegue) {
        
        //getting root view controller
        UINavigationController *navigationViewController = segue.destinationViewController;
        
        MNStationSearchViewController *destinationViewController = navigationViewController.viewControllers.firstObject;
        destinationViewController.delegate = self;
        
        if (isStartStationChangeSegue) {
            destinationViewController.stationToChangeType = MNStationToChangeStart;
            destinationViewController.stationToExclude = self.endStation;
            
        } else if (isEndStationChangeSegue) {
            destinationViewController.stationToChangeType = MNStationToChangeEnd;
            destinationViewController.stationToExclude = self.startStation;
        }
        
    } else if (isShowDetailSegue) {
        
        UINavigationController *navigationViewController = segue.destinationViewController;
        MNRouteDetailsViewController *routeDetailViewController = navigationViewController.viewControllers.firstObject;
        
        routeDetailViewController.route = self.route;
    }
    
}

// MARK: - Updating Controller

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    //updating the controller state if global metro is changed
    if ([keyPath isEqualToString:kKeyPathForCurrentMetroState]) {
        
        [self updateControllerState];
    }
}

- (void)updateControllerState {
    
    MNMetro *metro = MNMetroStateHolder.sharedInstance.currentMetroState;
    
    //deleting the pins
    self.startStation = nil;
    self.endStation = nil;
    
    self.route = nil;
    
    //change the image
    NSString *imageName = [DataAPI imageMetroNameWithMetroIdentifier:metro.ID];
    self.metroImage.image = [UIImage imageNamed:imageName];
    
    //change the city button title
    [self.cityButton setTitle:metro.name forState:UIControlStateNormal];
    
    //updating the image with the corresponing pins
    [self updatePinsAndRouteDisplayingWithStartStation:self.startStation endStation:self.endStation];
    
    //hide route description banner
    [self hideRouteDescriptionBanner];
    
    [self.scrollView zoomToRect:self.metroImage.frame animated:YES];
}

- (void)updatePinsAndRouteDisplayingWithStartStation:(MNStation *)aStartStation endStation:(MNStation *)anEndStation {
    
    //clean the image
    [self.metroImage cleanImageFromPins];
    
    self.route = nil;
    
    //set first pin
    if (self.startStation) {
        CGPoint startStationPoint = [self pointFromStation:aStartStation];
        [self.metroImage addStartPinAtPoint:startStationPoint];
    }
    
    //set second pin
    if (self.endStation) {
        CGPoint endStationPoint = [self pointFromStation:anEndStation];
        [self.metroImage addEndPinAtPoint:endStationPoint];
        
        MNMetro *metro = MNMetroStateHolder.sharedInstance.currentMetroState;
        self.route = [metro shortestRouteFromStation:aStartStation toStation:anEndStation];
    }
    
    if (self.route) {
        
        //setting intermediates pins
        
        for (MNStation *station in self.route.stationsSequence) {
            
            if (![station isEqual:aStartStation] && ![station isEqual:anEndStation]) {
                
                CGPoint intermidiatePoint = [self pointFromStation:station];
                [self.metroImage addInterMediatePinAtPoint:intermidiatePoint];
                
            }
        }
        
        //zoom to for convinient look of the route
        [self zoomToSelectedRoute];
        
        //display banner for the further interecations
        [self displayRouteDescriptionBanner];
        
    } else {
        
        [self hideRouteDescriptionBanner];
    }
}



- (void)zoomToSelectedRoute {
    
    if (self.route) {
        
        //Zoom map to the route
        CGRect rectToZoom = self.metroImage.rectToZoom;
        
        //do nothing if nothing to show
        if (CGRectIsNull(rectToZoom)) {
            return;
        }
        
        CGFloat predictedScale = [self.scrollView scaleAfterZoomingToRect:rectToZoom];
        
        //Take into account the banner that will be presented
        rectToZoom.size.height += CGRectGetHeight(self.routeDescriptionBannerView.frame) / predictedScale;
        
        [self.scrollView zoomToRect:rectToZoom animated:YES];
    }
}

// MARK: - RouteDescriptionBannerView Interactions

- (void)displayRouteDescriptionBanner {
    [self.view layoutIfNeeded];
    
    //banner configuration
    [self.routeDescriptionBannerView setStartStationName:self.startStation.name];
    [self.routeDescriptionBannerView setEndStationName:self.endStation.name];
    [self.routeDescriptionBannerView.timelabel setTotalDuration:self.route.totalDuration withTransfersCount:self.route.totalTransfers];

    self.routeDescriptionBannerView.bottomRouteDescriptionContraint.constant = 0;
    
    //updating views to fit the contrains
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)hideRouteDescriptionBanner {
    [self.view layoutIfNeeded];
    
    //change conatrains to hide the banner
    CGFloat bannerHeight = CGRectGetHeight(self.routeDescriptionBannerView.frame);
    self.routeDescriptionBannerView.bottomRouteDescriptionContraint.constant = -bannerHeight;
    
    //updating views to fit the contrains
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];
}

// MARK: - RouteDescriptionBannerViewDelegate

-(void)swipeStationDidClickWithRouteDescriptionBanner:(MNRouteDescriptionBannerView *)routeDescBanner {
    
    MNStation *endStation = self.endStation;
    
    self.endStation = self.startStation;
    self.startStation = endStation;
    
    [self updatePinsAndRouteDisplayingWithStartStation:self.startStation endStation:self.endStation];
}

- (void)cancelDidClickWithRouteDescriptionBanner:(MNRouteDescriptionBannerView *)routeDescBanner {
    [self hideRouteDescriptionBanner];
}



// MARK: - UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return  self.metroImage;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    
}


// MARK: - MNMetroImageViewDelegate

- (void)imageTouchedAtPoint:(CGPoint)point metroImageView:(MNMetroImageView *)metroImageView {
    
    MNMetro *metro = MNMetroStateHolder.sharedInstance.currentMetroState;
    
    MNStation *selectedStation =  [metro stationWithImagePositionX:point.x positionY:point.y radious:kMinDiameterForPinDetecting];
    
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
        
        [self updatePinsAndRouteDisplayingWithStartStation:self.startStation endStation:self.endStation];
        
    }
    
}


// MARK: - StationSearchViewControllerDelegate

-(void)didChooseStation:(MNStation *)station withType:(MNStationToChangeType)stationToChange inViewController:(MNStationSearchViewController *)citySearchViewController {
    
    
    if (stationToChange == MNStationToChangeStart) {
        self.startStation = station;
        
    } else if (stationToChange == MNStationToChangeEnd) {
        self.endStation = station;
    }
}



// MARK: - Local Helpers

- (CGPoint)pointFromStation:(MNStation *)station {
    return CGPointMake([station.posX doubleValue], [station.posY doubleValue]);
}

@end


