//
//  MessageViewController.m
//  weibo
//
//  Created by 黄杰 on 15/12/8.
//  Copyright © 2015年 黄杰. All rights reserved.
//

#import "MessageViewController.h"
#import "TestViewController.h"
#import "HJNaviViewController.h"
@interface MessageViewController ()
{
    
    UITableView *_tableView;
}

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TestViewController *test = [[TestViewController alloc]init];
    test.title = @"Test";
    [self.navigationController pushViewController:test animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 20;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    cell.textLabel.text =[NSString stringWithFormat:@"刘惠阳---%ld",indexPath.row];
    
    return cell;
}

@end
