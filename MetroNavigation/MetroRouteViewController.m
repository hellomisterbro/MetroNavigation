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

@property (nonatomic, strong) MNStation* firstStation;
@property (nonatomic, strong) MNStation* secondStation;

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
        
        MNStation *first = self.firstStation;
        MNStation *second = self.secondStation;
        
        CGPoint selectedStationPoint = CGPointMake([selectedStation.posX doubleValue], [selectedStation.posY doubleValue]);
        
        if (!first && !second) {
            self.firstStation = selectedStation;
            self.metroImage.circleFirstStation =  [self.metroImage addCircleOnImageWithPoint:selectedStationPoint];
            
        } else if ([first isEqual:selectedStation]) {
            self.firstStation = second;
            [self.metroImage.circleFirstStation removeFromSuperlayer];
            self.metroImage.circleFirstStation = self.metroImage.circleSecondStation;
            self.secondStation = nil;
            
        } else if (first && !second) {
            self.secondStation = selectedStation;
            self.metroImage.circleSecondStation =  [self.metroImage addCircleOnImageWithPoint:selectedStationPoint];
            
        } else if ([second isEqual:selectedStation]) {
            [self.metroImage.circleSecondStation removeFromSuperlayer];
            self.secondStation = nil;
        }
    }
}

- (void)updatePinsWithMetroImageView:(MetroImageView *)metroImageView {
    [self.metroImage.circleFirstStation removeFromSuperlayer];
    [self.metroImage.circleSecondStation removeFromSuperlayer];
    
    CGPoint firstStationPoint = CGPointMake([self.firstStation.posX doubleValue], [self.firstStation.posY doubleValue]);
    CGPoint secondStationPoint = CGPointMake([self.secondStation.posX doubleValue], [self.secondStation.posY doubleValue]);
    
    self.metroImage.circleSecondStation =  [self.metroImage addCircleOnImageWithPoint:secondStationPoint];
    self.metroImage.circleFirstStation =  [self.metroImage addCircleOnImageWithPoint:firstStationPoint];
    
}

@end
