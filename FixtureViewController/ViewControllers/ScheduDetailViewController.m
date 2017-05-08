//
//  ScheduDetailViewController.m
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/4/14.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "ScheduDetailViewController.h"
#import "FixtureTableViewCell.h"
#import "PhotoDetailViewController.h"
#import "NewsDetailViewController.h"
#import "FixtureModel.h"
@interface ScheduDetailViewController ()<UITableViewDelegate, UITableViewDataSource,FixtureCellDelegate>
@property (nonatomic, strong) NSMutableArray<FixtureModel *> * dataArray;
@property (nonatomic, strong) UITableView * tabview;
@end

@implementation ScheduDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatUI];
    [self getdata];
    [self creatNullView];
}
- (void)creatUI{
    self.dataArray = [NSMutableArray new];
    self.tabview = [BYFactory creatTabviewWithFrame:CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT - 64 - Anno750(80) ) style:UITableViewStylePlain];
    self.tabview.delegate = self;
    self.tabview.dataSource = self;
    [self.view addSubview:self.tabview];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return Anno750(400);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellid = @"FixtureTableViewCell";
    FixtureTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if(cell == nil){
        cell = [[FixtureTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    [cell cellUpdateWithModel:self.dataArray[indexPath.row]];
    cell.delegtae = self;
    return cell;
}
- (void)getdata{
    [SVProgressHUD show];
    NSString * leadgue_id = @"5";
    switch (self.scheduType) {
        case ScheduTypeBundesliga:
            break;
        case ScheduTypeChampions:
        {
            leadgue_id = @"9";
        }
            break;
        case ScheduTypeGermany:
        {
            leadgue_id = @"113";
        }
            break;
        case ScheduTypeEles:
        {
            leadgue_id = @"0";
        }
            break;
        default:
            break;
    }
    NSDictionary *parame=@{
                           @"league_id" : leadgue_id,
                           @"limit"     : @"0"
                           };
    [[NetWorkManger manager] sendRequest:Page_Schedules route:Route_Fixture withParams:parame complete:^(NSDictionary *result) {
        [self nullViewHidden];
        NSArray * dataArray = result[@"data"];
        for (int i = 0; i<dataArray.count; i++) {
            NSDictionary * dic = dataArray[i];
            FixtureModel * model = [[FixtureModel alloc]initWithDictionary:dic];
            [self.dataArray addObject:model];
        }
        [self.tabview reloadData];
    } error:^(BYError *byerror) {
        [self nullviewShow];
        [ToastView presentToastWithin:self.view withIcon:APToastIconNone text:@"请求超时，请重试" duration:1.0f];
    }];
}
- (void)nullViewClick{
    [self getdata];
}
- (void)checkPicsDetail:(NSNumber *)picid{
    PhotoDetailViewController * vc = [[PhotoDetailViewController alloc]initWithPhotoDetailid:picid];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)checkNewsDetail:(NSNumber *)newsid{
    NewsDetailViewController * vc = [[NewsDetailViewController alloc]initWithNewsid:newsid];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
