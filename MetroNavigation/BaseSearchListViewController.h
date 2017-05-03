//
//  BaseSearchListViewController.h
//  MetroNavigation
//
//  Created by Nikita Kirichek on 5/2/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseSearchListViewController : UITableViewController

@property (nonatomic, strong) NSDictionary <NSString *, id> *contentForTableView;


- (id)contentForIndexPath:(NSIndexPath *)indexPath;
- (NSString *)nameForIndexPath:(NSIndexPath *)indexPath;

@end
