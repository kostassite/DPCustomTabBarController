//
//  DPCustomTabBarController.h
//  DPCustomTabBarController
//
//  Created by Kostas Antonopoulos on 10/21/12.
//  Copyright (c) 2012 Kostas Antonopoulos. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DPCustomTabBarController;

@protocol DPCustomTabBarControllerDelegate <NSObject>

@required
-(UIView*)backgroundViewForCustomTabBarController:(DPCustomTabBarController*)customTabBarContr;

@optional
-(UIButton*)customTabBarController:(DPCustomTabBarController*)customTabBarContr buttonAtIndex:(NSInteger)index;
-(NSInteger)customTabBarController:(DPCustomTabBarController*)customTabBarContr tagOfButtonInBackgoundForButtonAtIndex:(NSInteger)index;


@end

@interface DPCustomTabBarController : UITabBarController

-(void)deselectAllTabs;
-(void)deselectTabAtIndex:(NSInteger)index;
-(void)selectTabAtIndex:(NSInteger)index;

-(void)hideTabbar;
-(void)showTabbar;
-(void)setHeight:(NSInteger)height;
-(void)endScroll;

-(UIView*)tabbarBackgroundView;

@property (nonatomic,weak) id<DPCustomTabBarControllerDelegate> customTabBarDelegate;
@end
