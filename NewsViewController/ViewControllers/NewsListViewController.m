//
//  NewsListViewController.m
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/3/22.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "NewsListViewController.h"
#import "NewsDetailViewController.h"
#import "AutoScrollView.h"
#import "NewsListModel.h"
#import "NewsFoucesModel.h"
#import "NewsListTableViewCell.h"
@interface NewsListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong) UITableView * tabview;
@property (nonatomic, strong) NSMutableArray<NewsListModel *> * dataArray;
@property (nonatomic, strong) NSMutableArray<NewsFoucesModel *> * bannerFocus;
@property (nonatomic, strong) AutoScrollView * bannerView;
@property (nonatomic, strong) BYError * errInfo;
@property (nonatomic) dispatch_group_t netWorkGroup;
@end

@implementation NewsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationTitle:@"新闻"];
    [self drawMainSearchTabItem];
    [self creatUI];
    [self RefreshSetting];
    [self creatNullView];
    [self creatNetWorkQueue];
}
- (void)creatUI{
    self.dataArray = [NSMutableArray new];
    self.bannerFocus = [NSMutableArray new];
    
    self.tabview = [BYFactory creatTabviewWithFrame:CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT - 64) style:UITableViewStylePlain];
    self.tabview.delegate = self;
    self.tabview.dataSource = self;
    [self.view addSubview:self.tabview];
    
    self.refreshHeader = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    self.refreshFooter = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    self.tabview.mj_header = self.refreshHeader;
    self.tabview.mj_footer = self.refreshFooter;
    
    self.bannerView = [[AutoScrollView alloc]initWithFrame:CGRectMake(0, 0, UI_WIDTH, UI_WIDTH * 540 /960)];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushToNewsDetail)];
    [self.bannerView addGestureRecognizer:tap];
    self.tabview.tableHeaderView = self.bannerView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return Anno750(180);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellid = @"listCell";
    NewsListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[NewsListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    [cell updateWithModel:self.dataArray[indexPath.row]];
    return cell;
}
- (void)creatNetWorkQueue{
    [BQActivityView showActiviTy];
    self.netWorkGroup = dispatch_group_create();
    dispatch_group_enter(self.netWorkGroup);
    NSDictionary * params =@{@"limit":@10};
    [[NetWorkManger manager] sendRequest:Page_NewsList route:Route_News withParams:params complete:^(NSDictionary *result) {
        NSArray * datas = result[@"data"];
        for (int i = 0; i<datas.count; i++) {
            NewsListModel * model = [[NewsListModel alloc]initWithDictionary:datas[i]];
            [self.dataArray addObject:model];
        }
        dispatch_group_leave(self.netWorkGroup);
    } error:^(BYError *byerror) {
        self.errInfo = byerror;
        dispatch_group_leave(self.netWorkGroup);
    }];
    dispatch_group_enter(self.netWorkGroup);
    [[NetWorkManger manager] sendRequest:Page_NewsFocus route:Route_News withParams:@{} complete:^(NSDictionary *result) {
        NSArray * arr = result[@"data"];
        for (int i = 0; i<arr.count; i++) {
            NewsFoucesModel * model = [[NewsFoucesModel alloc]initWithDictionary:arr[i]];
            [self.bannerFocus addObject:model];
        }
        dispatch_group_leave(self.netWorkGroup);
    } error:^(BYError *byerror) {
        self.errInfo = byerror;
        dispatch_group_leave(self.netWorkGroup);
    }];
    dispatch_group_notify(self.netWorkGroup, dispatch_get_main_queue(), ^{
        if (self.errInfo) {
            self.nullview.hidden = NO;
            [self.view bringSubviewToFront:self.nullview];
            [ToastView presentToastWithin:self.view withIcon:APToastIconNone text:self.errInfo.errorMessage duration:1.0f];
        }else{
            self.nullview.hidden = YES;
        }
        [BQActivityView hideActiviTy];
        [self.refreshHeader endRefreshing];
        [self.refreshFooter endRefreshing];
        [self.tabview reloadData];
        if (self.bannerFocus.count>0) {
            NSMutableArray * titles = [NSMutableArray new];
            NSMutableArray * pics = [NSMutableArray new];
            for (int i = 0; i<self.bannerFocus.count; i++) {
                [titles addObject:self.bannerFocus[i].title];
                [pics addObject:[NSString stringWithFormat:@"%@/%@",Base_ImgHost,self.bannerFocus[i].pic]];
            }
            [self.bannerView updateWithImages:pics descs:titles];
        }
    });
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsDetailViewController * vc = [[NewsDetailViewController alloc]initWithNewsid:self.dataArray[indexPath.row].id];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)pushToNewsDetail{
    NSInteger index = self.bannerView.pageControl.currentPage;
    NewsDetailViewController * vc = [[NewsDetailViewController alloc]initWithNewsid:self.bannerFocus[index].id];
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (void)nullViewClick{
    self.errInfo = nil;
    [self creatNetWorkQueue];
}
- (void)refreshData{
    [self.dataArray removeAllObjects];
    [self.bannerFocus removeAllObjects];
    [self creatNetWorkQueue];
}
- (void)loadMoreData{
    NSDictionary * params =@{@"limit":@10,
                             @"last_time":INCASE_EMPTY([self.dataArray lastObject].date , @"")
                             };
    [[NetWorkManger manager] sendRequest:Page_NewsList route:Route_News withParams:params complete:^(NSDictionary *result) {
        NSArray * datas = result[@"data"];
        if (self.dataArray.count>10 && datas.count<10) {
            [ToastView presentToastWithin:self.view withIcon:APToastIconNone text:@"没有更多了" duration:1.0f];
        }
        for (int i = 0; i<datas.count; i++) {
            NewsListModel * model = [[NewsListModel alloc]initWithDictionary:datas[i]];
            [self.dataArray addObject:model];
        }
        [self.tabview reloadData];
        [self.refreshFooter endRefreshing];
    } error:^(BYError *byerror) {
        [self.refreshFooter endRefreshing];
        [ToastView presentToastWithin:self.view withIcon:APToastIconNone text:byerror.errorMessage duration:1.5f];
    }];
}
@end
