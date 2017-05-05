//
//  MNStationSearchViewController.m
//  MetroNavigation
//
//  Created by Nikita Kirichek on 5/2/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

#import "MNStationSearchViewController.h"
#import "MNMetroStateHolder.h"
#import "MNStationTableViewCell.h"

NSString *const kReusableCellForStationSearch = @"MNStationTableViewCellIdentidier";
NSString *const kUnwindToMetroRouteSegueName = @"MNStationChangedUnwindToMetroViewController";

@interface MNStationSearchViewController ()

@property (nonatomic, strong) MNStation *selectedStation;

- (NSDictionary <NSString *, MNStation *> *)stationNamesDictionaryFromStations:(NSArray <MNStation *> *)stations;

@end

@implementation MNStationSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    NSMutableArray *stations = [MNMetroStateHolder.sharedInstance.currentMetroState.stations mutableCopy];
    [stations removeObject:self.stationToExclude];
    
    self.contentForTableView = [self stationNamesDictionaryFromStations:stations];
}

// MARK: - UITableView

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MNStationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kReusableCellForStationSearch forIndexPath:indexPath];
    
    NSString *labelName = [self nameForIndexPath:indexPath];
    cell.stationNameLabel.text = labelName;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedStation = [self contentForIndexPath:indexPath];
}

// MARK: - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:kUnwindToMetroRouteSegueName]) {
        if (self.selectedStation) {
            [self.delegate didChooseStation:self.selectedStation withType:self.stationToChangeType inViewController:self];
        }
    }
}

// MARK: - Converting

- (NSDictionary <NSString *, MNStation *> *)stationNamesDictionaryFromStations:(NSArray <MNStation *> *)stations {
    
    NSMutableDictionary *stationNamesWithStations = [NSMutableDictionary dictionary];
    
    for (MNStation *station in stations) {
        [stationNamesWithStations setObject:station forKey:station.name];
    }
    
    return [stationNamesWithStations copy];
}



@end
