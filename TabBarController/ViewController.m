//
//  ViewController.m
//  TabBarController
//
//  Created by Denys.Meloshyn on 06/03/15.
//  Copyright (c) 2015 Denys Meloshyn. All rights reserved.
//

#import "ViewController.h"

#import "TabBarItemView.h"
#import "TabBarController.h"

@interface ViewController () <TabBarControllerDelegate>

@end

@implementation ViewController

#pragma mark - CustomUITabBarControllerDelegate methods

- (TabBarItemView *)tabBarItemView
{
    TabBarItemView *tabBarItem = [TabBarController defaultTabBarItemView];
    tabBarItem.title = @"Item";
    
    return tabBarItem;
}

@end
