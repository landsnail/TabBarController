//
//  TabBarItemView.m
//  TabBarController
//
//  Created by Denys.Meloshyn on 06/03/15.
//  Copyright (c) 2015 Denys Meloshyn. All rights reserved.
//

#import "TabBarItemView.h"

#define TAB_BAR_ITEM_SELECTED_COLOR [UIColor colorWithRed:61.0 / 255.0 green:96.0 / 255.0 blue:254.0 / 255.0 alpha:1.0]
#define TAB_BAR_ITEM_DESELECTED_COLOR [UIColor colorWithRed:136.0 / 255.0 green:136.0 / 255.0 blue:136.0 / 255.0 alpha:1.0]

@implementation TabBarItemView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    if (self.item == nil) {
        self.item = [[TabBarItem alloc] init];
        self.item.delegate = self;
    }
}

- (id)init
{
    self = [super init];
    
    if (self != nil) {
        self.item = [[TabBarItem alloc] init];
        self.item.delegate = self;
    }
    
    return self;
}

- (id)initWithItem:(TabBarItem *)item
{
    self = [super init];
    
    if (self != nil) {
        self.item = item;
        self.item.delegate = self;
    }
    
    return self;
}

#pragma mark - Custom setter methods

- (void)setItem:(TabBarItem *)item
{
    if (_item != item) {
        _item = item;
        [self updateView];
    }
}

#pragma mark - TabBarItemDelegate methods

- (void)itemValueChanged:(id)sender
{
    [self updateView];
}

#pragma mark - Public methods

- (void)updateView
{
    self.titleLabel.text = self.item.title;
    self.iconImage.image = self.item.image;
}

- (void)setTabBarItemSelected:(BOOL)isSelected
{
    if (isSelected) {
        self.titleLabel.textColor = TAB_BAR_ITEM_SELECTED_COLOR;
    }
    else {
        self.titleLabel.textColor = TAB_BAR_ITEM_DESELECTED_COLOR;
    }
}

#pragma mark - IBAction methods

- (IBAction)selectTabBarItem:(id)sender
{
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(tabBarItemSelected:)]) {
        [self.delegate tabBarItemSelected:self];
    }
}

@end
