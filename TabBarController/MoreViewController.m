//
//  MoreViewController.m
//  TabBarController
//
//  Created by Denys.Meloshyn on 06/03/15.
//  Copyright (c) 2015 Denys Meloshyn. All rights reserved.
//

#import "MoreViewController.h"

#import "TabBarItemView.h"

@interface MoreViewController ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIViewController *lastVC;
@property (nonatomic, strong) UINavigationController *lastNavVC;

@end

@implementation MoreViewController

- (id)init
{
    self = [super initWithNibName:@"MoreViewController" bundle:nil];
    
    if (self != nil) {
        self.title = @"More";
    }
    
    return self;
}

#pragma mark - TabBarControllerDelegate methods

- (TabBarItemView *)tabBarItemView
{
    TabBarItemView *tabBarItem = [TabBarController defaultTabBarItemView];
    tabBarItem.item.title = @"More";
    tabBarItem.item.image = [UIImage imageNamed:@"dot-more-7"];
    
    return tabBarItem;
}

#pragma mark - UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.viewControllers count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    TabBarController *tabBarController = (TabBarController *)self.tabBarController;
    TabBarItemView *tabBarItemView = [tabBarController tabBarItemViewForViewController:self.viewControllers[ indexPath.row ]];
    
    cell.textLabel.text = tabBarItemView.item.title;
    cell.imageView.image = tabBarItemView.item.image;
    
    cell.exclusiveTouch = YES;
    
    return cell;
}

#pragma mark - UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *viewController = self.viewControllers[ indexPath.row ];
        
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
