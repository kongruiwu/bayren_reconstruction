//
//  TestViewController.m
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/3/31.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "TestViewController.h"
#import <ReactiveObjC.h>
#import "CaculatorMaker.h"
@interface TestViewController ()

@property (nonatomic, strong) NSString * value;
@property (nonatomic, strong) UITextField * nameTf;
@property (nonatomic, strong) UIButton * loginBtn;

@property (nonatomic, strong) NSString * valueA;
@property (nonatomic, strong) NSString * valueB;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //简单的打印数据 数据改变则改变
    [RACObserve(self, value) subscribeNext:^(NSString * value) {
        NSLog(@"%@",value);
    }];
    //映射
    RACSignal * signalA = [RACSignal createSignal:^RACDisposable * (id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@"123"];
        return nil;
    }];
    RAC(self,value) = [signalA map:^id (NSString * str) {
        //处理信号a的信息 将信号a的信息转换为另外一个值
        if ([str isEqualToString:@"123"]) {
            return @"456";
        }
        return @"";
    }];
    RAC(self.loginBtn,enabled) = [RACObserve(self.nameTf, text) map:^id (NSString * str) {
        if (str.length >10) {
            return @1;
        }else{
            return @0;
        }
    }];
    
    
    RACChannelTerminal * channelA = RACChannelTo(self,valueA);
    RACChannelTerminal * channelB = RACChannelTo(self,valueB);
    [[channelA map:^id _Nullable(NSString * value) {
        if ([value isEqualToString:@"valueA"]) {
            return @"valueC";
        };
        return value;
    }] subscribe:channelB];
    
    [[channelB map:^id _Nullable(NSString * value) {
        if ([value isEqualToString:@"valueB"]) {
            return @"valueD";
        }
        return value;
    }] subscribe:channelA];;
    
    
}

@end
