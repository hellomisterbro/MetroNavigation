//
//  MNRouteDetailsViewController.m
//  MetroNavigation
//
//  Created by Nikita Kirichek on 5/6/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

#import "MNRouteDetailsViewController.h"
#import "MNRouteDetailsForLineTableViewCell.h"

NSString *const kReusableCellForTableView = @"MNRouteDetailsReusabelCellIdentifier";

@interface MNRouteDetailsViewController ()

@end

@implementation MNRouteDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MNRouteDetailsForLineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kReusableCellForTableView forIndexPath:indexPath];
//    cell.-
    return cell;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
