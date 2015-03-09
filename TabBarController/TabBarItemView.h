//
//  TabBarItemView.h
//  TabBarController
//
//  Created by Denys.Meloshyn on 06/03/15.
//  Copyright (c) 2015 Denys Meloshyn. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TabBarItemViewDelegate <NSObject>

@optional
- (void)tabBarItemSelected:(UIView *)sender;

@end

@interface TabBarItemView : UIView

- (void)setTabBarItemSelected:(BOOL)isSelected;

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, weak) id <TabBarItemViewDelegate> delegate;
@property (nonatomic, strong) NSLayoutConstraint *widthConstraint;

@end
