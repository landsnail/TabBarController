//
//  TabBarController.m
//  TabBarController
//
//  Created by Denys.Meloshyn on 06/03/15.
//  Copyright (c) 2015 Denys Meloshyn. All rights reserved.
//

#import "TabBarController.h"

#import "MoreViewController.h"

#define MAX_TAB_BAR_ITEMS 5

@interface TabBarController ()

@property (nonatomic, strong) UIView *tabBarRootView;
@property (nonatomic, strong) NSArray *tabBarItemViews;
@property (nonatomic, strong) NSArray *moreTabBarItemViews;
@property (nonatomic, strong) NSArray *moreViewControllers;

@end

@implementation TabBarController

#pragma mark - Life Cycle methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Add root tab bar view, which will contains all buttons
    [self addTabBarRootView];
    
    // Need to call this line of code manually if we configure UI from StoryBoard
    self.viewControllers = [NSArray arrayWithArray:self.viewControllers];
}

#pragma mark - Autorotation iOS 7 methods

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    
    CGSize size;
    
    // Configure size of the view after rotating
    if (toInterfaceOrientation == UIInterfaceOrientationPortrait || toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
        size = CGSizeMake(CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
    }
    else {
        size = CGSizeMake(CGRectGetHeight(self.view.frame), CGRectGetWidth(self.view.frame));
    }
    
    // Resize all tab bar items
    [self resizeTabBarView:size];
}

#pragma mark - Autorotation iOS 8 methods

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    
    // Resize all tab bar items
    [self resizeTabBarView:size];
}

#pragma mark - UITabBarController methods

- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    [super setSelectedIndex:selectedIndex];
    
    // Deselect all bar button items
    for (TabBarItemView *tabBarItem in self.tabBarItemViews) {
        [tabBarItem setTabBarItemSelected:NO];
    }
    
    // Highlight selected bar button item
    TabBarItemView *tabBarItemView = self.tabBarItemViews[ selectedIndex ];
    [tabBarItemView setTabBarItemSelected:YES];
}

- (void)setViewControllers:(NSArray *)viewControllers
{
    if ([viewControllers count] == 0) {
        return;
    }
    
    NSArray *tabBarControllers;
    
    // Is number of controllers more than 5?
    if ([viewControllers count] > MAX_TAB_BAR_ITEMS) {
        // Yes: extract view controllers from first item till 4-th
        NSRange range = NSMakeRange(0, MAX_TAB_BAR_ITEMS - 1);
        tabBarControllers = [viewControllers subarrayWithRange:range];
        
        // Save view controlles in separate array from index #4 to the last
        range = NSMakeRange(MAX_TAB_BAR_ITEMS - 1, [viewControllers count] - MAX_TAB_BAR_ITEMS + 1);
        
        self.moreViewControllers = [viewControllers subarrayWithRange:range];
        
        // Cache tab bar item views
        self.moreTabBarItemViews = [self extractTabBarItemsViewFromViewControllers:self.moreViewControllers];
        
        // Add MoreViewController to the last tab
        tabBarControllers = [tabBarControllers arrayByAddingObject:[self moreViewController]];
    }
    else {
        tabBarControllers = [NSArray arrayWithArray:viewControllers];
    }
    
    // Call super method
    [super setViewControllers:tabBarControllers];
    
    // Remove all previously added views
    for (UIView *subView in self.tabBarRootView.subviews) {
        if ([subView isMemberOfClass:[TabBarItemView class]]) {
            [subView removeFromSuperview];
        }
    }
    
    // Cache tab bar item views from More tab
    self.tabBarItemViews = [self extractTabBarItemsViewFromViewControllers:tabBarControllers];
    
    // Calculate width for the tab bar item
    CGFloat width = CGRectGetWidth(self.view.frame) / [tabBarControllers count];
    
    UIView *previousView = nil;
    for (TabBarItemView *tabBarItemView in self.tabBarItemViews) {
        tabBarItemView.delegate = self;
        
        [self.tabBarRootView addSubview:tabBarItemView];
        
        // Need to add NSLayoutConstraint manually
        tabBarItemView.translatesAutoresizingMaskIntoConstraints = NO;
        
        NSArray *subConstraints;
        NSDictionary *viewsDictionary;
        
        if (previousView == nil) {
            viewsDictionary = @{ @"tabBarItem" : tabBarItemView };
        }
        else {
            viewsDictionary = @{ @"tabBarItem" : tabBarItemView, @"previousView" : previousView };
        }
        
        // Constraint for height
        NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:tabBarItemView
                                                                            attribute:NSLayoutAttributeHeight
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:nil
                                                                            attribute:NSLayoutAttributeNotAnAttribute
                                                                           multiplier:1.0
                                                                             constant:CGRectGetHeight(self.tabBar.frame)];
        [tabBarItemView addConstraint:heightConstraint];
        
        // Constraint for width
        NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:tabBarItemView
                                                                           attribute:NSLayoutAttributeWidth
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:nil
                                                                           attribute:NSLayoutAttributeNotAnAttribute
                                                                          multiplier:1.0
                                                                            constant:width];
        [tabBarItemView addConstraint:widthConstraint];
        tabBarItemView.widthConstraint = widthConstraint;
        
        if (previousView == nil) {
            // Leading space to super view
            subConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[tabBarItem]"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:viewsDictionary];
        }
        else {
            // Set constraints to the current and previous view
            subConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[previousView][tabBarItem]"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:viewsDictionary];
        }
        [self.tabBarRootView addConstraints:subConstraints];
        
        // Set constraints to the bottom of the super view
        subConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[tabBarItem]|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:viewsDictionary];
        [self.tabBarRootView addConstraints:subConstraints];
        
        previousView = tabBarItemView;
    }
    
    self.selectedIndex = 0;
}

