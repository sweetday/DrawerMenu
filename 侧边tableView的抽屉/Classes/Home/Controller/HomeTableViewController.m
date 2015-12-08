//
//  HomeTableViewController.m
//  侧边tableView的抽屉
//
//  Created by Ssuperjoy on 15/11/24.
//  Copyright © 2015年 Mr.Zhang. All rights reserved.
//

#import "HomeTableViewController.h"

@implementation HomeTableViewController

- (void)viewDidLoad
{
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"这是首页的第%ld行", indexPath.row];
    
    return cell;
}
@end
