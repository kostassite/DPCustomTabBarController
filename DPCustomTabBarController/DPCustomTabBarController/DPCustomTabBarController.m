//
//  DPCustomTabBarController.m
//  DPCustomTabBarController
//
//  Created by Kostas Antonopoulos on 10/21/12.
//  Copyright (c) 2012 Kostas Antonopoulos. All rights reserved.
//

#import "DPCustomTabBarController.h"

@interface DPCustomTabBarController (){
    UIView *tabbarBackgroundView;
}

@end

@implementation DPCustomTabBarController
@synthesize customTabBarDelegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    
	// Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    [self removeDefaultTabBar];
    [self addBackgroundView];
    [self addTabBarButtons];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Create Custom TabBar

-(void)removeDefaultTabBar{
    [self.tabBar removeFromSuperview];
}

-(void)addBackgroundView{
    tabbarBackgroundView = [self.customTabBarDelegate backgroundViewForCustomTabBarController:self];
    CGRect oldFrame=tabbarBackgroundView.frame;
    oldFrame.origin.x=(self.view.frame.size.width - oldFrame.size.width) / 2;
    oldFrame.origin.y=self.view.frame.size.height-oldFrame.size.height;
    [tabbarBackgroundView setFrame:oldFrame];
    [self.view addSubview:tabbarBackgroundView];
}

-(void)addTabBarButtons{
    NSInteger numberOfViewController = [[self viewControllers] count];
    NSInteger previousButtonXEnd = 0;
    for (int i=0; i<numberOfViewController; i++) {
        UIButton *btn=[self.customTabBarDelegate customTabBarController:self buttonAtIndex:i];
        btn.tag=i;
        [btn addTarget:self action:@selector(tabbarButtonPressed:) forControlEvents:UIControlEventTouchDown];
        CGRect oldFrame=btn.frame;
        oldFrame.origin.x=previousButtonXEnd;
        [btn setFrame:oldFrame];
        
        previousButtonXEnd+=btn.frame.size.width;
        [tabbarBackgroundView addSubview:btn];
    }
    
}

#pragma mark - Button Actions

-(void)tabbarButtonPressed:(UIButton*)sender{
    [self setSelectedIndex:sender.tag];
}
@end
