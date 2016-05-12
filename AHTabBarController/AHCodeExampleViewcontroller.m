//
//  AHCodeExampleViewcontroller.m
//  AHTabBarController
//
//  Created by Joe on 5/11/16.
//  Copyright © 2016 Arthur Hemmer. All rights reserved.
//

#import "AHCodeExampleViewcontroller.h"

@implementation AHCodeExampleViewcontroller

- (void)loadView {
    [super loadView];
    
    /******* PURUS *******/
    AHTabView *purus = [AHTabView new];
    [purus setImage:[UIImage imageNamed:@"persondot"]];
    [purus setTitle:@"Purus"];
    
    AHSubitemView *pFirst = [AHSubitemView new];
    [pFirst setImage:[UIImage imageNamed:@"persondot"]];
    [pFirst setTitle:@"First"];
    [purus addSubitem:pFirst];
    
    AHSubitemView *pSecond = [AHSubitemView new];
    [pSecond setImage:[UIImage imageNamed:@"newspaper"]];
    [pSecond setTitle:@"Second"];
    [purus addSubitem:pSecond];
    
    /******* FRINGILLA *******/
    AHTabView *fringilla = [AHTabView new];
    [fringilla setImage:[UIImage imageNamed:@"receipt"]];
    [fringilla setTitle:@"Fringilla"];
    
    AHSubitemView *fFirst = [AHSubitemView new];
    [fFirst setImage:[UIImage imageNamed:@"photos"]];
    [fFirst setTitle:@"First"];
    [fringilla addSubitem:fFirst];
    
    AHSubitemView *fSecond = [AHSubitemView new];
    [fSecond setImage:[UIImage imageNamed:@"tv"]];
    [fSecond setTitle:@"Second"];
    [fringilla addSubitem:fSecond];
    
    AHSubitemView *fThird = [AHSubitemView new];
    [fThird setImage:[UIImage imageNamed:@"user"]];
    [fThird setTitle:@"Third"];
    [fringilla addSubitem:fThird];
    
    /******* IPSUM *******/
    AHTabView *ipsum = [AHTabView new];
    [ipsum setImage:[UIImage imageNamed:@"user"]];
    [ipsum setTitle:@"Ipsum"];
    
    AHSubitemView *iFirst = [AHSubitemView new];
    [iFirst setImage:[UIImage imageNamed:@"photos"]];
    [iFirst setTitle:@"First"];
    [ipsum addSubitem:iFirst];
    
    //Don't forget to add your AHTabView instances to the AHTabBarController!
    [self.tabs addObjectsFromArray:@[purus, fringilla, ipsum]];
}

-(UIViewController*)viewControllerForSubItem:(AHSubitemView*)subItem
{
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, 200, 30)];
    [vc.view addSubview:label];
    
    if (subItem.tabIndex == 0) {
        if (subItem.subIndex == 0) {
            label.text = @"Purus One";
        } else if (subItem.subIndex == 1) {
            label.text = @"Purus Two";
        }
    } else if (subItem.tabIndex == 1) {
        if (subItem.subIndex == 0) {
            label.text = @"Fringilla One";
        } else if (subItem.subIndex == 1) {
            label.text = @"Fringilla Two";
        } else if (subItem.subIndex == 2) {
            label.text = @"Fringilla Three";
        }
    } else if (subItem.tabIndex == 2) {
        label.text = @"Ipsum";
    }
    
    return vc;
}

@end
