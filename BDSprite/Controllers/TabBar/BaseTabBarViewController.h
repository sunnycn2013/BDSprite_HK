//
//  BaseTabBarViewController.h
//  BDSprite
//
//  Created by Aufree on 9/21/15.
//  Copyright (c) 2015 ESTGroup. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTabBarViewController : UITabBarController <UITabBarControllerDelegate>
- (void)setupTabBarItems;
- (void)pushToViewController:(UIViewController *)viewController animated:(BOOL)animated;
- (void)presentToViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(void (^)(void))completion;
@end
