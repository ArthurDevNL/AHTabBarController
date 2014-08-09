//
//  TabBarController.h
//  FancyMenu
//
//  Created by Arthur Hemmer on 28/07/14.
//  Copyright (c) 2014 Arthur Hemmer. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AHTabView.h"
#import "AHSubitemView.h"

@interface AHTabBarController : UIViewController

//The bottom bar in which the FancyTab items are displayed.
@property (nonatomic) UIView *tabBar;

//The view that contains the viewController for the selected FancyItem.
@property (nonatomic) UIView *containerView;

//This array contains FancyTab instances which in turn contain FancyItem instances. The menu visible
// to the user will be constructed according to the items in this array.
@property (nonatomic, readonly) NSMutableArray *tabs;

//The color that will indicate the selected state of tabs and submenu items
@property (nonatomic) UIColor *selectedColor;

//The height for the cells that are presented when the menu is raised. Defaults to 50.f
@property (nonatomic) NSNumber *subitemHeight;

//A boolean indicating whether the tabbar should move with the submenu or that the
// submenu should appear above the tabbar.
@property (nonatomic) BOOL shouldTabBarAnimate;

@end
