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

@end

@implementation MetroRouteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.metro = [DataAPI metroJSONFile:@"kyiv"];
    
    UIImage *image = [UIImage imageNamed:kKyivMetropolitanFileName];
    
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

// MARK: - UIScrollViewDelegate

- (void)imageTouchedAtPoint:(CGPoint)point {
    MNStation *station =  [self.metro stationWithImagePositionX:point.x positionY:point.y radious:10];
    [self.metroImage addCircleOnImage:CGPointMake([station.posX doubleValue], [station.posY doubleValue])];
}

@end
