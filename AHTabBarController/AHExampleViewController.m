//
//  ViewController.m
//  AHTabBarController
//
//  Created by Arthur Hemmer on 09/08/14.
//  Copyright (c) 2014 Arthur Hemmer. All rights reserved.
//

#import "AHExampleViewController.h"
#import "AHTabBarController.h"

static AHTabBarController *_tabController;

@interface AHExampleViewController ()

@property (nonatomic, weak) IBOutlet UIButton *btnHideBar;
-(IBAction)btnHideBarPressed:(UIButton*)sender;

@end

@implementation AHExampleViewController

+(void)setTabController:(AHTabBarController*)tabController {
    _tabController = tabController;
}

-(IBAction)btnHideBarPressed:(UIButton *)sender
{
    if (_tabController == nil) {
        return;
    }
    
    if (_tabController.isTabBarHidden)
        [_tabController presentTabBar];
    else
        [_tabController hideTabBar];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
