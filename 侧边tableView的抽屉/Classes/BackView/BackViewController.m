//
//  ViewController.m
//  侧边tableView的抽屉
//
//  Created by Ssuperjoy on 15/11/22.
//  Copyright © 2015年 Mr.Zhang. All rights reserved.
//

#import "BackViewController.h"
#import "HomeNavViewController.h"
#import "NavigationController.h"
#import "UIBarButtonItem+Extension.h"
#import "HomeTableViewController.h"
#import "TableViewController.h"

@interface BackViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableMenu;
@end

@implementation BackViewController

#pragma mark - 单例设计模式
static id _instance;

/**
 *  alloc方法内部会调用这个方法
 */
+ (id)allocWithZone:(struct _NSZone *)zone
{
    if (_instance == nil) { // 防止频繁加锁
        @synchronized(self) {
            if (_instance == nil) { // 防止创建多次
                _instance = [super allocWithZone:zone];
            }
        }
    }
    return _instance;
}

+ (instancetype)sharedBackVc
{
    if (_instance == nil) { // 防止频繁加锁
        @synchronized(self) {
            if (_instance == nil) { // 防止创建多次
                _instance = [[self alloc] init];
            }
        }
    }
    return _instance;
}

- (id)copyWithZone:(NSZone *)zone
{
    return _instance;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 背面tableView
    self.tableMenu = [[UITableView alloc] init];
    self.tableMenu.frame = CGRectMake(0, 20, self.view.frame.size.width * 0.45, self.view.frame.size.height - 20);
    self.tableMenu.backgroundColor = [UIColor grayColor];
    
    self.tableMenu.delegate = self;
    self.tableMenu.dataSource = self;
    [self.view addSubview:self.tableMenu];
    
    // 首页
    HomeTableViewController *homeViewVc = [[HomeTableViewController alloc] init];
    HomeNavViewController *homeNavVc = [[HomeNavViewController alloc] initWithRootViewController:homeViewVc];
    homeViewVc.view.backgroundColor = [UIColor whiteColor];
    homeViewVc.navigationItem.title = @"首页";
    [self.view addSubview:homeNavVc.view];
    [self addChildViewController:homeNavVc];
    
    // 设置左侧item
    homeViewVc.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(leftItemClick) image:@"slide_nor" highImage:@"slide_sel"];
}

- (void)leftItemClick
{
    if ([self.delegate respondsToSelector:@selector(backViewDidClickLeftItem)]) {
        [self.delegate backViewDidClickLeftItem];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"CellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld个Controller",(long)indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return  cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"第%ld个Section", section];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
#warning 根据自己的需要在这里自定义每点击一个cell创建的控制器。
    
    if (indexPath.row == 0) {
        UIViewController *vc = [[UIViewController alloc] init];
        vc.view.backgroundColor = [UIColor whiteColor];
        if ([self.delegate respondsToSelector:@selector(backViewPushToVc:)]) {
            [self.delegate backViewPushToVc:vc];
        }
    } else {
        TableViewController *tableVc = [[TableViewController alloc] init];
        tableVc.view.backgroundColor = [UIColor whiteColor];
        if ([self.delegate respondsToSelector:@selector(backViewPushToVc:)]) {
            [self.delegate backViewPushToVc:tableVc];
        }
    }
}



// 设置状态栏样式
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}




@end
