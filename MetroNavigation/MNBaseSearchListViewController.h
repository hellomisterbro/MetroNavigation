//
//  MNBaseSearchListViewController.h
//  MetroNavigation
//
//  Created by Nikita Kirichek on 5/2/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MNBaseSearchListViewController : UITableViewController


//The following dictionary represents the correspondence between the names of the objects and objects itself. The names will be used when seraching for the corresponding object to entered text.
@property (nonatomic, strong) NSDictionary <NSString *, id> *contentForTableView;

//Returns the content object passed in contentForTableView for indexPath
- (id)contentForIndexPath:(NSIndexPath *)indexPath;

//Returns the name of the object selected by the user at the table view's indexPath. Use this method in tableView:cellForRowAtIndexPath: if you want to display the name on a cell.
- (NSString *)nameForIndexPath:(NSIndexPath *)indexPath;

@end
