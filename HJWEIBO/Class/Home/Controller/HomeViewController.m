//
//  HomeViewController.m
//  weibo
//
//  Created by 黄杰 on 15/12/8.
//  Copyright © 2015年 黄杰. All rights reserved.
//

#import "HomeViewController.h"
#import "HJDropdownMenu.h"
#import "UIBarButtonItem+Extension.h"
#import "AFNetworking.h"
#import "AccountTool.h"
#import "UIImageView+WebCache.h"
#import "HJUrse.h"
#import "HJStatus.h"
#import "MJExtension.h"
#import "Loadmore.h"
#import "AccountTool.h"
@interface HomeViewController ()<HJDropdownMenuDelegate,UITableViewDelegate,UITableViewDataSource>


@property(nonatomic,strong)NSMutableArray *atatuses;


@end


@implementation HomeViewController

-(NSMutableArray *)atatuses
{
    if (!_atatuses) {
        self.atatuses = [[NSMutableArray alloc]init];;
    }
    return _atatuses;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
    [self setupUseInfo];
//    [self loadNewStatus];
    [self setupUPRefresh];
    [self setupDownRefresh];
}



-(void)setupUPRefresh
{
    Loadmore *foot = [Loadmore footer];
    foot.hidden = YES;
    self.tableView.tableFooterView = foot;
}
-(void)setupDownRefresh
{
    UIRefreshControl *refresh = [[UIRefreshControl alloc]init];
    [refresh addTarget:self action:@selector(refreshChenge:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refresh];
    [refresh beginRefreshing];
    [self refreshChenge:refresh];
}
-(void)refreshChenge:(UIRefreshControl *)refresh
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    AccountModel *account = [AccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    HJStatus *first = [self.atatuses firstObject];
    //    params[@"count"] = @1;
    if (first) {
        params[@"since_id"] = first.idstr;
    }
    
    
    [manager GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        NSLog(@"-------%@",responseObject);
        
        NSArray *new = [HJStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        NSRange range = NSMakeRange(0, new.count);
        
        NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:range];
//        [self.atatuses addObjectsFromArray:new];
        [self.atatuses insertObjects:new atIndexes:set];
        
        [refresh endRefreshing];
        [self.tableView reloadData];
        
        [self showNewStatusCount:new.count];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
         [refresh endRefreshing];
    }];
}


-(void)showNewStatusCount:(NSInteger)count
{
    UILabel *lable = [[UILabel alloc]init];
    lable.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    lable.width = [UIScreen mainScreen].bounds.size.width;
    lable.height = 35;
    lable.textAlignment = NSTextAlignmentCenter;
    if (count==0) {
        lable.text =@"没有新的微博";
    }
    else
    {
        lable.text = [NSString stringWithFormat:@"共有%ld条微博更新",count];
    }
    lable.y = 64-lable.height;
    lable .textColor = [UIColor whiteColor];
    [self.navigationController.view insertSubview:lable belowSubview:self.navigationController.navigationBar];
    [UIView animateWithDuration:1.0 animations:^{
//        lable.y +=lable.height;
        lable.transform = CGAffineTransformMakeTranslation(0, lable.height);
    } completion:^(BOOL finished) {
//        [UIView animateWithDuration:1 animations:^{
//            lable.y -= lable.height;
//        }];
        [UIView animateWithDuration:1.0 delay:1.0 options:UIViewAnimationOptionCurveLinear animations:^{
//            lable.y -= lable.height;
            lable.transform = CGAffineTransformIdentity; 
            
        } completion:^(BOOL finished) {
            
            [lable removeFromSuperview];
        }];
        
    }];
}
-(void)loadNewStatus
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    AccountModel *account = [AccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
//    params[@"count"] = @1;
    
    [manager GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        NSLog(@"-------%@",responseObject);

        NSArray *new = [HJStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        
        [self.atatuses addObjectsFromArray:new];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
    }];

}

-(void)setupUseInfo
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    AccountModel *account = [AccountTool account];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"uid"] = account.uid;
   
    [manager GET:@"https://api.weibo.com/2/users/show.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        HJUrse *user = [HJUrse objectWithKeyValues:responseObject];
//        NSString *name = responseObject[@"name"];
        UIButton *btn = (UIButton *)self.navigationItem.titleView;
        [btn setTitle:user.name forState:UIControlStateNormal];
        
//        把昵称存到沙河中
        account.name = user.name;
        [AccountTool saveAccount:account];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    
        
    }];
}

- (void)setupNav
{
    /* 设置导航栏上面的内容 */
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(friendSearch) image:@"navigationbar_friendsearch" highImage:@"navigationbar_friendsearch_highlighted"];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(pop) image:@"navigationbar_pop" highImage:@"navigationbar_pop_highlighted"];

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.width = 150;
    btn.height = 30;
//    btn.backgroundColor = HWRandomColor;
    NSString *name = [AccountTool account].name;
    [btn setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
    [btn setTitle:name?name:@"首页" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = btn.titleLabel.font;
    CGFloat titlew = [btn.currentTitle sizeWithAttributes:attrs].width;
    CGFloat imagew = btn.imageView.width *[UIScreen mainScreen].scale;
    CGFloat left = titlew+imagew;
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, left, 0, 0);
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 50);
    [btn addTarget:self action:@selector(Click:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = btn;
}
- (void)friendSearch
{
    NSLog(@"friendSearch");
    
}


- (void)pop
{
    NSLog(@"pop");
}
-(void)Click:(UIButton *)btn
{
    HJDropdownMenu *menu = [[HJDropdownMenu alloc]init];
    
    menu.delegate = self;
    
    UITableView *table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
    
    menu.content = table;
    [menu showFrom:btn];
//    [btn setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
}

-(void)dropdownMenuDidmiss:(HJDropdownMenu *)menu
{
    UIButton *btn = (UIButton *)self.navigationItem.titleView;
    btn.selected = NO;
//    [btn setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
}

-(void)dropdownMenuDidshow:(HJDropdownMenu *)menu
{
    UIButton *btn = (UIButton *)self.navigationItem.titleView;
    btn.selected = YES;
//    [btn setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.atatuses.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
//    NSMutableDictionary *status =self.atatuses[indexPath.row];
    HJStatus *status = self.atatuses[indexPath.row];
//    NSDictionary *user = status[@"user"];
//    HJUrse *urse = [[HJUrse alloc]init]
    HJUrse *user= status.user;
    
    NSLog(@"***********%@",user);
//    cell.textLabel.text = user[@"name"];
    cell.textLabel.text = user.name;
    
//    cell.detailTextLabel.text = status[@"text"];
    cell.detailTextLabel.text = status.text;
//    NSString *imageUrl = user[@"profile_image_url"];
//    NSString *imageUrl = user.profile_image_url;
//    占位符
    UIImage *placehoder = [UIImage imageNamed:@"avatar_default_small"];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:placehoder];
    return cell;
}



@end
