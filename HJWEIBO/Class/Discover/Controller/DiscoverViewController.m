//
//  DiscoverViewController.m
//  weibo
//
//  Created by 黄杰 on 15/12/8.
//  Copyright © 2015年 黄杰. All rights reserved.
//

#import "DiscoverViewController.h"
#import "HJSearchBar.h"
@interface DiscoverViewController ()

@end

@implementation DiscoverViewController


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    HJSearchBar *searchBar = [HJSearchBar SearchBar];
    searchBar.width = 300;
    searchBar.height = 30;
    self.navigationItem.titleView = searchBar;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 0;
}


@end
