//
//  NavigationController.m
//  侧边tableView的抽屉
//
//  Created by Ssuperjoy on 15/11/22.
//  Copyright © 2015年 Mr.Zhang. All rights reserved.
//

#import "NavigationController.h"

@interface NavigationController ()

@end

@implementation NavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 类第一次使用的时候被调用
+(void)initialize{
    
#warning 一般设置导航条背景，不会在导航控制器的子控制器里设置
    // 1.设置导航条的背题图片 --- 设置全局
    UINavigationBar *navBar = [UINavigationBar appearance];
    [navBar setBackgroundImage:[UIImage imageNamed:@"NavBar64"] forBarMetrics:UIBarMetricsDefault];
    
    // 2.UIApplication设置状态栏的样式
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    // 3.设置导航条标题的字体和颜色
    NSDictionary *titleAttr = @{
                                NSForegroundColorAttributeName:[UIColor whiteColor],
                                NSFontAttributeName:[UIFont systemFontOfSize:20]
                                };
    [navBar setTitleTextAttributes:titleAttr];
    
    //设置返回按钮的样式
    //tintColor是用于导航条的所有Item
    navBar.tintColor = [UIColor whiteColor];
    
    UIBarButtonItem *navItem = [UIBarButtonItem appearance];

    //设置Item的字体大小
    [navItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} forState:UIControlStateNormal];
}

@end
