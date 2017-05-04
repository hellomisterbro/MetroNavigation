//
//  MNCitySearchViewController.m
//  MetroNavigation
//
//  Created by Nikita Kirichek on 5/2/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

#import "MNCitySearchViewController.h"
#import "CityTableViewCell.h"
#import "MNDataAPI.h"
#import "MNMetroStateHolder.h"

NSString *const kReusableCellForCitySearch = @"cityNameCellIdentifier";
NSString *const kUnwindToMetroViewControllerSegueName = @"MNUnwindToMetroViewController";

@interface MNCitySearchViewController ()

@property (nonatomic, strong) NSString *selectedMetroID;

@end


@implementation MNCitySearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.contentForTableView = [DataAPI metroNamesWithIDs];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// MARK: - Segues


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:kUnwindToMetroViewControllerSegueName]) {
        MNMetro *metro = [DataAPI metroWithIdentifier:self.selectedMetroID];
        
        if (metro) {
            [MNMetroStateHolder sharedInstance].currentMetroState = metro;
        }
    }
}

// MARK: - UITableView

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    CityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kReusableCellForCitySearch forIndexPath:indexPath];
    
    NSString *labelName = [self nameForIndexPath:indexPath];
    
    cell.cityNameLabel.text = labelName;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedMetroID = [self contentForIndexPath:indexPath];
}



@end
