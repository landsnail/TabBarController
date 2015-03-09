//
//  TabBarItem.m
//  TabBarController
//
//  Created by Denys.Meloshyn on 09/03/15.
//  Copyright (c) 2015 Denys Meloshyn. All rights reserved.
//

#import "TabBarItem.h"

@implementation TabBarItem

#pragma mark - Custom setters

- (void)setTitle:(NSString *)title
{
    if (_title != title) {
        _title = title;
        
        [self valueChanged:title];
    }
}

- (void)setImage:(UIImage *)image
{
    if (_image != image) {
        _image = image;
        
        [self valueChanged:image];
    }
}

#pragma mark - Public methods

- (void)valueChanged:(id)sender
{
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(itemValueChanged:)]) {
        [self.delegate itemValueChanged:sender];
    }
}

@end
