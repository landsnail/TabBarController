//
//  MoreViewController.h
//  TabBarController
//
//  Created by Denys.Meloshyn on 06/03/15.
//  Copyright (c) 2015 Denys Meloshyn. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TabBarController.h"

@interface MoreViewController : UIViewController <TabBarControllerDelegate>

@property (nonatomic, copy) NSArray *viewControllers;

@end
