//
//  CompleteMessageView.m
//  Bayern
//
//  Created by 吴孔锐 on 16/9/25.
//  Copyright © 2016年 Wusicong. All rights reserved.
//

#import "CompleteMessageView.h"
#define LayerColor [UIColor colorWithRed:0.15 green:0.35 blue:0.67 alpha:1.00]
@implementation CompleteMessageView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = BYColor_login;
        [self creatUI];
    }
    return self;
}
- (void)creatUI{
    self.icon = [BYFactory creatImageViewWithImage:@"Logo_big"];
    self.firstLabel = [BYFactory creatLabelWithText:@"完善个人信息"
                                          fontValue:font750(32)
                                          textColor:BYColor_Main
                                      textAlignment:NSTextAlignmentCenter];
    self.secondLabel = [BYFactory creatLabelWithText:@"享受更多拜仁官网贴心服务"
                                           fontValue:font750(32)
                                           textColor:BYColor_Main
                                       textAlignment:NSTextAlignmentCenter];
    self.firstLabel.font = [UIFont boldSystemFontOfSize:Anno750(32)];
    self.secondLabel.font = [UIFont boldSystemFontOfSize:Anno750(32)];
    self.completeButton = [BYFactory creatButtonWithTitle:@"去完善信息"
                                          backGroundColor:BYColor_Main
                                                textColor:[UIColor whiteColor]
                                                 textSize:font750(30)];
    self.completeButton.layer.cornerRadius = Anno750(90)/2;
    self.cannceButton = [BYFactory creatButtonWithNormalImage:@"CompleteDelete" selectImage:nil];
    self.icon.frame = CGRectMake((UI_WIDTH - Anno750(260))/2, Anno750(360), Anno750(260), Anno750(260));
    self.firstLabel.frame = CGRectMake(0, Anno750(660), UI_WIDTH, 20);
    self.secondLabel.frame = CGRectMake(0, self.firstLabel.frame.size.height+self.firstLabel.frame.origin.y, UI_WIDTH, 20);
    self.completeButton.frame = CGRectMake((UI_WIDTH - Anno750(260))/2, self.secondLabel.frame.size.height+self.secondLabel.frame.origin.y+Anno750(40), Anno750(260), Anno750(90));
    self.cannceButton.frame = CGRectMake((UI_WIDTH - Anno750(65))/2, self.completeButton.frame.size.height+self.completeButton.frame.origin.y+ Anno750(30), Anno750(65), Anno750(65));
    
    [self addSubview:self.icon];
    [self addSubview:self.firstLabel];
    [self addSubview:self.secondLabel];
    [self addSubview:self.completeButton];
    [self addSubview:self.cannceButton];
    [self drawLeftLayer];
    [self drawRightLayer];
    
}
- (void)drawLeftLayer{
    UIBezierPath * path = [UIBezierPath bezierPath];
    
    CGPoint star = CGPointMake(self.completeButton.frame.origin.x, self.completeButton.frame.size.height/2 + self.completeButton.frame.origin.y);
    CGPoint end = CGPointMake(self.icon.frame.origin.x - Anno750(20), self.icon.frame.size.height/2 +self.icon.frame.origin.y);
    CGPoint point1 = CGPointMake(Anno750(120), star.y);
    CGPoint point2 = CGPointMake(Anno750(120), end.y);
    CGPoint end2 = CGPointMake(self.icon.frame.origin.x + self.icon.frame.size.width/2, self.icon.frame.origin.y - Anno750(20));
    
    [path moveToPoint:star];
    [path addLineToPoint:point1];
    [path addLineToPoint:point2];
    [path addLineToPoint:end];
    [path addQuadCurveToPoint:end2 controlPoint:CGPointMake(end.x  , end2.y + Anno750(20))];
    
    CAShapeLayer * layer = [CAShapeLayer layer];
    layer.strokeColor = LayerColor.CGColor;
    layer.lineWidth = 1.0f;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.path = path.CGPath;
    [self.layer addSublayer:layer];
}
- (void)drawRightLayer{
    UIBezierPath * path = [UIBezierPath bezierPath];
    
    CGPoint star = CGPointMake(self.completeButton.frame.origin.x + self.completeButton.frame.size.width, self.completeButton.frame.size.height/2 + self.completeButton.frame.origin.y);
    CGPoint end = CGPointMake(self.icon.frame.origin.x + self.icon.frame.size.width + Anno750(20), self.icon.frame.size.height/2 +self.icon.frame.origin.y);
    CGPoint point1 = CGPointMake(UI_WIDTH - Anno750(120), star.y);
    CGPoint point2 = CGPointMake(UI_WIDTH - Anno750(120), end.y);
    [path moveToPoint:star];
    [path addLineToPoint:point1];
    [path addLineToPoint:point2];
    [path addLineToPoint:end];
    
    CAShapeLayer * layer = [CAShapeLayer layer];
    layer.strokeColor = LayerColor.CGColor;
    layer.lineWidth = 1.0f;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.path = path.CGPath;
    [self.layer addSublayer:layer];
}
@end
