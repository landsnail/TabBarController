//
//  ViewController.m
//  TabBarController
//
//  Created by Denys.Meloshyn on 06/03/15.
//  Copyright (c) 2015 Denys Meloshyn. All rights reserved.
//

#import "ViewController.h"

#import "TabBarItemView.h"

@implementation ViewController

- (void)dealloc
{
    NSLog(@"Dealloc");
}

#pragma mark - TabBarControllerDelegate methods

- (TabBarItemView *)tabBarItemView
{
    TabBarItemView *tabBarItem = [TabBarController defaultTabBarItemView];
    tabBarItem.item.title = @"Item";
    
    return tabBarItem;
}

@end
