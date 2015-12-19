//
//  HomeViewController.m
//  侧边tableView的抽屉
//
//  Created by Ssuperjoy on 15/11/22.
//  Copyright © 2015年 Mr.Zhang. All rights reserved.
//

#import "HomeNavViewController.h"
#import "BackViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "TableViewController.h"

#define moveMin 0.1 // 拖拽最小移动距离
#define screenX 0.448 // 滑动到屏幕位置的比例

@interface HomeNavViewController ()<BackViewControllerDelegate>
@property (nonatomic, weak) UIButton *coverBtn;
@end

@implementation HomeNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置BackView的代理
    BackViewController *backVc = [BackViewController sharedBackVc];
    backVc.delegate = self;
    
    // 添加手势
    UIPanGestureRecognizer *panGest = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panView:)];
    [self.view addGestureRecognizer:panGest];
    
    // 设置阴影
    self.view.layer.shadowColor = [UIColor blackColor].CGColor;
    self.view.layer.shadowOffset = CGSizeMake(-3, 0);
    self.view.layer.shadowOpacity = 0.2;
}

// 拖动首页的时候调用
- (void)panView:(UIPanGestureRecognizer *)panGest
{
    if (self.childViewControllers.count > 1) {
        return;
    }
    //    NSLog(@"-------gest--------");
    CGPoint trans = [panGest translationInView:panGest.view];
    
    CGPoint center = panGest.view.center;
    
    CGFloat centerX = [UIScreen mainScreen].bounds.size.width / 2;
    CGFloat rightLimit = [UIScreen mainScreen].bounds.size.width * screenX + centerX;
    
    // 为了既能快速的移动抽屉，又能够不超出距离，用下面的方法进行限制。
    if (trans.x > moveMin) {//view向右移动
        for (float i = 0; i < trans.x; i += moveMin) {//细化移动距离，防止移动超过下面的view宽度
            if (center.x > rightLimit) // 每加一次都进行判断
            {
                break;
            }
            center.x += moveMin;
        }
    }
    
    if(trans.x < - moveMin){//view向左移动
        for (float i = 0; i > trans.x; i -= moveMin) {
            if (center.x < centerX)
            {
                break;
            }
            center.x -= moveMin;
        }
    }
    
    panGest.view.center = center;
    //    self.view.frame.origin.x = panGest.view.frame.origin.x;
    
    [panGest setTranslation:CGPointZero inView:panGest.view];  // 清空trans
    
    if (panGest.state == UIGestureRecognizerStateEnded) { // 拖拽结束时调用
        CGRect testFrame = panGest.view.frame;
        if (testFrame.origin.x >= 90) {  // 判断大于某个值时，到一个特定的位置
            testFrame.origin.x = rightLimit - centerX;
            [self addCoverWithView:panGest.view];
        } else if (testFrame.origin.x < 90) {  // 小于某个值是，到最原始的位置
            testFrame.origin.x = 0;
            //            [self coverClick:self.coverBtn];
            [self.coverBtn removeFromSuperview];
            
        }
        [UIView animateWithDuration:0.15 animations:^{
            panGest.view.frame = testFrame;    // 以动画的方式，到达预定位置
            
        }];
    }
}

- (void)addCoverWithView:(UIView *)coverdView
{
    if (!self.coverBtn) {
        UIButton *cover = [[UIButton alloc] init];
        [cover addTarget:self action:@selector(coverClick:) forControlEvents:UIControlEventTouchUpInside];
        cover.frame = coverdView.bounds;
        self.coverBtn = cover;
        [coverdView addSubview:cover];
    }
}

- (void)coverClick:(UIButton *)cover
{
    [UIView animateWithDuration:0.15 animations:^{
        // 待解决
        self.view.frame = [UIScreen mainScreen].bounds;
    } completion:^(BOOL finished) {
        [cover removeFromSuperview];
    }];
}

#pragma mark - BackViewController代理方法
- (void)backViewPushToVc:(UIViewController *)viewController
{
    // 防止tableViewCell被多次点击
    if (self.childViewControllers.count > 1) {
        return;
    }
    [UIView animateWithDuration:0.15 animations:^{
        [self coverClick:self.coverBtn];

        // 切换控制器
        [self pushViewController:viewController animated:NO];
    }];
}

- (void)backViewDidClickLeftItem
{
    [UIView animateWithDuration:0.15 animations:^{
        // 取出正在显示的导航控制器的view
        UIView *showingView = self.view;
        
        // 点击munu后进行变换
        CGFloat offX = [UIScreen mainScreen].bounds.size.width * screenX;
        CGRect frame = showingView.frame;
        if (frame.origin.x == 0) {
            frame.origin.x = offX;
            showingView.frame = frame;
            [self addCoverWithView:showingView];
        } else {
            showingView.frame = [UIScreen mainScreen].bounds;
        }
    }];

}


@end
