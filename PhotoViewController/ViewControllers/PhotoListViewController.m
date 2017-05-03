//
//  PhotoListViewController.m
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/4/24.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "PhotoListViewController.h"
#import "PhotoListTableViewCell.h"
#import "PhotoListModel.h"
#import "PhotoDetailViewController.h"

@interface PhotoListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView * tabview;
@property (nonatomic, strong) NSMutableArray<PhotoListModel *> * dataArray;

@end

@implementation PhotoListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationTitle:@"图片"];
    [self drawMainSearchTabItem];
    [self creatUI];
    [self RefreshSetting];
    [self creatNullView];
    [self getData];
}
- (void)creatUI{
    self.dataArray = [NSMutableArray new];
    
    self.tabview = [BYFactory creatTabviewWithFrame:CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT - 64) style:UITableViewStyleGrouped];
    self.tabview.delegate = self;
    self.tabview.dataSource = self;
    [self.view addSubview:self.tabview];
    
    self.refreshHeader = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    self.refreshFooter = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    self.tabview.mj_header = self.refreshHeader;
    self.tabview.mj_footer = self.refreshFooter;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return Anno750(420);
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == self.dataArray.count - 1) {
        return 0.01;
    }
    return Anno750(16);
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellid = @"listCell";
    PhotoListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[PhotoListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    [cell updateWithModel:self.dataArray[indexPath.section]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.navigationController pushViewController:[PhotoDetailViewController new] animated:YES];
}
- (void)nullViewClick{
    [self refreshData];
}
- (void)refreshData{
    [self.dataArray removeAllObjects];
    [self getData];
}
- (void)loadMoreData{
    [self getData];
}
- (void)getData{

    NSDictionary * params = @{
                              @"last_time":INCASE_EMPTY([self.dataArray lastObject].date , @""),
                              @"limit":@10
                              };
    [[NetWorkManger manager] sendRequest:Page_PhotoList route:Route_Photo withParams:params complete:^(NSDictionary *result) {
        [self nullViewHidden];
        NSArray * arr = result[@"data"];
        if (arr.count<10 && self.dataArray.count>=10) {
            [ToastView presentToastWithin:self.view withIcon:APToastIconNone text:@"没有更多了" duration:1.0f];
        }
        for (int i = 0; i<arr.count; i++) {
            NSDictionary * dic = arr[i];
            PhotoListModel * model = [[PhotoListModel alloc]initWithDictionary:dic];
            [self.dataArray addObject:model];
        }
        [self.tabview reloadData];
        [self.refreshHeader endRefreshing];
        [self.refreshFooter endRefreshing];
    } error:^(BYError *byerror) {
        [self.refreshHeader endRefreshing];
        [self.refreshFooter endRefreshing];
        [self nullviewShow];
        [ToastView presentToastWithin:self.view withIcon:APToastIconNone text:@"请求超时...请重试...." duration:1.0f];
    }];
}
@end
