//
//  ViewController.m
//  AHTabBarController
//
//  Created by Arthur Hemmer on 09/08/14.
//  Copyright (c) 2014 Arthur Hemmer. All rights reserved.
//

#import "ViewController.h"

#import "AHTabBarController.h"
#import "AppDelegate.h"

@interface ViewController ()

@property (nonatomic, weak) IBOutlet UIButton *btnHideBar;
-(IBAction)btnHideBarPressed:(UIButton*)sender;

@end

@implementation ViewController

-(IBAction)btnHideBarPressed:(UIButton *)sender
{
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    AHTabBarController *tabBarController = (AHTabBarController*)delegate.window.rootViewController;
    
    if (tabBarController.isTabBarHidden)
        [tabBarController presentTabBar];
    else
        [tabBarController hideTabBar];
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
