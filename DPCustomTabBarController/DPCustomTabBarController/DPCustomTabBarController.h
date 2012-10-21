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
-(UIButton*)customTabBarController:(DPCustomTabBarController*)customTabBarContr buttonAtIndex:(NSInteger)index;

@end

@interface DPCustomTabBarController : UITabBarController

@property (nonatomic,weak) id<DPCustomTabBarControllerDelegate> customTabBarDelegate;
@end
