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
    BOOL loaded;
    
    BOOL inAnimation;
}

@end

@implementation DPCustomTabBarController
@synthesize customTabBarDelegate;

-(UIView*)tabbarBackgroundView{
    return tabbarBackgroundView;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabbarHeight = 46;
        self.tabBar.translucent = NO;
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    loaded=NO;
    
	// Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    if (!loaded) {
        [self removeDefaultTabBar];
        [self addBackgroundView];
        [self addTabBarButtons];
        loaded=YES;
    }
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

}

-(void)addBackgroundView{
    
    tabbarBackgroundView = [self.customTabBarDelegate backgroundViewForCustomTabBarController:self];
    CGRect oldFrame=tabbarBackgroundView.frame;
    oldFrame.origin.x=0;
    oldFrame.origin.y=[self screenSize].height-oldFrame.size.height;
    oldFrame.size.width = self.view.frame.size.width;
    [tabbarBackgroundView setFrame:oldFrame];
    
    [tabbarBackgroundView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:tabbarBackgroundView];

    
    NSLayoutConstraint *heightConst = [NSLayoutConstraint constraintWithItem:tabbarBackgroundView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:self.tabbarHeight];
    NSLayoutConstraint *bottomConst = [NSLayoutConstraint constraintWithItem:tabbarBackgroundView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:0];

    [self.view addConstraint:heightConst];
    [self.view addConstraint:bottomConst];
    
    NSLayoutConstraint *widthConst = [NSLayoutConstraint constraintWithItem:tabbarBackgroundView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1 constant:0];
    NSLayoutConstraint *centerConst = [NSLayoutConstraint constraintWithItem:tabbarBackgroundView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    
    [self.view addConstraint:widthConst];
    [self.view addConstraint:centerConst];
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

-(void)setTabbarHeight:(NSInteger)tabbarHeight{
    _tabbarHeight = tabbarHeight;
    CGRect frame = self.tabBar.frame;
    frame.size.height = tabbarHeight;
    [self.tabBar setFrame:frame];
}

#pragma mark - UITabBarController methods

-(void)setSelectedViewController:(__kindof UIViewController *)selectedViewController{
    [super setSelectedViewController:selectedViewController];
    [self deselectAllTabs];
    [self selectTabAtIndex:[self.viewControllers indexOfObject:selectedViewController]];
}

-(void)setSelectedIndex:(NSUInteger)selectedIndex{
    [super setSelectedIndex:selectedIndex];
    [self deselectAllTabs];
    [self selectTabAtIndex:selectedIndex];
}

#pragma mark - Hide Show

-(void)hideTabbar{
    if (inAnimation) {
        return;
    }
    
    if (self.view.frame.size.height != [self screenSize].height+self.tabbarHeight) {
        inAnimation = YES;
        UIViewSetFrameHeight(self.view, [self screenSize].height+self.tabbarHeight);
        [UIView animateWithDuration:0.3 animations:^{
            [self.view layoutIfNeeded];
        }completion:^(BOOL finished) {
            inAnimation = NO;
        }];
    }
}

-(void)showTabbar{
    if (inAnimation) {
        return;
    }
    if (self.view.frame.size.height != [self screenSize].height) {
        inAnimation = YES;
        UIViewSetFrameHeight(self.view, [self screenSize].height);
        [UIView animateWithDuration:0.2 animations:^{
            [self.view layoutIfNeeded];
        }completion:^(BOOL finished) {
            inAnimation = NO;
        }];
    }
}

-(void)setHeight:(NSInteger)height{
    UIViewSetFrameHeight(self.view, [self screenSize].height+height);
}

-(void)endScroll{

    if (self.view.frame.size.height<[self screenSize].height+23) {
        [self showTabbar];
    }else{
        [self hideTabbar];
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

-(void)deselectAllTabs{
    NSInteger numberOfViewController = [[self viewControllers] count];
    for (int i=0; i<numberOfViewController; i++) {
        [self deselectTabAtIndex:i];
    }
}

-(void)deselectTabAtIndex:(NSInteger)index{
    [(UIButton*)[ tabbarBackgroundView viewWithTag:10+index] setHighlighted:NO];
}
-(void)selectTabAtIndex:(NSInteger)index{
    [(UIButton*)[ tabbarBackgroundView viewWithTag:10+index] setHighlighted:YES];
}

#pragma mark - Private Helpers

UIKIT_STATIC_INLINE void
UIViewSetFrameHeight(UIView *view, CGFloat height) {
    view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, height);
}

-(CGSize)screenSize{
   return [[UIScreen mainScreen] bounds].size;
}

@end
