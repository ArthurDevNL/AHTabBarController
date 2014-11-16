//
//  NPSubItem.h
//  iOrtho
//
//  Created by Arthur Hemmer on 07/08/14.
//  Copyright (c) 2014 Appsss. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AHTabView;

@interface AHSubitemView : UIView

/**
 The title that is displayed in the menu for this subitem.
 */
@property (nonatomic) NSString *title;

/**
 The icon image for the subitem.
 */
@property (nonatomic) UIImage *image;

/**
 The identifier of the viewcontroller that will be instantiated from the storyboard.
 */
@property (nonatomic) NSString *viewControllerIdentifier;

/**
 A callback block for when the user taps the subitem.
 */
@property (nonatomic, copy) void (^didSelectSubitem)(AHSubitemView *tab);

/**
 The color that the title label and icon image will have when the view is selected.
 */
@property (nonatomic) UIColor *selectedColor;

/**
 The AHTabView instance under which this subitem is visible in the menu.
 */
@property (nonatomic) AHTabView *tab;

/**
 Animate to a selected/deselected state.
 */
-(void)setSelected:(BOOL)selected;

@end
