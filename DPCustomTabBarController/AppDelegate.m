//
//  AppDelegate.m
//  DPCustomTabBarController
//
//  Created by Kostas Antonopoulos on 10/21/12.
//  Copyright (c) 2012 Kostas Antonopoulos. All rights reserved.
//

#import "AppDelegate.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "DPCustomTabBarController.h"

@interface AppDelegate ()<DPCustomTabBarControllerDelegate>

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

    FirstViewController *firstVC=[[FirstViewController alloc]init];
    SecondViewController *secondVC=[[SecondViewController alloc]init];
    
    DPCustomTabBarController *customTabBarContr=[[DPCustomTabBarController alloc]init];
    [customTabBarContr setCustomTabBarDelegate:self];

    [customTabBarContr setViewControllers:[NSArray arrayWithObjects:firstVC,secondVC, nil]];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window setRootViewController:customTabBarContr ];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - DPCustomTabBarControllerDelegate

-(UIView*)backgroundViewForCustomTabBarController:(DPCustomTabBarController *)customTabBarContr{
    UIView *backgroundView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 50)];
    [backgroundView setBackgroundColor:[UIColor redColor]];
    
    return backgroundView;
}
-(UIButton*)customTabBarController:(DPCustomTabBarController *)customTabBarContr buttonAtIndex:(NSInteger)index{
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn setTitle:[NSString stringWithFormat:@"%d",index] forState:UIControlStateNormal];
    [btn setFrame:CGRectMake(0, 0, 50, 50)];

    return btn;
}
@end
