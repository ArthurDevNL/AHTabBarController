//
//  StoryboardExampleViewController.m
//  AHTabBarController
//
//  Created by Joe on 5/11/16.
//  Copyright © 2016 Arthur Hemmer. All rights reserved.
//

#import "AHStoryboardExampleViewController.h"
#import "AHTabBarController.h"

@implementation AHStoryboardExampleViewController

+ (AHStoryboardExampleViewController*)controller {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AHStoryboardExampleViewController *vc = [sb instantiateViewControllerWithIdentifier:
                                             @"AHStoryboardExampleViewController"];
    return vc;
}

- (void)loadView {
    [super loadView];
    
    /******* PURUS *******/
    AHTabView *purus = [AHTabView new];
    [purus setImage:[UIImage imageNamed:@"persondot"]];
    [purus setTitle:@"Purus"];
    
    AHSubitemView *pFirst = [AHSubitemView new];
    [pFirst setImage:[UIImage imageNamed:@"persondot"]];
    [pFirst setTitle:@"First"];
    [pFirst setViewControllerIdentifier:@"PurusFirst"];
    [purus addSubitem:pFirst];
    
    AHSubitemView *pSecond = [AHSubitemView new];
    [pSecond setImage:[UIImage imageNamed:@"newspaper"]];
    [pSecond setTitle:@"Second"];
    [pSecond setViewControllerIdentifier:@"PurusSecond"];
    [purus addSubitem:pSecond];
    
    /******* FRINGILLA *******/
    AHTabView *fringilla = [AHTabView new];
    [fringilla setImage:[UIImage imageNamed:@"receipt"]];
    [fringilla setTitle:@"Fringilla"];
    
    AHSubitemView *fFirst = [AHSubitemView new];
    [fFirst setImage:[UIImage imageNamed:@"photos"]];
    [fFirst setTitle:@"First"];
    [fFirst setViewControllerIdentifier:@"FringillaFirst"];
    [fringilla addSubitem:fFirst];
    
    AHSubitemView *fSecond = [AHSubitemView new];
    [fSecond setImage:[UIImage imageNamed:@"tv"]];
    [fSecond setTitle:@"Second"];
    [fSecond setViewControllerIdentifier:@"FringillaSecond"];
    [fringilla addSubitem:fSecond];
    
    AHSubitemView *fThird = [AHSubitemView new];
    [fThird setImage:[UIImage imageNamed:@"user"]];
    [fThird setTitle:@"Third"];
    [fThird setViewControllerIdentifier:@"FringillaThird"];
    [fringilla addSubitem:fThird];
    
    /******* IPSUM *******/
    AHTabView *ipsum = [AHTabView new];
    [ipsum setImage:[UIImage imageNamed:@"user"]];
    [ipsum setTitle:@"Ipsum"];
    
    AHSubitemView *iFirst = [AHSubitemView new];
    [iFirst setImage:[UIImage imageNamed:@"photos"]];
    [iFirst setTitle:@"First"];
    [iFirst setViewControllerIdentifier:@"IpsumFirst"];
    [ipsum addSubitem:iFirst];
    
    //Don't forget to add your AHTabView instances to the AHTabBarController!
    [self.tabs addObjectsFromArray:@[purus, fringilla, ipsum]];
}

@end
