//
//  TagNewsListViewController.m
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/5/3.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "TagNewsListViewController.h"
#import "NewsListModel.h"
#import "NewsListTableViewCell.h"
#import "NewsDetailViewController.h"
@interface TagNewsListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView * tabview;
@property (nonatomic, strong) NSMutableArray<NewsListModel *> * dataArray;
@end

@implementation TagNewsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self drawBackButton];
    [self setNavigationTitle:@"新闻"];
    [self creatUI];
    [self refreshData];
}
- (void)creatUI{
    self.dataArray = [NSMutableArray new];
    self.tabview = [BYFactory creatTabviewWithFrame:CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT - Anno750(64)) style:UITableViewStylePlain];
    self.tabview.delegate =self;
    self.tabview.dataSource = self;
    [self.view addSubview:self.tabview];
    self.refreshHeader = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    self.refreshFooter = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    self.tabview.mj_header = self.refreshHeader;
    self.tabview.mj_footer = self.refreshFooter;
    [self RefreshSetting];
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsDetailViewController * vc = [[NewsDetailViewController alloc]initWithNewsid:self.dataArray[indexPath.row].id];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)nullViewClick{
    [self refreshData];
}
- (void)refreshData{
    [self.dataArray removeAllObjects];
    [self loadMoreData];
}
- (void)loadMoreData{
    NSDictionary * params =@{@"tag_id":self.tagid,
                             @"limit":@10,
                             @"last_time":INCASE_EMPTY([self.dataArray lastObject].date , @"")
                             };
    [[NetWorkManger manager] sendRequest:Page_TagList route:Route_News withParams:params complete:^(NSDictionary *result) {
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
