//
//  ScoresViewController.m
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/4/17.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "ScoresViewController.h"
#import "StandingTableViewCell.h"
#import "StandingModel.h"
@interface ScoresViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView * tabview;
@property (nonatomic, strong) NSMutableArray * dataArray;
@end

@implementation ScoresViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatUI];
    [self creatNullView];
    [self loadData];
}

- (void)creatUI{
    self.view.backgroundColor = [UIColor whiteColor];
    self.dataArray = [NSMutableArray new];
    [self creatHeadView];
    self.tabview = [BYFactory creatTabviewWithFrame:CGRectMake(0, Anno750(80), UI_WIDTH, UI_HEGIHT - 64 - Anno750(160)) style:UITableViewStylePlain];
    self.tabview.delegate = self;
    self.tabview.dataSource = self;
    [self.view addSubview:self.tabview];
}
- (void)creatHeadView{
    UILabel * titlelabel = [BYFactory creatLabelWithText:@"俱乐部"
                                               fontValue:font750(30)
                                               textColor:BYColor_gray_3
                                           textAlignment:NSTextAlignmentCenter];
    UILabel * winLabel = [BYFactory creatLabelWithText:@"胜"
                                             fontValue:font750(30)
                                             textColor:BYColor_gray_3
                                         textAlignment:NSTextAlignmentCenter];
    UILabel * drawLabel = [BYFactory creatLabelWithText:@"平"
                                              fontValue:font750(30)
                                              textColor:BYColor_gray_3
                                          textAlignment:NSTextAlignmentCenter];
    UILabel * lostLabel = [BYFactory creatLabelWithText:@"负"
                                              fontValue:font750(30)
                                              textColor:BYColor_gray_3
                                          textAlignment:NSTextAlignmentCenter];
    UILabel * ballLabel = [BYFactory creatLabelWithText:@"进/失球"
                                              fontValue:font750(30)
                                              textColor:BYColor_gray_3
                                          textAlignment:NSTextAlignmentCenter];
    UILabel * scoreLabel = [BYFactory creatLabelWithText:@"积分"
                                               fontValue:font750(30)
                                               textColor:BYColor_gray_3
                                           textAlignment:NSTextAlignmentCenter];
    UIView * line = [BYFactory creatLineView];
    [self.view addSubview:titlelabel];
    [self.view addSubview:winLabel];
    [self.view addSubview:drawLabel];
    [self.view addSubview:lostLabel];
    [self.view addSubview:ballLabel];
    [self.view addSubview:scoreLabel];
    [self.view addSubview:line];
    [titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@0);
        make.height.equalTo(@(Anno750(80)));
        make.width.equalTo(@(Anno750(250)));
    }];
    [winLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titlelabel.mas_right);
        make.centerY.equalTo(titlelabel.mas_centerY);
        make.width.equalTo(@(Anno750(250/3)));
        make.height.equalTo(@(Anno750(80)));
    }];
    [drawLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(winLabel.mas_right);
        make.centerY.equalTo(titlelabel.mas_centerY);
        make.width.equalTo(@(Anno750(250/3)));
        make.height.equalTo(@(Anno750(80)));
    }];
    [lostLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(drawLabel.mas_right);
        make.centerY.equalTo(titlelabel.mas_centerY);
        make.width.equalTo(@(Anno750(250/3)));
        make.height.equalTo(@(Anno750(80)));
    }];
    [ballLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lostLabel.mas_right);
        make.centerY.equalTo(titlelabel.mas_centerY);
        make.width.equalTo(@(Anno750(125)));
        make.height.equalTo(@(Anno750(80)));
    }];
    [scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ballLabel.mas_right);
        make.centerY.equalTo(titlelabel.mas_centerY);
        make.width.equalTo(@(Anno750(125)));
        make.height.equalTo(@(Anno750(80)));
    }];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.top.equalTo(titlelabel.mas_bottom).offset(-0.5);
        make.height.equalTo(@0.5);
    }];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return Anno750(100);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellid = @"StandingTableViewCell";
    StandingTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if(cell == nil){
        cell = [[StandingTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    StandingModel * model = self.dataArray[indexPath.row];
    [cell updateWithModel:model];
    return cell;
}
- (void)loadData{
    [self.dataArray removeAllObjects];
    [[NetWorkManger manager] sendRequest:Page_Rank route:Route_Fixture withParams:@{} complete:^(NSDictionary *result) {
        [self nullViewHidden];
        NSDictionary * dic = result[@"data"];
        NSDictionary * data = dic[@"rank"];
        NSString * key = @"5";
        if (self.isSecond) {
            key = @"9";
        }
        NSArray * arr = data[key];
        for (int i = 0; i<arr.count; i++) {
            NSDictionary * dic = arr[i];
            StandingModel * model = [[StandingModel alloc]initWithDictionary:dic];
            if ([model.known_name_zh isEqualToString:@"拜仁"]) {
                model.isBer = YES;
            }
            [self.dataArray addObject:model];
        }
        [self.tabview reloadData];
    } error:^(BYError *byerror) {
        [self nullviewShow];
        [ToastView presentToastWithin:self.view withIcon:APToastIconNone text:@"请求失败请重试。。" duration:1.0f];
    }];
}


@end
