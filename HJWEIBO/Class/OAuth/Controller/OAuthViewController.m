//
//  OAuthViewController.m
//  HJWEIBO
//
//  Created by 黄杰 on 16/1/5.
//  Copyright © 2016年 黄杰. All rights reserved.
//

#import "OAuthViewController.h"
#import "AFNetworking.h"
#import "AccountModel.h"
#import "MBProgressHUD+MJ.h"
#import "AccountTool.h"
@interface OAuthViewController ()<UIWebViewDelegate>

@end

@implementation OAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    
//    App Key：3607587208
//    App Secret：aa278182d3cbc0280adabac62df42028
//    "access_token" = "2.00lKwVKC9OEJwD8bf487099dnLTt_E";
//    uid = 1987640811;
    
    UIWebView *webView = [[UIWebView alloc]init];
    webView.frame = self.view.bounds;
    webView.delegate = self;
    [self.view addSubview:webView];
    
    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=3607587208&redirect_uri=http://"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUD];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showMessage:@"正在加载..."];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    NSString *url = request.URL.absoluteString;
    NSRange rang = [url rangeOfString:@"code="];
    if (rang.length!=0) {
        NSInteger fromIndex = rang.location+rang.length;
        NSString *code = [url substringFromIndex:fromIndex];
        NSLog(@"------------%@,%@",code,url);
        [self accessTokenWithCode:code];
        
    }

    NSLog(@"shouldStartLoadWithRequest--------%@",request.URL.absoluteURL);
    return YES;
}
-(void)accessTokenWithCode:(NSString *)code
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = @"3607587208";
    params[@"client_secret"] = @"aa278182d3cbc0280adabac62df42028";
    params[@"grant_type"] = @"authorization_code";
    params[@"redirect_uri"] = @"http://";
    params[@"code"] = code;

    [manager POST:@"https://api.weibo.com/oauth2/access_token" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        [MBProgressHUD hideHUD];
        
        
        AccountModel *account = [AccountModel accountWithdict:responseObject];
        
        [AccountTool saveAccount:account];

        [UIWindow swithRooViewController];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideHUD];
        
    }];
}
@end
