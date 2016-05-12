//
//  AHExampleListViewController.m
//  AHTabBarController
//
//  Created by Joe on 5/11/16.
//  Copyright © 2016 Arthur Hemmer. All rights reserved.
//

#import "AHExampleListViewController.h"
#import "AHStoryboardExampleViewController.h"
#import "AHCodeExampleViewcontroller.h"
#import "AHExampleViewController.h"

@implementation AHExampleListViewController

- (void)loadView {
    [super loadView];
    self.title = @"AHTabBar Examples";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:@"cell"];
    }
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"Storyboard Example";
    }
    else if (indexPath.row == 1) {
        cell.textLabel.text = @"Code Only Example";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        AHTabBarController *vc = [AHStoryboardExampleViewController controller];
        [AHExampleViewController setTabController:vc];
        [self.navigationController pushViewController:vc animated:true];
    }
    else if (indexPath.row == 1) {
        UIViewController *vc = [[AHCodeExampleViewcontroller alloc] init];
        [self.navigationController pushViewController:vc animated:true];
    }
}

@end
