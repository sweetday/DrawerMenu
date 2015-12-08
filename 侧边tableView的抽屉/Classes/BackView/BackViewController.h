//
//  ViewController.h
//  侧边tableView的抽屉
//
//  Created by Ssuperjoy on 15/11/22.
//  Copyright © 2015年 Mr.Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BackViewController;

@protocol BackViewControllerDelegate <NSObject>

@optional
- (void)backViewDidSelectRow:(UIViewController *)viewController;
// 点击左上角后，出现抽屉效果，通知代理让首页去完成
- (void)backViewDidClickLeftItem;
@end

@interface BackViewController : UIViewController
@property (nonatomic, weak) id<BackViewControllerDelegate> delegate;

+ (instancetype)sharedBackVc;

@end

