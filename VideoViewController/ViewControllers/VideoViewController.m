//
//  VideoViewController.m
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/3/20.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "VideoViewController.h"
#import "VideoListTableViewCell.h"
#import "VideoListModel.h"
#import "MainWebViewController.h"
#import "AutoScrollView.h"
#import "VideoFocusModel.h"
@interface VideoViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView * tabview;
@property (nonatomic, strong) NSMutableArray<VideoListModel *> * dataArray;
@property (nonatomic, strong) NSMutableArray<VideoFocusModel *> * bannerFocus;
@property (nonatomic, strong) AutoScrollView * bannerView;
@property (nonatomic, strong) BYError * errInfo;
@property (nonatomic) dispatch_group_t netWorkGroup;
@end

@implementation VideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationTitle:@"视屏"];
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
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushToVideoDetail)];
    [self.bannerView addGestureRecognizer:tap];
    self.tabview.tableHeaderView = self.bannerView;
}
#pragma mark 网络错误恢复操作
- (void)nullViewClick{
    self.errInfo = nil;
    [self creatNetWorkQueue];
}

#pragma mark 数据请求
/**
 两个接口数据 等待两个接口数据都已加载完成后展示
 如果有一个网络请求出错就展示错误界面
 先判断是否出错，再刷新界面
 */
- (void)creatNetWorkQueue{
    [BQActivityView showActiviTy];
    self.netWorkGroup = dispatch_group_create();
    dispatch_group_enter(self.netWorkGroup);
    NSDictionary * params =@{@"limit":@10};
    [[NetWorkManger manager] sendRequest:Page_VideoList route:Route_Video withParams:params complete:^(NSDictionary *result) {
        NSArray * datas = result[@"data"];
        for (int i = 0; i<datas.count; i++) {
            VideoListModel * model = [[VideoListModel alloc]initWithDictionary:datas[i]];
            [self.dataArray addObject:model];
        }
        dispatch_group_leave(self.netWorkGroup);
    } error:^(BYError *byerror) {
        self.errInfo = byerror;
        dispatch_group_leave(self.netWorkGroup);
    }];
    dispatch_group_enter(self.netWorkGroup);
    [[NetWorkManger manager] sendRequest:Page_VideoFocus route:Route_Video withParams:@{} complete:^(NSDictionary *result) {
        NSArray * arr = result[@"data"];
        for (int i = 0; i<arr.count; i++) {
            VideoFocusModel * model = [[VideoFocusModel alloc]initWithDictionary:arr[i]];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return Anno750(180);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellID = @"videoListCell";
    VideoListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[VideoListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    [cell updateWithModel:self.dataArray[indexPath.row]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataArray[indexPath.row].link.length>0) {
        NSString * link = self.dataArray[indexPath.row].link;
        MainWebViewController * webVC = [[MainWebViewController alloc]initWithTitle:@"视屏" url:link
                                         andFromType:FromTypeVideo];
        [webVC updateShareSettingWithTitle:self.dataArray[indexPath.row].title content:self.dataArray[indexPath.row].content image:@""];
        webVC.isPush = YES;
        [self.navigationController pushViewController:webVC animated:YES];
    }else{
        [ToastView presentToastWithin:self.view withIcon:APToastIconNone text:@"链接丢失啦～～～" duration:1.5f];
    }
}
#pragma mark banner 点击
- (void)pushToVideoDetail{
    NSInteger index = self.bannerView.pageControl.currentPage;
    NSString * link = self.bannerFocus[index].url;
    if (link.length>0) {
        MainWebViewController * webVC = [[MainWebViewController alloc]initWithTitle:@"视屏" url:link
                                         andFromType:FromTypeVideo];
        [webVC updateShareSettingWithTitle:self.bannerFocus[index].title content:self.bannerFocus[index].content image:@""];
        webVC.isPush = YES;
        [self.navigationController pushViewController:webVC animated:YES];
    }else{
        [ToastView presentToastWithin:self.view withIcon:APToastIconNone text:@"链接丢失啦～～～" duration:1.5f];
    }
}
#pragma mark 刷新数据
- (void)refreshData{
    [self.dataArray removeAllObjects];
    [self.bannerFocus removeAllObjects];
    [self creatNetWorkQueue];
}

#pragma mark 加载更多，只需要加载视屏列表即可
- (void)loadMoreData{
    NSDictionary * params =@{@"limit":@10,
                             @"last_time":INCASE_EMPTY([self.dataArray lastObject].date , @"")
                             };
    [[NetWorkManger manager] sendRequest:Page_VideoList route:Route_Video withParams:params complete:^(NSDictionary *result) {
        NSArray * datas = result[@"data"];
        if (self.dataArray.count>10 && datas.count<10) {
            [ToastView presentToastWithin:self.view withIcon:APToastIconNone text:@"没有更多了" duration:1.0f];
        }
        for (int i = 0; i<datas.count; i++) {
            VideoListModel * model = [[VideoListModel alloc]initWithDictionary:datas[i]];
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
