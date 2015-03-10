//
//  MoreNavigationController.m
//  TabBarController
//
//  Created by Denys.Meloshyn on 10/03/15.
//  Copyright (c) 2015 Denys Meloshyn. All rights reserved.
//

#import "MoreNavigationController.h"

@interface MoreNavigationController () <UINavigationControllerDelegate>

@property (nonatomic, strong) UIViewController *currentViewController;
@property (nonatomic, strong) UINavigationController *currentNavigationController;

@end

@implementation MoreNavigationController

- (id)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithRootViewController:rootViewController];
    
    if (self != nil) {
        self.delegate = self;
    }
    
    return self;
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    UIViewController *vc = [super popViewControllerAnimated:animated];
    self.currentViewController = vc;
    
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:self.currentViewController];
    [nc viewControllers];
    
    self.currentNavigationController.viewControllers = @[ self.currentViewController ];
    
    return self.currentViewController;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    self.currentViewController = nil;
    self.currentNavigationController = nil;
    
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        self.currentNavigationController = (UINavigationController *)viewController;
        self.currentViewController = [self.currentNavigationController.viewControllers firstObject];
        
        [super pushViewController:self.currentViewController animated:animated];
        return;
    }
    
    [super pushViewController:viewController animated:animated];
}

@end
