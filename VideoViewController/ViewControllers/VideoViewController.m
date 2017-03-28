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
@property (nonatomic, strong) NSMutableArray * pics;
@property (nonatomic, strong) NSMutableArray * titles;
@property (nonatomic, strong) AutoScrollView * bannerView;
@property (nonatomic, strong) BYError * errInfo;
@property (nonatomic) dispatch_group_t netWorkGroup;
@end

@implementation VideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationTitle:@"视屏"];
    [self drawMainTabItem];
    [self creatUI];
    [self RefreshSetting];
    [self creatNullView];
    [self creatNetWorkQueue];
}
- (void)creatUI{
    self.dataArray = [NSMutableArray new];
    self.tabview = [BYFactory creatTabviewWithFrame:CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT - 64) style:UITableViewStylePlain];
    self.tabview.delegate = self;
    self.tabview.dataSource = self;
    [self.view addSubview:self.tabview];
    
    self.refreshHeader = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    self.refreshFooter = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    self.tabview.mj_header = self.refreshHeader;
    self.tabview.mj_footer = self.refreshFooter;
    
    self.bannerView = [[AutoScrollView alloc]initWithFrame:CGRectMake(0, 0, UI_WIDTH, UI_WIDTH * 540 /960)];
    self.tabview.tableHeaderView = self.bannerView;
}
- (void)nullViewClick{
    [self creatNetWorkQueue];
}

- (void)creatNetWorkQueue{
    self.netWorkGroup = dispatch_group_create();
    dispatch_group_enter(self.netWorkGroup);
    NSDictionary * params =@{@"limit":@10,
                             @"last_time":INCASE_EMPTY([self.dataArray lastObject].date , @"")
                             };
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
        self.titles = [NSMutableArray new];
        self.pics = [NSMutableArray new];
        for (int i = 0; i<arr.count; i++) {
            VideoFocusModel * model = [[VideoFocusModel alloc]initWithDictionary:arr[i]];
            [self.titles addObject:model.title];
            [self.pics addObject:[NSString stringWithFormat:@"%@/%@",Base_ImgHost,model.pic]];
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
        }else{
            self.nullview.hidden = YES;
        }
        [self.refreshHeader endRefreshing];
        [self.refreshFooter endRefreshing];
        if (self.dataArray.count > 0) {
            [self.tabview reloadData];
        }
        if (self.pics.count>0) {
            [self.bannerView updateWithImages:self.pics descs:self.titles];
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
        MainWebViewController * webVC = [[MainWebViewController alloc]initWithTitle:@"视屏" url:link];
        [self.navigationController pushViewController:webVC animated:YES];
    }else{
        [ToastView presentToastWithin:self.view withIcon:APToastIconNone text:@"链接丢失啦～～～" duration:1.5f];
    }
    
}
- (void)refreshData{
    [self.dataArray removeAllObjects];
    [self creatNetWorkQueue];
}
- (void)loadMoreData{
    [self creatNetWorkQueue];
}
@end
