//
//  MNRouteDetailsViewController.m
//  MetroNavigation
//
//  Created by Nikita Kirichek on 5/6/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

#import "UIColor+MNColors.h"
#import "MNRouteDetailsViewController.h"
#import "MNRouteDetailsForLineTableViewCell.h"


NSString *const kTwoStationsReusableCell = @"MNRofuteDetailsTwoStationsReusabelCell";
NSString *const kOneStationReusableCell = @"MNRofuteDetailsOneStationReusabelCell";

const int kRowHightOneStationForTableViewCell = 43;
const int kRowHightTwoStationsForTableViewCell = 142;

@interface MNRouteDetailsViewController ()

@property (nonatomic, strong) NSArray <MNLineRoute*> *detailedRouteLines;

@end

@implementation MNRouteDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.detailedRouteLines = self.route.routeLines;
    
    [self.totalDurationLabel setTotalDuration:self.route.totalDuration withTransfersCount:self.route.totalTransfers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    MNLineRoute *routeLine = self.detailedRouteLines[indexPath.row];
    
    return (routeLine.stationSequence.count > 1) ? kRowHightTwoStationsForTableViewCell : kRowHightOneStationForTableViewCell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.detailedRouteLines.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MNLineRoute *routeLine = self.detailedRouteLines[indexPath.row];
    
    NSString *reusableCellIdentifier = (routeLine.stationSequence.count > 1) ? kTwoStationsReusableCell : kOneStationReusableCell;
    
    MNRouteDetailsForLineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reusableCellIdentifier forIndexPath:indexPath];
    
    cell.startStationLabel.text = [routeLine.stationSequence firstObject].name;
    cell.endStationLabel.text = [routeLine.stationSequence lastObject].name;
    
    cell.metroLineImageView.image = [cell.metroLineImageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [cell.metroLineImageView setTintColor:[UIColor colorWithMNColor:routeLine.line.color]];
    
    [cell.timeDescriptionForLineLabel setTotalDuration:routeLine.duration];
    [cell.timeDescriptionForTransferLabel setTransferDuration:routeLine.transferToNextDuration];
    
    if ([routeLine isEqual:[self.detailedRouteLines lastObject]]) {
        cell.timeDescriptionForTransferLabel.hidden = YES;
    }
   
    return cell;
}

@end
