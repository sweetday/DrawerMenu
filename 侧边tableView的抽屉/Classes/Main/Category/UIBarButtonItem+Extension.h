//
//  UIBarButtonItem+Extension.h
//  侧边tableView的抽屉
//
//  Created by Ssuperjoy on 15/11/23.
//  Copyright © 2015年 Mr.Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage;

@end
