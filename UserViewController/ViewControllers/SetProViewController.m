//
//  SetProViewController.m
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/4/27.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "SetProViewController.h"
#import "SetCityViewController.h"
@interface SetProViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView * tabview;
@property (nonatomic, strong) NSArray * dataArray;

@end

@implementation SetProViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setNavUnAlpha];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self setNavAlpha];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self drawBackButton];
    [self setNavigationTitle:@"选择地址"];
    [self creatUI];
}
- (void)creatUI{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"area" ofType:@"plist"];
    self.dataArray = [NSArray arrayWithContentsOfFile:path];
    self.tabview = [BYFactory creatTabviewWithFrame:CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT - 64) style:UITableViewStylePlain];
    self.tabview.delegate = self;
    self.tabview.dataSource = self;
    [self.view addSubview:self.tabview];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return Anno750(88);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellID =@"cellID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = [UIFont systemFontOfSize:Anno750(28)];
        cell.textLabel.textColor = BYColor_Title;
        UIView * lineview = [BYFactory creatLineView];
        [cell addSubview:lineview];
        [lineview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(@0);
            make.height.equalTo(@0.5);
        }];
    }
    NSDictionary * dic = self.dataArray[indexPath.row];
    cell.textLabel.text = dic[@"state"];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SetCityViewController * vc = [[SetCityViewController alloc]init];
    NSDictionary * dic = self.dataArray[indexPath.row];
    vc.dataArray = dic[@"cities"];
    vc.addressPre = dic[@"state"];
    [self.navigationController pushViewController:vc animated:YES];
}



@end
