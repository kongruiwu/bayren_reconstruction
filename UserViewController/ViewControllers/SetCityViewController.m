//
//  SetCityViewController.m
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/4/27.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "SetCityViewController.h"
#import "UserManager.h"
@interface SetCityViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView * tabview;
@end

@implementation SetCityViewController

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
    
    self.tabview = [BYFactory creatTabviewWithFrame:CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT - 64) style:UITableViewStylePlain];
    self.tabview.delegate = self;
    self.tabview.dataSource = self;
    [self.view addSubview:self.tabview];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return Anno750(90);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellID =@"cellID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UIView * lineview = [BYFactory creatLineView];
        [cell addSubview:lineview];
        cell.textLabel.font = [UIFont systemFontOfSize:Anno750(28)];
        cell.textLabel.textColor = BYColor_Title;
        [lineview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(@0);
            make.height.equalTo(@0.5);
        }];
    }
    NSDictionary * dic = self.dataArray[indexPath.row];
    cell.textLabel.text = dic[@"city"];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary * dic = self.dataArray[indexPath.row];
    NSString * address = [NSString stringWithFormat:@"%@-%@",self.addressPre,dic[@"city"]];
    [self changeUserInfoWithAddress:address];
}
- (void)changeUserInfoWithAddress:(NSString *)address{
    NSDictionary * params = @{@"uid":[UserManager manager].userid,
                              @"callback_verify":[UserManager manager].token,
                              @"field_name":@"area",
                              @"field_value":address};
    [[NetWorkManger manager] sendRequest:Page_ChangeUserInfo route:Route_User withParams:params complete:^(NSDictionary *result) {
        [UserManager manager].user.area = address;
        [ToastView presentToastWithin:self.view.window withIcon:APToastIconNone text:@"修改成功" duration:1.0f];
        [self.navigationController popToRootViewControllerAnimated:YES];
    } error:^(BYError *byerror) {
        [ToastView presentToastWithin:self.view withIcon:APToastIconNone text:byerror.errorMessage duration:1.0f];
    }];
    
}

@end
