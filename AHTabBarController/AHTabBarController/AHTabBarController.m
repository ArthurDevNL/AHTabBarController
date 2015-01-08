//
//  TabBarController.m
//  FancyMenu
//
//  Created by Arthur Hemmer on 28/07/14.
//  Copyright (c) 2014 Arthur Hemmer. All rights reserved.
//

//Frameworks
#import <QuartzCore/QuartzCore.h>

//Controllers
#import "AHTabBarController.h"

@interface AHTabBarController ()

//The submenu that is presented when a tab with multiple NPSubitemViews is selected
@property (nonatomic) UIView *submenu;

//A 2 dimensional array that holds the initialized viewcontrollers for the subitems
@property (nonatomic) NSMutableArray *rootViewControllers;

//A boolean indicating whether or not the submenu is currently visible
@property (nonatomic, getter=isSubmenuVisible) BOOL submenuVisible;

//A boolean indicating whether or not the submenu is currently being presented/hidden
@property (nonatomic, getter=isSubmenuAnimating) BOOL submenuAnimating;

//The view that darkens the background when the menu is expanded
@property (nonatomic) UIView *darkenView;

//The item for which the viewcontroller is currently visible
@property (nonatomic) AHSubitemView *currentItem;

//The tab for which the menu is currently displayed
@property (nonatomic) AHTabView *selectedTab;

//The separator line at the top of the tab bar
@property (nonatomic) UIView *separator;

@end

@implementation AHTabBarController
@synthesize containerView = _containerView;
@synthesize tabBar = _tabBar;

-(void)reloadSubmenuItemsForTab:(AHTabView*)tabView animated:(BOOL)animated
{
    //Remove the old subitems
    for (AHSubitemView *s in self.submenu.subviews) {
        [s performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:.3f];
    }
    
    //Add the new subitems
    for (AHSubitemView *s in tabView.subitems) {
        int i = (int)[tabView.subitems indexOfObject:s];
        [s setSelectedColor:self.selectedColor];
        CGRect frame = CGRectMake(0.f, i*self.subitemHeight.floatValue, self.submenu.frame.size.width, self.subitemHeight.floatValue);
        [s setFrame:frame];
        
        [self.submenu addSubview:s];
        
        __weak typeof(self) weakself = self;
        [s setDidSelectSubitem:^(AHSubitemView *subitemView) {
            [weakself didSelectSubitemView:subitemView];
        }];
        
        if (animated) {
            [s setTransform:CGAffineTransformMakeTranslation(0.f, i*-10.f)];
            [UIView animateWithDuration:.3f delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
                [s setTransform:CGAffineTransformIdentity];
            } completion:nil];
        }
    }
    
    [self.submenu layoutIfNeeded];
    [self.currentItem setSelected:YES];
}

#pragma mark - Animations
-(void)hideTabBar
{
    if (self.isTabBarHidden)
        return;
    
    CGRect newFrame = self.tabBar.frame;
    newFrame.origin.y = self.containerView.frame.size.height;
    
    [UIView animateWithDuration:.3f animations:^{
        [self.tabBar setFrame:newFrame];
    } completion:^(BOOL finished) {
        if (finished)
            _tabBarHidden = YES;
    }];
}

-(void)presentTabBar
{
    if (!self.isTabBarHidden)
        return;
    
    CGRect newFrame = self.tabBar.frame;
    newFrame.origin.y = self.containerView.frame.size.height - newFrame.size.height;
    
    [UIView animateWithDuration:.2f animations:^{
        [self.tabBar setFrame:newFrame];
    } completion:^(BOOL finished) {
        if (finished)
            _tabBarHidden = NO;
    }];
}

