//
//  HomeViewController.m
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/4/24.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "HomeViewController.h"
#import "AutoScrollView.h"
#import "HomeNewsTableViewCell.h"
#import "HomeAdTableViewCell.h"
#import "HomeVideoTableViewCell.h"
#import "HomeTeamerTableViewCell.h"
#import "HomeFixtureCell.h"
#import "HomeViewModel.h"
#import "NewsListModel.h"


#import "PhotoDetailViewController.h"
#import "NewsDetailViewController.h"
#import "TeamerDetailViewController.h"
#import "MainWebViewController.h"
#import "NewsListViewController.h"
#import <JPUSHService.h>
@interface HomeViewController ()<UITableViewDelegate, UITableViewDataSource,HomeTeamerDelegate,HomeFixtureDelegate>

@property (nonatomic, strong) UITableView * tabview;
@property (nonatomic, strong) AutoScrollView * headScolView;
@property (nonatomic, strong) AutoScrollView * videoScolView;
@property (nonatomic, strong) HomeViewModel * viewModel;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatBackGroundImage];
    [self setNavigationTitle:@"首页"];
    [self drawMainSearchTabItem];
    [self creatUI];
    [self creatNetWorkQueue];
}

- (void)creatUI{
    self.viewModel = [[HomeViewModel alloc]init];
    
    self.tabview = [BYFactory creatTabviewWithFrame:CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT - 64) style:UITableViewStyleGrouped];
    self.tabview.delegate = self;
    self.tabview.dataSource = self;
    [self.view addSubview:self.tabview];
    [self creatHeadView];
}
- (void)creatHeadView{
    self.headScolView = [[AutoScrollView alloc]initWithFrame:CGRectMake(0, 0, UI_WIDTH, Anno750(330))];
    if (self.viewModel.headFocus.count>0) {
        [self.headScolView updateWithImages:self.viewModel.HeadFocusImages descs:self.viewModel.HeadFocusTitles];
    }
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(HeadFocusClick:)];
    [self.headScolView addGestureRecognizer:tap];
    self.tabview.tableHeaderView = self.headScolView;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 3;
    }
    
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            return Anno750(150);
        case 1:
            return Anno750(140);
        case 2:
            return Anno750(340);
        case 3:
        case 4:
            return Anno750(200);
        default:
            return 0;
            break;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return Anno750(100);
    }else if(section == 1){
        return Anno750(20);
    }
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 2) {
        return Anno750(400);
    }
    return Anno750(20);
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 2) {
        UIView * header = [BYFactory creatViewWithColor:[UIColor clearColor]];
        header.frame = CGRectMake(0, 0, UI_WIDTH, Anno750(400));
        self.videoScolView = [[AutoScrollView alloc]initWithFrame:CGRectMake(Anno750(24), 0, Anno750(702), Anno750(380))];
        if (self.viewModel.videoFocus.count>0) {
            [self.videoScolView updateWithImages:self.viewModel.VideoFocusImages descs:self.viewModel.VideoFocusTitles];
        }
        [header addSubview:self.videoScolView];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(videoFocuClick)];
        [self.videoScolView addGestureRecognizer:tap];
        return header;
    }
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 0) {
        UIView * footerView = [BYFactory creatViewWithColor:[UIColor clearColor]];
        footerView.frame = CGRectMake(0, 0, UI_WIDTH, Anno750(100));
        UIView * grayView = [BYFactory creatViewWithColor:BYColor_Alpha_gray];
        [footerView addSubview:grayView];
        [grayView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(Anno750(24)));
            make.right.equalTo(@(-Anno750(24)));
            make.top.equalTo(@0);
            make.bottom.equalTo(@0);
        }];
        UIButton * checkAllNews = [BYFactory creatButtonWithTitle:@"全部新闻"
                                                  backGroundColor:[UIColor clearColor]
                                                        textColor:BYColor_Main
                                                         textSize:font750(30)];
        checkAllNews.layer.borderColor = BYColor_Main.CGColor;
        checkAllNews.layer.borderWidth = 1.0f;
        checkAllNews.layer.cornerRadius = Anno750(30);
        [grayView addSubview:checkAllNews];
        [checkAllNews mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(@0);
            make.centerY.equalTo(@0);
            make.height.equalTo(@(Anno750(60)));
            make.width.equalTo(@(Anno750(250)));
        }];
        [checkAllNews addTarget:self action:@selector(checkAllNews) forControlEvents:UIControlEventTouchUpInside];
        return footerView;
    }
    return nil;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
        {
            static NSString * cellid = @"newsCell";
            HomeNewsTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
            if (!cell) {
                cell = [[HomeNewsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
            }
            if (self.viewModel.news.count>0) {
                [cell updateWithModel:self.viewModel.news[indexPath.row]];
            }
            return cell;
        }
        case 1:
        {
            static NSString * cellid = @"adCell";
            HomeAdTableViewCell  * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
            if (!cell) {
                cell = [[HomeAdTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
            }
            [cell updateWithImageUrlStr:[NSString stringWithFormat:@"%@%@",Base_ImgHost,self.viewModel.adModel.pic]];
            return cell;
        }
        case 2:
        {
            static NSString * cellid = @"FixtueTabCell";
            HomeFixtureCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
            if (!cell) {
                cell = [[HomeFixtureCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
            }
            cell.delegate = self;
            [cell updateWithFixtures:self.viewModel.fixtures andindex:self.viewModel.index];
            return cell;
        }
        case 3:
        case 4:
        {
            static NSString * cellid = @"teamerCell";
            HomeTeamerTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
            if (!cell) {
                cell = [[HomeTeamerTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
            }
            if (indexPath.section == 4) {
                if (self.viewModel.teamers.count>1) {
                    [cell updateWithArrays:@[self.viewModel.teamers[0],self.viewModel.teamers[1]]];
                }
            }else{
                if (self.viewModel.teamers.count>3) {
                    [cell updateWithArrays:@[self.viewModel.teamers[2],self.viewModel.teamers[3]]];
                }
            }
            cell.delegate = self;
            return cell;
        }
        default:
            break;
    }
    
    
    return nil;
}

- (void)creatNetWorkQueue{
    //首页焦点
    [[NetWorkManger manager] sendRequest:Page_HomeFocus route:Route_Home withParams:@{} complete:^(NSDictionary *result) {
        NSArray * datas = result[@"data"];
        NSData * data = [NSJSONSerialization dataWithJSONObject:datas options:NSJSONWritingPrettyPrinted error:nil];
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"homeFocus"];
        NSMutableArray * muarr = [NSMutableArray new];
        for (int i = 0; i<datas.count; i++) {
            NSDictionary * dic = datas[i];
            VideoFocusModel * model = [[VideoFocusModel alloc]initWithDictionary:dic];
            [muarr addObject:model];
        }
        self.viewModel.headFocus = [NSArray arrayWithArray:muarr];
        [self.headScolView updateWithImages:self.viewModel.HeadFocusImages descs:self.viewModel.HeadFocusTitles];
    } error:^(BYError *byerror) {
        
    }];
    //首页新闻
    [[NetWorkManger manager]sendRequest:Page_HomeNews route:Route_Home withParams:@{@"limit":@"3"} complete:^(NSDictionary *result) {
        NSArray * datas = result[@"data"];
        NSData * data = [NSJSONSerialization dataWithJSONObject:datas options:NSJSONWritingPrettyPrinted error:nil];
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"homeNews"];
        NSMutableArray * muarr = [NSMutableArray new];
        for (int i = 0; i<datas.count; i++) {
            NSDictionary * dic = datas[i];
            NewsListModel * model = [[NewsListModel alloc]initWithDictionary:dic];
            [muarr addObject:model];
        }
        self.viewModel.news = [NSArray arrayWithArray:muarr];
        [self.tabview reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    } error:^(BYError *byerror) {
        
    }];
    //首页广告
    [[NetWorkManger manager] sendRequest:Page_HomeAd route:Route_Home withParams:@{} complete:^(NSDictionary *result) {
        NSArray * datas = result[@"data"];
        NSData * data = [NSJSONSerialization dataWithJSONObject:datas options:NSJSONWritingPrettyPrinted error:nil];
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"homeAd"];
        if (datas.count>0) {
            self.viewModel.adModel = [[HomeAdModel alloc]initWithDictionary:datas[0]];
            [self.tabview reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationMiddle];
        }
    } error:^(BYError *byerror) {
        
    }];
    //首页视频
    [[NetWorkManger manager] sendRequest:Page_HomeVideo route:Route_Home withParams:@{} complete:^(NSDictionary *result) {
        NSArray * datas = result[@"data"];
        NSData * data = [NSJSONSerialization dataWithJSONObject:datas options:NSJSONWritingPrettyPrinted error:nil];
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"homeVideos"];
        NSMutableArray * muarr = [NSMutableArray new];
        for (int i = 0; i<datas.count; i++) {
            NSDictionary * dic = datas[i];
            HomeVideoFocusModel * model = [[HomeVideoFocusModel alloc]initWithDictionary:dic];
            [muarr addObject:model];
        }
        self.viewModel.videoFocus = [NSArray arrayWithArray:muarr];
        [self.tabview reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationLeft];
    } error:^(BYError *byerror) {
        
    }];
    //首页赛程
    [[NetWorkManger manager] sendRequest:Page_HomeFixture route:Route_Home withParams:@{} complete:^(NSDictionary *result) {
        NSArray * datas = result[@"data"];
        NSData * data = [NSJSONSerialization dataWithJSONObject:datas options:NSJSONWritingPrettyPrinted error:nil];
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"homeFixture"];
        NSMutableArray * muarr = [NSMutableArray new];
        for (int i = 0; i<datas.count; i++) {
            NSDictionary * dic = datas[i];
            FixtureModel * model = [[FixtureModel alloc]initWithDictionary:dic];
            [muarr addObject:model];
        }
        self.viewModel.fixtures = [NSArray arrayWithArray:muarr];
        [self.tabview reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationFade];
    } error:^(BYError *byerror) {
        
    }];
    //首页队员
    [[NetWorkManger manager] sendRequest:Page_HomeTeamer route:Route_Home withParams:@{} complete:^(NSDictionary *result) {
        NSArray * datas = result[@"data"];
        NSData * data = [NSJSONSerialization dataWithJSONObject:datas options:NSJSONWritingPrettyPrinted error:nil];
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"homeTeamers"];
        NSMutableArray * muarr = [NSMutableArray new];
        for (int i = 0; i<datas.count; i++) {
            NSDictionary * dic = datas[i];
            HomeTeamerModel * model = [[HomeTeamerModel alloc]initWithDictionary:dic];
            [muarr addObject:model];
        }
        self.viewModel.teamers = [NSArray arrayWithArray:muarr];
        [self.tabview reloadSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(3, 2)] withRowAnimation:UITableViewRowAnimationMiddle];
    } error:^(BYError *byerror) {
        
    }];
}
#pragma mark 头部bannar点击
- (void)HeadFocusClick:(UITapGestureRecognizer *)tap{
    NSInteger index = self.headScolView.pageControl.currentPage;
    VideoFocusModel * model = self.viewModel.headFocus[index];
    switch ([model.show_type intValue]) {
        case 1://新闻
        {
            [self checkNewsDetailWithNewsid:model.id];
        }
            break;
        case 2://图集
        {
            [self checkPhotoDetailWithid:model.id];
        }
            break;
        case 3://视屏
        {
            [self checkVideoDetailWithLink:model.url title:model.title content:model.content];
        }
            break;
        default:
            
            break;
    }
}
#pragma mark 中间视频bannar点击
- (void)videoFocuClick{
    NSInteger index = self.videoScolView.pageControl.currentPage;
    HomeVideoFocusModel * model = self.viewModel.videoFocus[index];
    [self checkVideoDetailWithLink:model.url title:model.title content:model.content];
}
- (void)checkPicDetailWithPicid:(NSNumber *)picid{
    [self checkPhotoDetailWithid:picid];
}
- (void)checkNewDetailWithNewsid:(NSNumber *)newsid{
    [self checkNewsDetailWithNewsid:newsid];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
#pragma mark 新闻
    if (indexPath.section == 0) {
        NewsListModel * model = self.viewModel.news[indexPath.row];
        [self checkNewsDetailWithNewsid:model.id];
    }else if(indexPath.section == 1){
#pragma mark 广告
        MainWebViewController * webVC = [[MainWebViewController alloc]initWithTitle:@"广告" url:self.viewModel.adModel.url andFromType:FromTypeWeb];
        webVC.isPush = YES;
        [self.navigationController pushViewController:webVC animated:YES];
    }
}
#pragma mark 球员点击
- (void)homeTeamerClickWithTeamerid:(NSNumber *)teamerid isTeamer:(BOOL)rec{
    [self checkTeamerDetailWithTeamerid:teamerid isTeamer:rec];
}
#pragma mark 界面跳转
- (void)checkNewsDetailWithNewsid:(NSNumber *)newsid{
    NewsDetailViewController * vc = [[NewsDetailViewController alloc]initWithNewsid:newsid];
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (void)checkPhotoDetailWithid:(NSNumber *)photoid{
    PhotoDetailViewController * vc = [[PhotoDetailViewController alloc]initWithPhotoDetailid:photoid];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)checkVideoDetailWithLink:(NSString *)link title:(NSString *)title content:(NSString *)content{
    MainWebViewController * webVC = [[MainWebViewController alloc]initWithTitle:@"视屏" url:link andFromType:FromTypeVideo];
    [webVC updateShareSettingWithTitle:title content:content image:@""];
    webVC.isPush = YES;
    [self.navigationController pushViewController:webVC animated:YES];
}
- (void)checkTeamerDetailWithTeamerid:(NSNumber *)num isTeamer:(BOOL)rec{
    TeamerDetailViewController * vc = [[TeamerDetailViewController alloc]init];
    vc.isTeamer = rec;
    vc.teamerid = num;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark 查看全部新闻
- (void)checkAllNews{
    NewsListViewController * vc = [[NewsListViewController alloc]init];
    vc.isPush = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
