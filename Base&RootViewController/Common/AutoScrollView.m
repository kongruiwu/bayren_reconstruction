//
//  AutoScrollView.m
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/3/21.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "AutoScrollView.h"
#import <UIImageView+WebCache.h>
@interface AutoScrollView()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView * mainScrol;
@property (nonatomic, strong) NSTimer * timer;
@property (nonatomic, strong) UILabel * titleLabel;
/**存放imgview的数组，在刷新数据，删除旧的imgview使用*/
@property (nonatomic, strong) NSMutableArray * imgViews;
@end


@implementation AutoScrollView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI:frame];
    }
    return self;
}
- (void)creatUI:(CGRect)frame{
    self.imgViews = [NSMutableArray new];
    
    self.mainScrol = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    self.mainScrol.showsVerticalScrollIndicator = NO;
    self.mainScrol.showsHorizontalScrollIndicator = NO;
    self.mainScrol.delegate = self;
    self.mainScrol.bounces = NO;//关闭弹簧效果
    self.mainScrol.pagingEnabled = YES;
    self.mainScrol.contentOffset =CGPointMake(UI_WIDTH, 0);
    
    UIImageView * imageview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"banner_defult"]];
    imageview.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    [self.mainScrol addSubview:imageview];
    [self.imgViews addObject:imageview];
    
    self.pageControl = [[BYPageControl alloc]init];
    self.pageControl.currentPageIndicatorTintColor = BYColor_Main;
    self.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    self.pageControl.currentPage = 0;
    
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font = [UIFont systemFontOfSize:font750(26)];
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.titleLabel.text = @"拜仁足球";
    
    [self addSubview:self.mainScrol];
    [self addSubview:self.titleLabel];
    [self addSubview:self.pageControl];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(24)));
        make.centerY.equalTo(@(frame.size.height/2 - font750(30)));
    }];
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-Anno750(24)));
        make.centerY.equalTo(@(frame.size.height/2 - font750(30)));
    }];
    
    //设置类似阴影效果
    CAGradientLayer * colorLayer = [CAGradientLayer layer];
    colorLayer.frame = CGRectMake(-Anno750(24), -Anno750(15) ,frame.size.width+Anno750(24), Anno750(60));
    [self.titleLabel.layer addSublayer:colorLayer];
    colorLayer.colors = @[(__bridge id)UIColorFromRGBA(0x000000, 0.1).CGColor,(__bridge id)UIColorFromRGBA(0x000000, 0.9).CGColor];
    colorLayer.startPoint = CGPointMake(0, 0);
    colorLayer.endPoint = CGPointMake(0, 1);
}
- (void)updateWithImages:(NSArray *)imgArray descs:(NSArray *)descs{
    for (int i = 0; i<self.imgViews.count; i++) {
        UIImageView * imgview = self.imgViews[i];
        [imgview removeFromSuperview];
    }
    [self.imgViews removeAllObjects];
    self.images = imgArray;
    NSMutableArray * imagesM = [NSMutableArray arrayWithArray:imgArray];
    [imagesM insertObject:[imgArray lastObject] atIndex:0];
    [imagesM addObject:[imgArray firstObject]];
    
    for (int i = 0; i<imagesM.count; i++) {
        UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        if ([imagesM[i] isKindOfClass:[NSString class]]) {
            [imgView sd_setImageWithURL:[NSURL URLWithString:imagesM[i]] placeholderImage:[UIImage imageNamed:@"banner_defult"]];
        }else{
            imgView.image = (UIImage *)imagesM[i];
        }
        [self.imgViews addObject:imgView];
        [self.mainScrol addSubview:imgView];
    }
    self.titleLabel.text = descs[0];
    self.descs = descs;
    self.pageControl.numberOfPages = imgArray.count;
    self.mainScrol.contentSize = CGSizeMake(imagesM.count * self.frame.size.width, 0);
    [self setNeedsLayout];
    [self starTimer];
    
}
- (void)starTimer{
    if (self.timer == nil) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
}
- (void)invalidateTimer{
    [self.timer invalidate];
    self.timer = nil;
}
- (void)updateTimer{
    [UIView animateWithDuration:1.5 animations:^{
        self.mainScrol.contentOffset = CGPointMake(self.mainScrol.contentOffset.x + UI_WIDTH, 0);
    }];
    
    [self scrollViewDidEndDecelerating:self.mainScrol];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == self.mainScrol) {
        CGFloat offsetX = scrollView.contentOffset.x;
        if (offsetX == 0) {
            scrollView.contentOffset = CGPointMake(UI_WIDTH * self.images.count, 0);
        }
        else if(offsetX == UI_WIDTH *(self.images.count +1)){
            scrollView.contentOffset = CGPointMake(UI_WIDTH, 0);
        }
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetX = scrollView.contentOffset.x;
    _pageControl.currentPage =(offsetX /UI_WIDTH) - 1;
    int index = (int)self.pageControl.currentPage;
    self.titleLabel.text = self.descs[index];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (scrollView == self.mainScrol) {
        [self invalidateTimer];
    }
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (scrollView == self.mainScrol) {
        [self starTimer];
    }
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.mainScrol.subviews enumerateObjectsUsingBlock:^(UIImageView * imgView, NSUInteger idx, BOOL * _Nonnull stop) {
        CGRect frame = imgView.frame;// 调整x => origin => frame
        frame.origin.x = idx * frame.size.width;
        imgView.frame = frame;
    }];
}
@end