-(void)presentSubmenuForTabView:(AHTabView*)tabView
{
    if (self.isSubmenuAnimating)
        return;
    
    [self setSubmenuAnimating:YES];
    [self.submenu setHidden:NO];
    
    if (!self.submenu) {
        self.submenu = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                self.view.bounds.size.height,
                                                                self.view.bounds.size.width,
                                                                0)];
        [self.submenu setBackgroundColor:[UIColor colorWithWhite:.6f alpha:1.f]];
        [self.view insertSubview:self.submenu belowSubview:self.tabBar];
    }
    
    CGRect submenuFrame = self.submenu.frame;
    submenuFrame.size.height = tabView.subitems.count*self.subitemHeight.floatValue;
    [self.submenu setFrame:submenuFrame];
    
    CGRect barFrame = self.tabBar.frame;
    if (self.shouldTabBarAnimate) {
        barFrame.origin.y = self.view.bounds.size.height - (tabView.subitems.count*self.subitemHeight.floatValue + barFrame.size.height);
        submenuFrame.origin.y = self.view.bounds.size.height - submenuFrame.size.height;
    } else {
        submenuFrame.origin.y = self.view.bounds.size.height - (submenuFrame.size.height + self.tabBar.frame.size.height);
    }
    
    [self reloadSubmenuItemsForTab:tabView animated:!self.isSubmenuVisible];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    
    __weak typeof(self) weakself = self;
    [UIView animateWithDuration:.4f delay:0.f usingSpringWithDamping:1.f initialSpringVelocity:11.f options:UIViewAnimationOptionCurveEaseIn animations:^{
        [weakself.darkenView setAlpha:1.f];
        [weakself.submenu setFrame:submenuFrame];
        [weakself.tabBar setFrame:barFrame];
    } completion:^(BOOL finished) {
        if (finished) {
            [weakself setSubmenuAnimating:NO];
            [weakself setSubmenuVisible:YES];
        }
    }];
}

-(void)hideSubmenu
{
    //If the menu is animating or the menu isn't visible we don't want to do anything
    if (self.isSubmenuAnimating || !self.isSubmenuVisible)
        return;
    
    [self setSubmenuAnimating:YES];
    
    CGRect submenuFrame = self.submenu.frame;
    CGRect barFrame = self.tabBar.frame;
    if (self.shouldTabBarAnimate) {
        barFrame.origin.y = self.view.bounds.size.height - self.tabBarHeight.floatValue;
        submenuFrame.origin.y = self.view.bounds.size.height;
    } else {
        submenuFrame.origin.y = self.view.bounds.size.height;
    }
    
    __weak typeof(self) weakself = self;
    [UIView animateWithDuration:.3f delay:0.f usingSpringWithDamping:1.f initialSpringVelocity:10.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [weakself.darkenView setAlpha:0.f];
        [weakself.submenu setFrame:submenuFrame];
        [weakself.tabBar setFrame:barFrame];
    } completion:^(BOOL finished) {
        if (finished) {
            [weakself setSubmenuAnimating:NO];
            [weakself setSubmenuVisible:NO];
            [weakself.submenu setHidden:YES];
            
            for (AHSubitemView *s in weakself.submenu.subviews) {
                [s removeFromSuperview];
            }
        }
    }];
}

-(void)reloadViewForItem:(AHSubitemView *)subitem
{
    if (!subitem)
        return;
    
    //Removing the old view(controller)
    UIViewController *oldController = [self viewControllerForSubitem:self.currentItem];
    if (oldController && ![oldController isEqual:[NSNull null]]) {
        [oldController.view removeFromSuperview];
        [oldController willMoveToParentViewController:nil];
        [oldController removeFromParentViewController];
    }
    
    //Getting the new viewcontroller or create it if we don't have it in memory yet
    UIViewController *viewController = [self viewControllerForSubitem:subitem];
    if ([viewController isEqual:[NSNull null]] || !viewController) {
        viewController = [self.storyboard instantiateViewControllerWithIdentifier:subitem.viewControllerIdentifier];
        
        if (!viewController) {
            [[NSException exceptionWithName:@"Invalid ViewController!"
                                     reason:@"The ViewController instantiated form the storyboard may not be nil. Please check if the identifier is valid"
                                   userInfo:nil] raise];
        }
        
        [self setViewController:viewController forSubitem:subitem];
    }
    
    [viewController.view setFrame:self.containerView.frame];
    [self addChildViewController:viewController];
    [self.containerView addSubview:viewController.view];
    [viewController didMoveToParentViewController:self];
    
    [self.currentItem setSelected:NO];
    [subitem setSelected:YES];
    [self setCurrentItem:subitem];
}

