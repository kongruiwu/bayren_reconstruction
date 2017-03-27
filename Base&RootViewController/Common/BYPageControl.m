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
//        self.currentPage = 0;
//        self.Spots = [NSMutableArray new];
//    }
//    return self;
//}
//- (void)setCount:(NSInteger)count{
//    self.count = count;
//    if (self.Spots.count>0) {
//        for (int i = 0; i<self.Spots.count; i++) {
//            UIControl * spot = self.Spots[i];
//            [spot removeFromSuperview];
//        }
//        [self.Spots removeAllObjects];
//    }
//    for (int i = 0; i<self.count ; i++) {
//        UIControl * spot = [[UIControl alloc]init];
//        [self.Spots addObject:spot];
//        [self addSubview:spot];
//    }
//}
//- (void)updateStatus{
//    float x = (self.frame.size.width - (NomalW * self.count) - SpaceW * (self.count -1))/2;
//    for (int i = 0; i<self.Spots.count; i++) {
//        UIControl * spot = self.Spots[i];
//        float width ;
//        UIColor * color ;
//        if (i == self.currentPage) {
//            color = CurrentC;
//            width = CurrentW;
//        }else{
//            color = NomalC;
//            width = NomalW;
//        }
//        spot.backgroundColor = color;
//        spot.frame = CGRectMake(x + i * (SpaceW + NomalW), 0, width, width);
//        spot.layer.cornerRadius = (spot.frame.size.width)/2;
//    }
//}
//
//- (void)setCurrentWith:(CGFloat)currentWith{
//    self.currentWith = currentWith;
//    [self updateStatus];
//}
//- (void)setCurrentPage:(NSInteger)currentPage{
//    self.currentPage = currentPage;
//    [self updateStatus];
//}


@end
