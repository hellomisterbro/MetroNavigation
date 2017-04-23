//
//  MetroRouteViewController.m
//  MetroNavigation
//
//  Created by Nikita Kirichek on 4/21/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

#import "MetroRouteViewController.h"
#import "MNMetro.h"
#import "DataAPI.h"

@interface MetroRouteViewController () <UIScrollViewDelegate, MetroImageViewDelegate>

@property (nonatomic, strong) MNMetro* metro;
@property (nonatomic, strong) MNRoute* route;

@property (nonatomic, strong) MNStation* startStation;
@property (nonatomic, strong) MNStation* endStation;

@end

@implementation MetroRouteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.metro = [DataAPI metroJSONFile:@"kyiv"];
    
    UIImage *image = [UIImage imageNamed:@"kiev-metro"];
    
    self.metroImage.image = image;
    self.metroImage.delegate = self;
    
    self.scrollView.delegate = self;
    self.scrollView.maximumZoomScale = 5.0;
    
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// MARK: - UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return  self.metroImage;
}

// MARK: - MetroImageView

- (void)imageTouchedAtPoint:(CGPoint)point metroImageView:(MetroImageView *)metroImageView {
    
    MNStation *selectedStation =  [self.metro stationWithImagePositionX:point.x positionY:point.y radious:15];
    
    if (selectedStation) {
        
        MNStation *start = self.startStation;
        MNStation *end = self.endStation;
        
        CGPoint selectedStationPoint = CGPointMake([selectedStation.posX doubleValue], [selectedStation.posY doubleValue]);
        CGPoint secondStationPoint = CGPointMake([end.posX doubleValue], [end.posY doubleValue]);
        
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
                [self.metroImage addStartPinAtPoint:secondStationPoint];
                self.endStation = nil;
            }
            
        //set second pin
        } else if (start && !end) {
            self.endStation = selectedStation;
            [self.metroImage addEndPinAtPoint:selectedStationPoint];
            
        //remove second pin
        } else if ([end isEqual:selectedStation]) {
            [self.metroImage removeEndPin];
            self.endStation = nil;
        }
        
        //two pin selected
        if (self.startStation && self.endStation) {
            [self displayShortPathRoute];
        }
        
    }
    
}

- (void)displayShortPathRoute {
    self.route = [self.metro shortestRouteFromStation:self.startStation toStation:self.endStation];
    
    for (MNStation *station in self.route.stationsSequence) {
        
        if (![station isEqual:self.startStation] && ![station isEqual:self.endStation]) {
            
            CGPoint intermidiatePoint = CGPointMake([station.posX doubleValue], [station.posY doubleValue]);
            [self.metroImage addInterMediatePinAtPoint:intermidiatePoint];
        }
    }
}

- (void)updatePinsWithMetroImageView:(MetroImageView *)metroImageView {
    
    if (self.startStation) {
        
        [self.metroImage removeStartPin];
        
        CGPoint firstStationPoint = CGPointMake([self.startStation.posX doubleValue], [self.startStation.posY doubleValue]);
        [self.metroImage addStartPinAtPoint:firstStationPoint];
        
    } else if (self.endStation) {
        
        [self.metroImage removeEndPin];
        
        CGPoint secondStationPoint = CGPointMake([self.endStation.posX doubleValue], [self.endStation.posY doubleValue]);
        [self.metroImage addEndPinAtPoint:secondStationPoint];
    }
    
}

@end
