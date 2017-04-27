//
//  LeftViewController.m
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/3/24.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "LeftViewController.h"
#import "LeftTableViewCell.h"
#import "LeftUserHeadCell.h"
#import "LeftViewModel.h"
#import "AppDelegate.h"
#import "UIViewController+JASidePanel.h"
#import "LoginViewController.h"
#import "FixtureViewController.h"
#import "StandingViewController.h"
#import "TeamerViewController.h"
#import "VideoViewController.h"
#import "MainWebViewController.h"
#import "SettingViewController.h"
#import "PhotoListViewController.h"
#import "NewsListViewController.h"
#import "HomeViewController.h"
@interface LeftViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView * tabview;
@property (nonatomic, strong) LeftViewModel * viewModel;
//当前被选位置  默认为1 首页
@property (nonatomic, assign) NSInteger index;

@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatUI];
}
- (void)creatUI{
    self.index = 1;
    self.viewModel = [[LeftViewModel alloc]init];
    self.tabview = [BYFactory creatTabviewWithFrame:CGRectMake(0, Anno750(60), UI_WIDTH * 0.8, UI_HEGIHT - Anno750(60)) style:UITableViewStylePlain];
    self.tabview.delegate = self;
    self.tabview.dataSource = self;
    [self.view addSubview:self.tabview];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.viewModel.ZNtitles.count+1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return Anno750(210);
    }
    return Anno750(90);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        static NSString * headCellID = @"userHeadCellID";
        LeftUserHeadCell * cell = [tableView dequeueReusableCellWithIdentifier:headCellID];
        if (!cell) {
            cell = [[LeftUserHeadCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:headCellID];
        }
        [cell updateUserInfo];
        if (self.index == 0) {
            cell.redView.hidden = NO;
            cell.grayView.hidden =NO;
        }else{
            cell.redView.hidden = YES;
            cell.grayView.hidden =YES;
        }
        return cell;
    }
    static NSString * leftCellID = @"leftcell";
    LeftTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:leftCellID];
    if (!cell) {
        cell = [[LeftTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:leftCellID];
    }
    [cell updateWithZnTitle:self.viewModel.ZNtitles[indexPath.row - 1]
                    ENtitle:self.viewModel.ENtitles[indexPath.row - 1]
                   iconName:self.viewModel.icons[indexPath.row -1]];
    if (self.index == indexPath.row) {
        cell.redView.hidden = NO;
        cell.grayView.hidden =NO;
    }else{
        cell.redView.hidden = YES;
        cell.grayView.hidden =YES;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UINavigationController * nav;
    if (indexPath.row == 0) {
        nav = [[UINavigationController alloc]initWithRootViewController:[LoginViewController new]];
    }else if (indexPath.row == 1) {
        nav = [[UINavigationController alloc]initWithRootViewController:[HomeViewController new]];
    }else if(indexPath.row == 2){
        nav = [[UINavigationController alloc]initWithRootViewController:[NewsListViewController new]];
    }else if(indexPath.row == 3){
        nav = [[UINavigationController alloc]initWithRootViewController:[PhotoListViewController new]];
    }else if(indexPath.row == 4){
        nav = [[UINavigationController alloc]initWithRootViewController:[VideoViewController new]];
    }else if(indexPath.row == 5){
        nav = [[UINavigationController alloc]initWithRootViewController:[FixtureViewController new]];
    }else if(indexPath.row == 6){
        nav = [[UINavigationController alloc]initWithRootViewController:[StandingViewController new]];
    }else if(indexPath.row == 7){
        nav = [[UINavigationController alloc]initWithRootViewController:[TeamerViewController new]];
    }else if(indexPath.row == 8){
        MainWebViewController * web = [[MainWebViewController alloc]initWithTitle:@"俱乐部" url:@"http://www.fcbayern.cn/club?app=1"];
        nav = [[UINavigationController alloc]initWithRootViewController:web];
    }else if(indexPath.row == 9){
        MainWebViewController * web = [[MainWebViewController alloc]initWithTitle:@"商店" url:@"http://fcb.tmall.hk"];
        nav = [[UINavigationController alloc]initWithRootViewController:web];
    }else if(indexPath.row == 10){
        nav = [[UINavigationController alloc]initWithRootViewController:[SettingViewController new]];
    }
    self.index = indexPath.row;
    [self.tabview reloadData];
    self.sidePanelController.centerPanel = nav;
}
@end
