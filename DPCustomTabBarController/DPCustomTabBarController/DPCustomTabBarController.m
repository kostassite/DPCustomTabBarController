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

    [(UIButton*)[ tabbarBackgroundView viewWithTag:10+self.selectedIndex] setHighlighted:YES];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Create Custom TabBar

-(void)removeDefaultTabBar{
    
    [self.tabBar removeFromSuperview];
    
    //Just In case apple change the private API of UITabBarController
    if ([self.view.subviews count] != 1 )
		return;
    
    UIView *contentView = [self.view.subviews objectAtIndex:0];
    [contentView setFrame:self.view.bounds];
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
        UIButton *btn;
        if ([self.customTabBarDelegate respondsToSelector:@selector(customTabBarController:tagOfButtonInBackgoundForButtonAtIndex:)]){
            btn=(UIButton*) [tabbarBackgroundView viewWithTag:[self.customTabBarDelegate customTabBarController:self tagOfButtonInBackgoundForButtonAtIndex:i]];
        }else{
            btn=[self.customTabBarDelegate customTabBarController:self buttonAtIndex:i];
            CGRect oldFrame=btn.frame;
            oldFrame.origin.x=previousButtonXEnd;
            [btn setFrame:oldFrame];
            
            previousButtonXEnd+=btn.frame.size.width;
        }

        btn.tag=10+i;
        
        [btn addTarget:self action:@selector(tabbarButtonPressed:) forControlEvents:UIControlEventTouchDown];
        [btn addTarget:self action:@selector(setButtonHighlighted:) forControlEvents:UIControlEventTouchUpInside];
        

        [tabbarBackgroundView addSubview:btn];
    }
    
}

#pragma mark - Button Methods

-(void)tabbarButtonPressed:(UIButton*)sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(tabBarController:shouldSelectViewController:)]) {
        if (![self.delegate tabBarController:self shouldSelectViewController:[self.viewControllers objectAtIndex:sender.tag-10]]) {
            return;
        }
    }
    
    if (self.selectedIndex!=sender.tag-10) {
        [(UIButton*)[ tabbarBackgroundView viewWithTag:10+self.selectedIndex] setHighlighted:NO];
    }

    [self setSelectedIndex:sender.tag-10];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(tabBarController:didSelectViewController:)]) {
        [self.delegate tabBarController:self didSelectViewController:[self.viewControllers objectAtIndex:sender.tag-10]];
    }
    
}

-(void)setButtonHighlighted:(UIButton*)sender{
    if (self.selectedIndex==sender.tag-10) {
        [self performSelector:@selector(doHighlight:) withObject:sender afterDelay:0];
    }
}

-(void)doHighlight:(UIButton*)sender{
    [sender setHighlighted:YES];
}

@end
