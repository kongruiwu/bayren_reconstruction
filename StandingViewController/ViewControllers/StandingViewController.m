//
//  StandingViewController.m
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/4/17.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "StandingViewController.h"
#import "ScoresViewController.h"
#import <HMSegmentedControl.h>
@interface StandingViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) HMSegmentedControl * segmentControl;
@property (nonatomic, strong) NSArray * titles;
@property (nonatomic, strong) UIScrollView * mainScroll;
@property (nonatomic, strong) NSMutableArray * viewControllers;

@end

@implementation StandingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationTitle:@"积分"];
    [self drawMainTabItem];
    [self creatUI];
    [self creatNullView];
}
- (void)creatUI{
    self.titles = @[@"德甲",@"欧冠"];
    self.segmentControl = [[HMSegmentedControl alloc]initWithSectionTitles:self.titles];
    self.segmentControl.frame = CGRectMake(0, 0, UI_WIDTH, Anno750(80));
    //设置字体
    self.segmentControl.titleTextAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:font750(30)],
                                                NSForegroundColorAttributeName : BYColor_Tag};
    self.segmentControl.selectedTitleTextAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:font750(30)],
                                                        NSForegroundColorAttributeName : BYColor_Main};
    
    //设置移动线条属性
    self.segmentControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    self.segmentControl.selectionIndicatorHeight = Anno750(6);
    self.segmentControl.selectionIndicatorColor = BYColor_Main;
    self.segmentControl.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
    [self.view addSubview:self.segmentControl];
    
    UIView * lineView = [BYFactory creatViewWithColor:BYColor_Line];
    [self.segmentControl addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.height.equalTo(@0.5);
    }];
    
    self.mainScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0,Anno750(80), UI_WIDTH,  UI_HEGIHT - Anno750(80))];
    self.mainScroll.contentSize = CGSizeMake(self.titles.count * UI_WIDTH, 0);
    [self.mainScroll autoresizingMask];
    self.mainScroll.pagingEnabled = YES;
    self.mainScroll.showsVerticalScrollIndicator = NO;
    self.mainScroll.showsHorizontalScrollIndicator = NO;
    self.mainScroll.backgroundColor = [UIColor whiteColor];
    self.mainScroll.delegate = self;
    [self.view addSubview:self.mainScroll];
    self.viewControllers = [NSMutableArray new];
    for (int i = 0 ; i<self.titles.count; i++) {
        if (i == 0) {
            ScoresViewController *vc = [ScoresViewController new];
            vc.view.frame = CGRectMake(UI_WIDTH * i, 0, UI_WIDTH , UI_HEGIHT - Anno750(80));
            [self.mainScroll addSubview:vc.view];
            [self addChildViewController:vc];
            [self.viewControllers addObject:vc];
        }else{
            [self.viewControllers addObject:@"OderStatusViewController"];
        }
        
    }
    
    //这里 是是用时进行创建 避免内存浪费
    __weak StandingViewController * weakSelf = self;
    [self.segmentControl setIndexChangeBlock:^(NSInteger index) {
        if (![weakSelf.viewControllers[index] isKindOfClass:[UIViewController class]]) {
            ScoresViewController *vc = [ScoresViewController new];
            if (index == 1) {
                vc.isSecond = YES;
            }
            vc.view.frame = CGRectMake(UI_WIDTH * index, 0, UI_WIDTH , UI_HEGIHT - Anno750(80));
            [weakSelf.mainScroll addSubview:vc.view];
            [weakSelf addChildViewController:vc];
            [weakSelf.viewControllers replaceObjectAtIndex:index withObject:vc];
        }
        [UIView animateWithDuration:0.3f animations:^{
            weakSelf.mainScroll.contentOffset = CGPointMake(UI_WIDTH * index, 0);
        }];
    }];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int index = scrollView.contentOffset.x / UI_WIDTH;
    [self.segmentControl setSelectedSegmentIndex:index animated:YES];
    if (![self.viewControllers[index] isKindOfClass:[UIViewController class]]) {
        ScoresViewController *vc = [ScoresViewController new];
        if (index == 1) {
            vc.isSecond = YES;
        }
        vc.view.frame = CGRectMake(UI_WIDTH * index, 0, UI_WIDTH , UI_HEGIHT - Anno750(80));
        [self.mainScroll addSubview:vc.view];
        [self addChildViewController:vc];
        [self.viewControllers replaceObjectAtIndex:index withObject:vc];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
