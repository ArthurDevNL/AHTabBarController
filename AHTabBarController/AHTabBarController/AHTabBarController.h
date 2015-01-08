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

/**
 The view for the tab bar at the bottom of the screen.
 */
@property (nonatomic, readonly) UIView *tabBar;

/**
 The view that shows the viewcontroller for the selected item.
 */
@property (nonatomic, readonly) UIView *containerView;

/**
 This array contains AHTabView instances. Each AHTabView instance can contain multiple AHSubitemViews which will be revealed when the users taps on a tab.
 */
@property (nonatomic, readonly) NSMutableArray *tabs;

/**
 The color that indicates the selected state of tabs and submenu items.
 */
@property (nonatomic) UIColor *selectedColor;

/**
 The height for the cells that are presented when the menu is raised. Defaults to 50.
 */
@property (nonatomic) NSNumber *subitemHeight;

/**
 The height of the tab bar. Defaults to 49.
*/
@property (nonatomic) NSNumber *tabBarHeight;

/**
 A boolean indicating whether the tabbar should move with the submenu or that the submenu should appear above the tabbar.
 */
@property (nonatomic) BOOL shouldTabBarAnimate;

/**
 Indicates whether the tabbar is currently hidden or not
 */
@property (nonatomic, readonly, getter=isTabBarHidden) BOOL tabBarHidden;

/**
 Hides the tab bar (e.g. when something needs to be shown fullscreen).
 */
-(void)hideTabBar;

/**
 Presents the tab bar.
 */
-(void)presentTabBar;

@end
