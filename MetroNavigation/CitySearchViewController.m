//
//  CitySearchViewController.m
//  MetroNavigation
//
//  Created by Nikita Kirichek on 5/2/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

#import "CitySearchViewController.h"
#import "CityTableViewCell.h"
#import "DataAPI.h"
#import "MetroStateHolder.h"

NSString *const kReusableCellForCitySearch = @"cityNameCellIdentifier";
NSString *const kUnwindToMetroViewControllerSegueName = @"MNUnwindToMetroViewController";

@interface CitySearchViewController ()

@property (nonatomic, strong) NSString *selectedMetroID;

@end


@implementation CitySearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.contentForTableView = [DataAPI metroNamesWithIDs];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Segues


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:kUnwindToMetroViewControllerSegueName]) {
        MNMetro *metro = [DataAPI metroWithIdentifier:self.selectedMetroID];
        
        if (metro) {
            [MetroStateHolder sharedInstance].currentMetroState = metro;
        }
    }
}

#pragma mark UITableView

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
