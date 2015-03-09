//
//  TabBarItem.h
//  TabBarController
//
//  Created by Denys.Meloshyn on 09/03/15.
//  Copyright (c) 2015 Denys Meloshyn. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TabBarItemDelegate <NSObject>

@optional
- (void)itemValueChanged:(id)sender;

@end

@interface TabBarItem : NSObject

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, weak) id <TabBarItemDelegate> delegate;

- (void)valueChanged:(id)sender;

@end
