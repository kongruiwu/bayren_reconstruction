//
//  TeamerListViewController.m
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/4/20.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "TeamerListViewController.h"
#import "TeamListTableViewCell.h"
#import "TeamerDetailViewController.h"

@interface TeamerListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView * tabview;
@property (nonatomic, strong) NSMutableArray * dataArray;
@end

@implementation TeamerListViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatUI];
    [self getData];
}
- (void)creatUI{
    self.dataArray = [NSMutableArray new];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tabview = [BYFactory creatTabviewWithFrame:CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT - Anno750(80) - 64) style:UITableViewStylePlain];
    self.tabview.delegate = self;
    self.tabview.dataSource = self;
    [self.view addSubview:self.tabview];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return Anno750(350);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellID = @"TeamerListCell";
    TeamListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[TeamListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    ListTeamerModel * model = self.dataArray[indexPath.row];
    [cell updateWithModel:model];
    if (indexPath.row == self.dataArray.count - 1) {
        cell.lineView.hidden = YES;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TeamerDetailViewController *vc=[[TeamerDetailViewController alloc]init];
    BOOL rec = YES;
    ListTeamerModel * model = self.dataArray[indexPath.row];
    NSString * string = [NSString stringWithFormat:@"%@",model.No];
    if (string.length == 0) {
        rec = NO;
    }
    vc.isTeamer=rec;
    vc.teamerid =model.id;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)getData{
    [SVProgressHUD show];
    NSString * key;
    if ([self.teamerTitle isEqualToString:@"门将"]) {
        key = @"1";
    }else if ([self.teamerTitle isEqualToString:@"后卫"]){
        key = @"2";
    }else if ([self.teamerTitle isEqualToString:@"中场"]){
        key = @"3";
    }else if ([self.teamerTitle isEqualToString:@"前锋"]){
        key = @"4";
    }else if ([self.teamerTitle isEqualToString:@"教练"]){
        key = @"5";
    }
    NSDictionary * params = @{
                              @"data_key":key
                              };
    [[NetWorkManger manager] sendRequest:Page_TeamList route:Route_Team withParams:params complete:^(NSDictionary *result) {
        [self nullViewHidden];
        NSDictionary * dic = result[@"data"];
        NSArray * datas = dic[key];
        for (int j= 0; j<datas.count; j++) {
            ListTeamerModel * model = [[ListTeamerModel alloc]initWithDictionary:datas[j]];
            model.cate = self.teamerTitle;
            [self.dataArray addObject:model];
        }
        [self.tabview reloadData];
    } error:^(BYError *byerror) {
        [ToastView presentToastWithin:self.view withIcon:APToastIconNone text:@"请求超时，请重试" duration:1.0f];
        [self nullviewShow];
    }];
}
@end
