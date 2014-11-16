//
//  NPTab.h
//  iOrtho
//
//  Created by Arthur Hemmer on 07/08/14.
//  Copyright (c) 2014 Appsss. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AHSubitemView;

@interface AHTabView : UIView


/**
 Contains AHSubitemView instances that will be showed wehenever this tab is tapped. If the tab only contains one item, no extra menu will be shown and the user will directly see the subitem's viewcontroller.
 */
@property (nonatomic, readonly) NSMutableArray *subitems;

/**
 The tab's title.
 */
@property (nonatomic) NSString *title;

/**
 The tab's icon image.
 */
@property (nonatomic) UIImage *image;

/**
 A callback block for when the user taps the tab.
 */
@property (nonatomic, copy) void (^didSelectTab)(AHTabView *tab);

/**
 The color that the title label and icon image will have when the tab is selected.
 */
@property (nonatomic) UIColor *selectedColor;

/**
 Adds a subitem to the subitems array.
 */
-(void)addSubitem:(AHSubitemView *)subitem;

/**
 Animate to a selected/deselected state.
 */
-(void)setSelected:(BOOL)selected;

@end
