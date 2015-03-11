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

#pragma mark - UINavigationController methods

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    if ([self.viewControllers count] > 2) {
        return [super popViewControllerAnimated:animated];
    }
    
    // Get view controller which we dismiss
    UIViewController *vc = [super popViewControllerAnimated:animated];
    self.currentViewController = vc;
    
    if (self.currentNavigationController != nil) {
        // Magic - don't touch. Need to fix problem with releasing view controller if it was added to UINavigationController
        UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:self.currentViewController];
        // Need this line of code just to remove warning
        [nc viewControllers];
        
        // Restore original state
        self.currentNavigationController.viewControllers = @[ self.currentViewController ];
    }
    
    return self.currentViewController;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([self.viewControllers count] >= 2) {
        [super pushViewController:viewController animated:animated];
        return;
    }
    
    self.currentViewController = nil;
    self.currentNavigationController = nil;
    
    // Are we trying to push UINavigationController?
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        // Yes: extract first view controller from navigation stack
        self.currentNavigationController = (UINavigationController *)viewController;
        self.currentViewController = [self.currentNavigationController.viewControllers firstObject];
        
        // Push exctracted view controller
        [super pushViewController:self.currentViewController animated:animated];
        return;
    }
    
    [super pushViewController:viewController animated:animated];
}

@end
