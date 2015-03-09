//
//  TabBarItemView.m
//  TabBarController
//
//  Created by Denys.Meloshyn on 06/03/15.
//  Copyright (c) 2015 Denys Meloshyn. All rights reserved.
//

#import "TabBarItemView.h"

@interface TabBarItemView ()

@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UIImageView *iconImage;

@end

@implementation TabBarItemView

#pragma mark - Custom setters

- (void)setTitle:(NSString *)title
{
    if (_title != title) {
        _title = title;
        self.titleLabel.text = _title;
    }
}

- (void)setImage:(UIImage *)image
{
    if (_image != image) {
        _image = image;
        self.iconImage.image = image;
    }
}

#pragma mark - Public methods

- (void)setTabBarItemSelected:(BOOL)isSelected
{
    if (isSelected) {
        self.titleLabel.textColor = [UIColor colorWithRed:61.0 / 255.0 green:96.0 / 255.0 blue:254.0 / 255.0 alpha:1.0];
    }
    else {
        self.titleLabel.textColor = [UIColor colorWithRed:136.0 / 255.0 green:136.0 / 255.0 blue:136.0 / 255.0 alpha:1.0];
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
