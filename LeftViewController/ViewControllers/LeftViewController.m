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
#import "UserCenterViewController.h"
#import "UserManager.h"
@interface LeftViewController ()<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic, strong) LeftViewModel * viewModel;


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
        if ([UserManager manager].isLogin) {
            nav = [[UINavigationController alloc]initWithRootViewController:[UserCenterViewController new]];
            [MobClick event:EventID_Topbar attributes:@{KN_MainNav:@"TabUserInfo"}];
        }else{
            LoginViewController * vc = [[LoginViewController alloc]init];
            vc.isFromLeft = YES;
            nav = [[UINavigationController alloc]initWithRootViewController:vc];
        }
    }else if (indexPath.row == 1) {
        nav = [[UINavigationController alloc]initWithRootViewController:[HomeViewController new]];
        [MobClick event:EventID_Topbar attributes:@{KN_MainNav:@"TabIndex"}];
    }else if(indexPath.row == 2){
        nav = [[UINavigationController alloc]initWithRootViewController:[NewsListViewController new]];
        [MobClick event:EventID_Topbar attributes:@{KN_MainNav:@"TabNews"}];
    }else if(indexPath.row == 3){
        nav = [[UINavigationController alloc]initWithRootViewController:[PhotoListViewController new]];
        [MobClick event:EventID_Topbar attributes:@{KN_MainNav:@"TabPhotos"}];
    }else if(indexPath.row == 4){
        nav = [[UINavigationController alloc]initWithRootViewController:[VideoViewController new]];
        [MobClick event:EventID_Topbar attributes:@{KN_MainNav:@"TabVideos"}];
    }else if(indexPath.row == 5){
        nav = [[UINavigationController alloc]initWithRootViewController:[FixtureViewController new]];
        [MobClick event:EventID_Topbar attributes:@{KN_MainNav:@"TabFixtures"}];
    }else if(indexPath.row == 6){
        nav = [[UINavigationController alloc]initWithRootViewController:[StandingViewController new]];
        [MobClick event:EventID_Topbar attributes:@{KN_MainNav:@"TabStandings"}];
    }else if(indexPath.row == 7){
        nav = [[UINavigationController alloc]initWithRootViewController:[TeamerViewController new]];
        [MobClick event:EventID_Topbar attributes:@{KN_MainNav:@"TabTeam"}];
    }else if(indexPath.row == 8){
        MainWebViewController * web = [[MainWebViewController alloc]initWithTitle:@"俱乐部" url:@"http://www.fcbayern.cn/club?app=1" andFromType:FromTypeWeb];
        nav = [[UINavigationController alloc]initWithRootViewController:web];
        [MobClick event:EventID_Topbar attributes:@{KN_MainNav:@"TabClub"}];
    }else if(indexPath.row == 9){
        MainWebViewController * web = [[MainWebViewController alloc]initWithTitle:@"商店" url:@"http://fcb.tmall.hk" andFromType:FromTypeWeb];
        nav = [[UINavigationController alloc]initWithRootViewController:web];
        [MobClick event:EventID_Topbar attributes:@{KN_MainNav:@"TabShop"}];
    }else if(indexPath.row == 10){
        nav = [[UINavigationController alloc]initWithRootViewController:[SettingViewController new]];
        [MobClick event:EventID_Topbar attributes:@{KN_MainNav:@"TabSettings"}];
    }
    self.index = indexPath.row;
    [self.tabview reloadData];
    self.sidePanelController.centerPanel = nav;
}
@end