#pragma mark - Behaviour
-(void)didSelectTab:(AHTabView*)tabView
{
    if (self.isSubmenuAnimating)
        return;
    
    //One control flow for the behaviour of the menu
    if (self.isSubmenuVisible) {
        if (self.selectedTab == tabView) {
            [self hideSubmenu];
            [self setSelectedTab:self.currentItem.tab];
        } else {
            [self setSelectedTab:tabView];
            
            if (tabView.subitems.count == 1) {
                [self didSelectSubitemView:[tabView.subitems firstObject]];
            } else {
                //Switch tabs
                [self presentSubmenuForTabView:tabView];
            }
        }
    } else {
        [self setSelectedTab:tabView];
        
        if (tabView.subitems.count == 1) {
            [self didSelectSubitemView:[tabView.subitems firstObject]];
        } else {
            [self presentSubmenuForTabView:tabView];
        }
    }
}

-(void)didSelectSubitemView:(AHSubitemView*)subitemView
{
    //If it is the same item as the selected item, do nothing
    if (self.currentItem != subitemView)
        [self reloadViewForItem:subitemView];
    
    [self hideSubmenu];
    [self setSelectedTab:subitemView.tab];
}

//Whenever a tab has been selected
-(void)setSelectedTab:(AHTabView *)selectedTab
{
    if (_selectedTab != selectedTab) {
        
        [_selectedTab setSelected:NO];
        [selectedTab setSelected:YES];
        
        _selectedTab = selectedTab;
    }
}

//Whenever a tap has been recognized on the 'darken' view hide the submenu
-(void)tapGestureRecognized:(UITapGestureRecognizer*)gestureRecognizer
{
    if (gestureRecognizer.state == UIGestureRecognizerStateRecognized) {
        [self setSelectedTab:self.currentItem.tab];
        [self hideSubmenu];
    }
}

#pragma mark - Utility
//A method that gets the viewcontroller from the rootViewControllers array for the
// given subitem. If the viewController does not exist it will return an [NSNull null]
-(UIViewController*)viewControllerForSubitem:(AHSubitemView*)subitem
{
    if (!subitem)
        return nil;
    
    //Check if we already have the ViewController in memory and create it if we don't
    NSUInteger firstDimension = [self.tabs indexOfObject:subitem.tab];
    NSUInteger secondDimension = [subitem.tab.subitems indexOfObject:subitem];
    
    UIViewController *viewController = self.rootViewControllers[firstDimension][secondDimension];
    return viewController;
}

//Adds the given viewcontroller to the rootViewControllers array for the calculated
// index of the given subitem
-(void)setViewController:(UIViewController*)viewController forSubitem:(AHSubitemView*)subitem
{
    if (!subitem)
        return;
    
    //Check if we already have the ViewController in memory and create it if we don't
    NSUInteger firstDimension = [self.tabs indexOfObject:subitem.tab];
    NSUInteger secondDimension = [subitem.tab.subitems indexOfObject:subitem];
    
    //Update the array
    self.rootViewControllers[firstDimension][secondDimension] = viewController;
}

