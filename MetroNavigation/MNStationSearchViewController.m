//
//  MNStationSearchViewController.m
//  MetroNavigation
//
//  Created by Nikita Kirichek on 5/2/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

#import "MNStationSearchViewController.h"
#import "MNMetroStateHolder.h"
#import "StationTableViewCell.h"

NSString *const kReusableCellForStationSearch = @"MNStationTableViewCellIdentidier";
NSString *const kUnwindToMetroRouteSegueName = @"MNUnwindFromSrarionSearchToMetroRouteSegue";

@interface MNStationSearchViewController ()

@property (nonatomic, strong) MNStation *selectedStation;

@end

@implementation MNStationSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    NSArray *stations = MNMetroStateHolder.sharedInstance.currentMetroState.stations;
    self.contentForTableView = [self stationNamesDictionaryWithStations:stations];
    
    // Do any additional setup after loading the view.
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    StationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kReusableCellForStationSearch forIndexPath:indexPath];
    
    NSString *labelName = [self nameForIndexPath:indexPath];
    
    cell.stationNameLabel.text = labelName;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedStation = [self contentForIndexPath:indexPath];
}

- (IBAction)doneClicked:(id)sender {

}
// MARK: - Local Helpers


- (NSDictionary <NSString *, MNStation *> *)stationNamesDictionaryWithStations:(NSArray <MNStation *> *)stations {
    
    NSMutableDictionary *stationNamesWithStations = [NSMutableDictionary dictionary];
    
    for (MNStation *station in stations) {
        [stationNamesWithStations setObject:station forKey:station.name];
    }
    return [stationNamesWithStations copy];
}




@end
