//
//  CommentView.m
//  Bayern
//
//  Created by 吴孔锐 on 2016/9/28.
//  Copyright © 2016年 Wusicong. All rights reserved.
//

#import "CommentView.h"

@implementation CommentView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = BYColor_Ground;

        [self creatUI];
    }
    return self;
}
- (void)creatUI{

    self.textView = [[CommentTextView alloc]init];
    [self addSubview:self.textView];
    
    self.spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.spinner.backgroundColor = [UIColor clearColor];

    [self addSubview:self.spinner];
    
    self.loadingLabel = [BYFactory creatLabelWithText:@"发送中..."
                                            fontValue:font750(30)
                                            textColor:BYColor_gray_3
                                        textAlignment:NSTextAlignmentCenter];
    self.loadingLabel.hidden = YES;
    [self addSubview:self.loadingLabel];
    
    self.commitButton = [BYFactory creatButtonWithTitle:@"发送"
                                        backGroundColor:[UIColor clearColor]
                                              textColor:BYColor_Main
                                               textSize:font750(30)];
    self.commitButton.layer.cornerRadius = Anno750(30);
    self.commitButton.layer.borderColor = BYColor_Main.CGColor;
    self.commitButton.layer.borderWidth = 1.0f;
    
    [self addSubview:self.commitButton];
    
}
- (void)startLoading:(BOOL)rec{
    self.loadingLabel.hidden = !rec;
    if (rec) {
        [self.spinner startAnimating];
    }else{
        [self.spinner stopAnimating];
    }
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(30)));
        make.right.equalTo(@(-Anno750(30)));
        make.height.equalTo(@(Anno750(120)));
        make.top.equalTo(@(Anno750(30)));
    }];
    [self.commitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-Anno750(30)));
        make.width.equalTo(@(Anno750(140)));
        make.height.equalTo(@(Anno750(60)));
        make.top.equalTo(self.textView.mas_bottom).offset(Anno750(20));
    }];
    [self.loadingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.commitButton.mas_centerY);
        make.centerX.equalTo(@(-Anno750(20)));
    }];
    
    [self.spinner mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.loadingLabel.mas_centerY);
        make.right.equalTo(self.loadingLabel.mas_left).offset(- Anno750(20));
    }];
}
@end
