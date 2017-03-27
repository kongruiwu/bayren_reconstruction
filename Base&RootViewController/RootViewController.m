//
//  RootViewController.m
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/3/20.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "RootViewController.h"
#import "ConfigHeader.h"
#import "VideoViewController.h"
@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton * button = [BYFactory creatButtonWithTitle:@"video" backGroundColor:[UIColor grayColor] textColor:[UIColor whiteColor] textSize:Anno750(30)];
    button.frame = CGRectMake(100, 200, 200, 50);
    [self.view addSubview:button];
    
    [button addTarget:self action:@selector(pushToView) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Left"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(presentLeftMenuViewController)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Right"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(presentRightMenuViewController)];
    
}
- (void)presentLeftMenuViewController{
    [self.sideMenuViewController presentLeftMenuViewController];
}
- (void)presentRightMenuViewController{
    [self.sideMenuViewController presentRightMenuViewController];
}
- (void)pushToView{
    [self.navigationController pushViewController:[VideoViewController new] animated:YES];
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