#pragma mark - Layout
-(void)reloadTabBar
{
    //Remove old tabs if there are any
    for (AHTabView *t in self.tabBar.subviews) {
        [t removeFromSuperview];
    }
    
    //Calculate the new dimensions
    float tabwidth = self.tabBar.frame.size.width/self.tabs.count;
    
    CGRect f = CGRectMake(0, 0, self.tabBar.frame.size.width, .5f);
    if (![[UIScreen mainScreen] respondsToSelector:@selector(scale)])
        f.size.height = 1.f;
    
    self.separator = [[UIView alloc] initWithFrame:f];
    [self.separator setBackgroundColor:[UIColor colorWithWhite:.7f alpha:1.f]];
    [self.tabBar addSubview:self.separator];
    
    //Create and add each tab to the tabBar
    for (int i = 0; i < self.tabs.count; i++) {
        CGRect tabFrame = CGRectMake(i*tabwidth, 0.f, tabwidth, self.tabBarHeight.floatValue);
        AHTabView *tabView = self.tabs[i];
        [tabView setFrame:tabFrame];
        [tabView setSelectedColor:self.selectedColor];
        
        __weak typeof(self) weakself = self;
        [tabView setDidSelectTab:^(AHTabView *tab) {
            [weakself didSelectTab:tab];
        }];
        [self.tabBar addSubview:tabView];
    }
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    CGSize size = [AHTabBarController sizeInOrientation:toInterfaceOrientation];
    CGRect newDimensions = CGRectMake(0, 0, size.width, size.height);
    
    [UIView animateWithDuration:duration animations:^{
        
        //Change the separator's frame
        CGRect sFrame = self.separator.frame;
        sFrame.size.width = size.width;
        [self.separator setFrame:sFrame];
        
        //Reload the frames
        if (self.isSubmenuVisible) {
            AHTabView *t = self.selectedTab;
            
            [self.submenu setFrame:CGRectMake(0.f,
                                              size.height-self.submenu.frame.size.height,
                                              size.width,
                                              self.submenu.frame.size.height)];
            [self.tabBar setFrame:CGRectMake(0.f,
                                             size.height - self.tabBarHeight.floatValue - self.submenu.frame.size.height,
                                             size.width,
                                             self.tabBarHeight.floatValue)];
            
            CGRect submenuFrame = self.submenu.frame;
            submenuFrame.size.height = t.subitems.count*self.subitemHeight.floatValue;
            [self.submenu setFrame:submenuFrame];
            
            CGRect barFrame = self.tabBar.frame;
            if (self.shouldTabBarAnimate) {
                barFrame.origin.y = size.height - (t.subitems.count*self.subitemHeight.floatValue + barFrame.size.height);
                submenuFrame.origin.y = size.height - submenuFrame.size.height;
            } else {
                submenuFrame.origin.y = size.height - (submenuFrame.size.height + self.tabBar.frame.size.height);
            }
            
            //Reload the frames for the subitems
            for (AHSubitemView *s in self.selectedTab.subitems) {
                int i = (int)[self.selectedTab.subitems indexOfObject:s];
                [s setSelectedColor:self.selectedColor];
                CGRect frame = CGRectMake(0.f, i*self.subitemHeight.floatValue, size.width, self.subitemHeight.floatValue);
                [s setFrame:frame];
            }
            
        } else {
            CGRect tabBarFrame = CGRectMake(0.f,
                                            size.height-self.tabBarHeight.floatValue,
                                            size.width,
                                            self.tabBarHeight.floatValue);
            
            [self.submenu setFrame:CGRectMake(0.f, size.height, size.width, self.submenu.frame.size.height)];
            
            if (self.isTabBarHidden)
                tabBarFrame.origin.y = size.height;
            
            [self.tabBar setFrame:tabBarFrame];
        }
        
        //Only set the darkenview's frame if it exists, otherwise a dark 'flash' will occur on screen
        if (_darkenView)
            [self.darkenView setFrame:newDimensions];
        
        [self.containerView setFrame:newDimensions];
        
        //Calculate the new dimensions
        float tabwidth = size.width/self.tabs.count;
        
        for (int i = 0; i < self.tabs.count; i++) {
            AHTabView *t = self.tabs[i];
            [t setFrame:CGRectMake(i*tabwidth, 0.f, tabwidth, self.tabBarHeight.floatValue)];
        }
        
        [self.submenu layoutIfNeeded];
        [self.currentItem setSelected:YES];
    }];
}

+(CGSize)sizeInOrientation:(UIInterfaceOrientation)orientation
{
    CGSize size = [UIScreen mainScreen].bounds.size;
    if ((UIInterfaceOrientationIsLandscape(orientation) && size.width < size.height) ||
        (UIInterfaceOrientationIsPortrait(orientation) && size.width > size.height)) {
        size = CGSizeMake(size.height, size.width);
    }
    return size;
}

