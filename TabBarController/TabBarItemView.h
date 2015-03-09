//
//  TabBarItemView.h
//  TabBarController
//
//  Created by Denys.Meloshyn on 06/03/15.
//  Copyright (c) 2015 Denys Meloshyn. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TabBarItem.h"

@protocol TabBarItemViewDelegate <NSObject>

@optional
- (void)tabBarItemSelected:(UIView *)sender;

@end

@interface TabBarItemView : UIView <TabBarItemDelegate>

- (void)updateView;
- (id)initWithItem:(TabBarItem *)item;
- (void)setTabBarItemSelected:(BOOL)isSelected;

@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UIImageView *iconImage;

@property (nonatomic, strong) TabBarItem *item;
@property (nonatomic, weak) id <TabBarItemViewDelegate> delegate;
@property (nonatomic, strong) NSLayoutConstraint *widthConstraint;

@end
