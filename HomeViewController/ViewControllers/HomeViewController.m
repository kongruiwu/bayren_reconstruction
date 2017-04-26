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
#import "HomeScroeHeadView.h"
#import "HomeViewModel.h"
#import "NewsListModel.h"

@interface HomeViewController ()<UITableViewDelegate, UITableViewDataSource,HomeScoreHeadViewDelegate>

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
    [self drawMainTabItem];
    [self creatUI];
    [self creatNetWorkQueue];
}
- (void)creatUI{
    self.viewModel = [[HomeViewModel alloc]init];
    
    self.tabview = [BYFactory creatTabviewWithFrame:CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT) style:UITableViewStyleGrouped];
    self.tabview.delegate = self;
    self.tabview.dataSource = self;
    [self.view addSubview:self.tabview];
    
    [self creatHeadView];
}
- (void)creatHeadView{
    self.headScolView = [[AutoScrollView alloc]initWithFrame:CGRectMake(0, 0, UI_WIDTH, Anno750(330))];
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
            return Anno750(20);
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
    }else if(section == 2){
        return Anno750(340);
    }
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 2) {
        return Anno750(380);
    }
    return Anno750(20);
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 2) {
        UIView * header = [BYFactory creatViewWithColor:[UIColor clearColor]];
        header.frame = CGRectMake(0, 0, UI_WIDTH, Anno750(380));
        self.videoScolView = [[AutoScrollView alloc]initWithFrame:CGRectMake(Anno750(24), 0, Anno750(702), Anno750(380))];
        if (self.viewModel.videoFocus.count>0) {
            [self.videoScolView updateWithImages:self.viewModel.VideoFocusImages descs:self.viewModel.VideoFocusTitles];
        }
        [header addSubview:self.videoScolView];
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
    }else if(section == 3){
        HomeScroeHeadView * headView = [[HomeScroeHeadView alloc]initWithFrame:CGRectMake(0, 0, UI_WIDTH, Anno750(340))];
        if (self.viewModel.fixtures.count>0) {
            [headView updateScrollViewWithArray:self.viewModel.fixtures andIndex:self.viewModel.index];
        }
        headView.delegate = self;
        return headView;
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
            static NSString * cellid = @"blankCell";
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
            if (!cell) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
            }
            cell.hidden = YES;
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
        if (datas.count>0) {
            self.viewModel.adModel = [[HomeAdModel alloc]initWithDictionary:datas[0]];
            [self.tabview reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationMiddle];
        }
    } error:^(BYError *byerror) {
        
    }];
    //首页视频
    [[NetWorkManger manager] sendRequest:Page_HomeVideo route:Route_Home withParams:@{} complete:^(NSDictionary *result) {
        NSArray * datas = result[@"data"];
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


#pragma mark 查看全部新闻
- (void)checkAllNews{

}

@end