#pragma mark - TabBarItemViewDelegate methods

- (void)tabBarItemSelected:(UIView *)sender
{
    // Select current view controller
    if ([self.tabBarItemViews containsObject:sender]) {
        NSInteger index = [self.tabBarItemViews indexOfObject:sender];
        self.selectedIndex = index;
    }
}

#pragma mark - Class methods

+ (TabBarItemView *)defaultTabBarItemView
{
    NSArray *nibItems = [[NSBundle mainBundle] loadNibNamed:@"TabBarItemView" owner:nil options:nil];
    TabBarItemView *tabBar = [nibItems firstObject];
    
    return tabBar;
}

#pragma mark - Public methods

- (void)setTabBarViewHidden:(BOOL)isHidden
{
    self.tabBar.hidden = YES;
    self.tabBarRootView.hidden = YES;
}

- (TabBarItemView *)tabBarItemViewForViewController:(UIViewController *)senderViewController
{
    if ([senderViewController isKindOfClass:[UINavigationController class]]) {
        NSArray *allVC = ((UINavigationController *)senderViewController).viewControllers;
        senderViewController = (UIViewController <TabBarControllerDelegate> *)[allVC firstObject];
    }
    
    for (UIViewController <TabBarControllerDelegate> *viewController in self.viewControllers) {
        UIViewController <TabBarControllerDelegate> *resultVC = viewController;
        
        if ([viewController isKindOfClass:[UINavigationController class]]) {
            NSArray *allVC = ((UINavigationController *)viewController).viewControllers;
            resultVC = (UIViewController <TabBarControllerDelegate> *)[allVC firstObject];
        }
        
        if ([resultVC isEqual:senderViewController]) {
            NSInteger index = [self.viewControllers indexOfObject:viewController];
            
            return self.tabBarItemViews[ index ];
        }
    }
    
    for (UIViewController <TabBarControllerDelegate> *viewController in self.moreViewControllers) {
        UIViewController <TabBarControllerDelegate> *resultVC = viewController;
        
        if ([viewController isKindOfClass:[UINavigationController class]]) {
            NSArray *allVC = ((UINavigationController *)viewController).viewControllers;
            resultVC = (UIViewController <TabBarControllerDelegate> *)[allVC firstObject];
        }
        
        if ([resultVC isEqual:senderViewController]) {
            NSInteger index = [self.moreViewControllers indexOfObject:viewController];
            
            return self.moreTabBarItemViews[ index ];
        }
    }
    
    return nil;
}

#pragma mark - Private methods

- (NSArray *)extractTabBarItemsViewFromViewControllers:(NSArray *)viewControllers
{
    NSMutableArray *moreTabBarItems = [NSMutableArray array];
    
    for (UIViewController <TabBarControllerDelegate> *vc in viewControllers) {
        UIViewController <TabBarControllerDelegate> *resultVC = vc;
        
        if ([vc isKindOfClass:[UINavigationController class]]) {
            NSArray *allVC = ((UINavigationController *)vc).viewControllers;
            resultVC = (UIViewController <TabBarControllerDelegate> *)[allVC firstObject];
        }
        
        if ([resultVC respondsToSelector:@selector(tabBarItemView)]) {
            TabBarItemView *tabbarView = [resultVC tabBarItemView];
            [moreTabBarItems addObject:tabbarView];
        }
        else {
            [moreTabBarItems addObject:[TabBarController defaultTabBarItemView]];
        }
    }
    
    return [NSArray arrayWithArray:moreTabBarItems];
}

- (UINavigationController *)moreViewController
{
    // Can be inited from StoryBoard
    MoreViewController *moreVC = [[MoreViewController alloc] init];
    
    // Set list of view controllers
    moreVC.viewControllers = self.moreViewControllers;
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:moreVC];
    
    return navigationController;
}

- (void)resizeTabBarView:(CGSize)size
{
    if ([self.viewControllers count] == 0) {
        return;
    }
    
    CGFloat width = size.width / [self.viewControllers count];
    
    for (TabBarItemView *tabBarItemView in self.tabBarItemViews) {
        tabBarItemView.widthConstraint.constant = width;
    }
}

- (void)addTabBarRootView
{
    self.tabBarRootView = [[UIView alloc] init];
    self.tabBarRootView.exclusiveTouch = YES;
    
    [self.view addSubview:self.tabBarRootView];
    
    NSArray *subConstraints;
    NSDictionary *viewsDictionary = @{ @"tabBarView" : self.tabBarRootView };
    self.tabBarRootView.translatesAutoresizingMaskIntoConstraints = NO;
    
    // Constraint for height
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self.tabBarRootView
                                                                        attribute:NSLayoutAttributeHeight
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:nil
                                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                                       multiplier:1.0
                                                                         constant:CGRectGetHeight(self.tabBar.frame)];
    [self.tabBarRootView addConstraint:heightConstraint];
    
    // Set left & right constraints to the super view
    subConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[tabBarView]|"
                                                             options:0
                                                             metrics:nil
                                                               views:viewsDictionary];
    [self.view addConstraints:subConstraints];
    
    // Set top & bottom constraints to the super view
    subConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[tabBarView]|"
                                                             options:0
                                                             metrics:nil
                                                               views:viewsDictionary];
    [self.view addConstraints:subConstraints];
}

@end
