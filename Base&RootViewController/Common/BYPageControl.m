//
//  BYPageControl.m
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/3/21.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "BYPageControl.h"

#define NomalW          self.nomalWith?self.nomalWith:Anno750(10)
#define CurrentW        self.currentWith?self.currentWith:Anno750(15)
#define NomalC          self.pageIndicatorTintColor?self.pageIndicatorTintColor:[UIColor grayColor]
#define CurrentC        self.currentPageIndicatorTintColor?self.currentPageIndicatorTintColor:[UIColor whiteColor]
#define SpaceW          self.pageSpace?self.pageSpace:Anno750(20)

@interface BYPageControl()

@property (nonatomic) float nomalW;
@property (nonatomic) float currentW;
@property (nonatomic) float spaceW;
@property (nonatomic) float leftX;
@property (nonatomic, strong) UIColor * nomalC;
@property (nonatomic, strong) UIColor * currentC;


@end


@implementation BYPageControl
//
//- (instancetype)init{
//    self = [super init];
//    if (self) {
//        
//    }
//    return self;
//}
//- (instancetype)initWithFrame:(CGRect)frame{
//    self = [super initWithFrame:frame];
//    if (self) {
//        self.Spots = [NSMutableArray new];
//    }
//    return self;
//}
//- (void)setCount:(NSInteger)count{
//    for (int i = 0; i<count; i++) {
//        UIView * spot = [[UIView alloc]init];
//        
//        self needsUpdateConstraints
//    }
//}
//
//- (void)layoutSubviews{
//    
//}
@end
