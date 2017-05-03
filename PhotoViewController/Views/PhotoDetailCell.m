//
//  PhotoDetailCell.m
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/5/2.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "PhotoDetailCell.h"

@implementation PhotoDetailCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        [self creatUI];
    }
    return self;
}
- (void)creatUI{
    self.userInteractionEnabled = YES;
    self.imgView = [[UIImageView alloc]init];
    self.mainSc = [[UIScrollView alloc]init];
    self.mainSc.minimumZoomScale = 1.0f;
    self.mainSc.maximumZoomScale = 2.0f;
    self.imgView.image = [UIImage imageNamed:@"groundImage"];
    self.titleLabel = [BYFactory creatLabelWithText:@"我是标题"
                                          fontValue:font750(30)
                                          textColor:[UIColor whiteColor]
                                      textAlignment:NSTextAlignmentLeft];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:font750(34)];
    self.descLabel = [BYFactory creatLabelWithText:@"我是描述文字我是描述文字我是描述文字我是描述文字我是描述文字我是描述文字我是描述文字我是描述文字我是描述文字我是描述文字我是描述文字我是描述文字"
                                         fontValue:font750(26)
                                         textColor:[UIColor whiteColor]
                                     textAlignment:NSTextAlignmentLeft];
    self.descLabel.numberOfLines = 0;
    self.pageLabel = [BYFactory creatLabelWithText:@"10/19"
                                         fontValue:font750(30)
                                         textColor:[UIColor whiteColor]
                                     textAlignment:NSTextAlignmentCenter];
    self.numLabel = [BYFactory creatLabelWithText:@"10/19"
                                        fontValue:font750(30)
                                        textColor:[UIColor whiteColor]
                                    textAlignment:NSTextAlignmentCenter];
    self.grayView = [BYFactory creatViewWithColor:BYColor_Line];
    self.downLoadBtn = [BYFactory creatButtonWithNormalImage:@"download" selectImage:@""];
    [self addSubview:self.mainSc];
    [self.mainSc addSubview:self.imgView];
    [self addSubview:self.grayView];
    [self.grayView addSubview:self.titleLabel];
    [self.grayView addSubview:self.descLabel];
    [self.grayView addSubview:self.pageLabel];
    [self addSubview:self.numLabel];
    [self addSubview:self.downLoadBtn];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.mainSc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    [self.grayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.bottom.equalTo(@0);
        make.height.equalTo(@(UI_HEGIHT * 0.3));
    }];
    [self.pageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-Anno750(24)));
        make.top.equalTo(@(Anno750(24)));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(24)));
        make.right.equalTo(@(-Anno750(100)));
        make.top.equalTo(@(Anno750(24)));
    }];
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(Anno750(24));
        make.left.equalTo(@(Anno750(24)));
        make.right.equalTo(@(-Anno750(24)));
    }];
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(24)));
        make.bottom.equalTo(@(Anno750(-20)));
    }];
    [self.downLoadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-Anno750(24)));
        make.width.equalTo(@(Anno750(60)));
        make.height.equalTo(@(Anno750(60)));
        make.bottom.equalTo(@(Anno750(-20)));
    }];
    
}
@end
