//
//  TabBarController.h
//  TabBarController
//
//  Created by Denys.Meloshyn on 06/03/15.
//  Copyright (c) 2015 Denys Meloshyn. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TabBarItemView.h"

@protocol TabBarControllerDelegate <NSObject>

@optional
- (TabBarItemView *)tabBarItemView;

@end

@interface TabBarController : UITabBarController <UITabBarControllerDelegate, TabBarItemViewDelegate>

+ (TabBarItemView *)defaultTabBarItemView;

- (void)setTabBarViewHidden:(BOOL)isHidden;
- (TabBarItemView *)tabBarItemViewForViewController:(UIViewController *)viewController;

@end