#pragma mark - Lazy Instantiation
-(UIView *)tabBar
{
    if (!_tabBar) {
        _tabBar = [[UIView alloc] initWithFrame:CGRectMake(0.f,
                                                               self.view.bounds.size.height-self.tabBarHeight.floatValue,
                                                               self.view.bounds.size.width,
                                                               self.tabBarHeight.floatValue)];
        [_tabBar setBackgroundColor:[UIColor colorWithWhite:.9f alpha:.8f]];
        
        self.separator = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _tabBar.frame.size.width, 1.f)];
        [self.separator setBackgroundColor:[UIColor colorWithWhite:.7f alpha:1.f]];
        [_tabBar addSubview:self.separator];
        [self.view addSubview:_tabBar];
    }
    return _tabBar;
}

-(UIView *)containerView
{
    if (!_containerView) {
        _containerView = [[UIView alloc] initWithFrame:self.view.bounds];
        [self.view insertSubview:_containerView belowSubview:self.tabBar];
    }
    return _containerView;
}

-(NSNumber *)subitemHeight
{
    if (!_subitemHeight) {
        _subitemHeight = @50.f;
    }
    return _subitemHeight;
}

-(NSNumber *)tabBarHeight
{
    if (!_tabBarHeight) {
        _tabBarHeight = @49.f;
    }
    return _tabBarHeight;
}

-(UIColor *)selectedColor
{
    if (!_selectedColor) {
        _selectedColor = [UIColor colorWithRed:211.f/255.f
                                         green:84.f/255.f
                                          blue:0.f/255.f
                                         alpha:1.f];
    }
    return _selectedColor;
}

-(UIView *)darkenView
{
    if (!_darkenView) {
        _darkenView = [[UIView alloc] initWithFrame:self.view.bounds];
        [_darkenView setBackgroundColor:[UIColor colorWithWhite:.1f alpha:.5f]];
        [_darkenView setAlpha:0.f];
        [self.view insertSubview:_darkenView aboveSubview:self.containerView];
        
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                               action:@selector(tapGestureRecognized:)];
        [tapGestureRecognizer setNumberOfTapsRequired:1];
        [tapGestureRecognizer setNumberOfTouchesRequired:1];
        [_darkenView addGestureRecognizer:tapGestureRecognizer];
    }
    return  _darkenView;
}

#pragma mark - Controller Lifecycle
-(void)setup
{
    [self setSubmenuVisible:NO];
    [self setShouldTabBarAnimate:YES];
    _tabs = [NSMutableArray new];
}

-(id)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setup];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.view setTranslatesAutoresizingMaskIntoConstraints:YES];
    
    [self.view setBackgroundColor:[UIColor blackColor]];
    
    //If the rootViewControllers array hasn't been initialized yet it means that we need to set up the whole tab bar
    if (!self.rootViewControllers) {
        self.rootViewControllers = [NSMutableArray arrayWithCapacity:self.tabs.count];
        for (AHTabView *t in self.tabs) {
            NSMutableArray *subitems = [NSMutableArray arrayWithCapacity:t.subitems.count];
            for (int i = 0; i < t.subitems.count; i++) {
                [subitems addObject:[NSNull null]];
            }
            [self.rootViewControllers addObject:subitems];
        }
        
        [self reloadTabBar];
        
        //Call -layoutIfNeeded here to force laying out the tabs so that
        // we can set the first tab as selected
        [self.tabBar layoutIfNeeded];
        
        AHTabView *firstTab = [self.tabs firstObject];
        [firstTab setSelected:YES];
        [self setSelectedTab:firstTab];
        [self reloadViewForItem:[firstTab.subitems firstObject]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    //Release all the viewcontrollers except the visible one from our rootViewControllers array so that
    // memory will be freed up.
    for (AHTabView *t in self.tabs) {
        for (AHSubitemView *s in t.subitems) {
            if (s != self.currentItem)
                [self setViewController:(UIViewController*)[NSNull null] forSubitem:s];
        }
    }
}

@end
