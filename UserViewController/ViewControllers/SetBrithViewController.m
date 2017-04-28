//
//  SetBrithViewController.m
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/4/27.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "SetBrithViewController.h"
#import "UserManager.h"
@interface SetBrithViewController ()
@property (nonatomic ,strong) UIDatePicker * datePicker;
@property (nonatomic, strong) UILabel * dateLabel;
@property (nonatomic, strong) NSString * date;
@end

@implementation SetBrithViewController
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
    [self setNavigationTitle:@"设置生日"];
    [self creatUI];
}
- (void)creatUI{
    UIDatePicker * datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 0, UI_WIDTH, Anno750(432))];
    [self.view addSubview:datePicker];
    datePicker.datePickerMode = UIDatePickerModeDate;
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];//设置为中
    datePicker.locale = locale;
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *currentDate = [NSDate date];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setYear:0];//设置最大时间为：当前时间推后十年
    NSDate *maxDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
    [comps setYear:-100];//设置最小时间为：当前时间前推十年
    NSDate *minDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
    
    [datePicker setMaximumDate:maxDate];
    [datePicker setMinimumDate:minDate];
    [datePicker addTarget:self action:@selector(dateChanged) forControlEvents:UIControlEventValueChanged ];
    self.datePicker = datePicker;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString * dateString = [NSString stringWithFormat:@"修改生日为：%@",[dateFormatter stringFromDate:[NSDate date]]];
    self.date = [dateFormatter stringFromDate:[NSDate date]];
    self.dateLabel = [BYFactory creatLabelWithText:dateString fontValue:font750(30) textColor:BYColor_Tag textAlignment:NSTextAlignmentCenter];
    [self.view addSubview:self.dateLabel];
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(datePicker.mas_bottom).offset(Anno750(30));
        make.height.equalTo(@20);
    }];
    UIButton * sureButton = [BYFactory creatButtonWithTitle:@"确定"
                                            backGroundColor:BYColor_Main
                                                  textColor:[UIColor whiteColor] textSize:font750(36)];
    [self.view addSubview:sureButton];
    [sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(30)));
        make.right.equalTo(@(-Anno750(30)));
        make.height.equalTo(@(Anno750(100)));
        make.top.equalTo(self.dateLabel.mas_bottom).offset(Anno750(30));
    }];
    [sureButton addTarget:self action:@selector(changeUserInfoWithBirth) forControlEvents:UIControlEventTouchUpInside];
    sureButton.layer.cornerRadius = Anno750(10);
}
- (void)dateChanged{
    NSDate* date = self.datePicker.date;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString * dateString = [dateFormatter stringFromDate:date];
    self.dateLabel.text = [NSString stringWithFormat:@"修改生日为：%@",dateString];
    self.date = dateString;
}
- (void)changeUserInfoWithBirth{

    NSDictionary * params = @{@"uid":[UserManager manager].userid,
                              @"callback_verify":[UserManager manager].token,
                              @"field_name":@"birth",
                              @"field_value":self.date};
    [[NetWorkManger manager] sendRequest:Page_ChangeUserInfo route:Route_User withParams:params complete:^(NSDictionary *result) {
        [UserManager manager].user.birth = self.date;
        [ToastView presentToastWithin:self.view.window withIcon:APToastIconNone text:@"修改成功" duration:1.0f];
        [self.navigationController popToRootViewControllerAnimated:YES];
    } error:^(BYError *byerror) {
        [ToastView presentToastWithin:self.view withIcon:APToastIconNone text:byerror.errorMessage duration:1.0f];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
