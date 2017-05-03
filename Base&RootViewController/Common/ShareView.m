//
//  ShareView.m
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/4/28.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "ShareView.h"

@implementation ShareButton

- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    return CGRectMake(0, Anno750(100), buttonWith, Anno750(40));
}
- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    return CGRectMake((buttonWith - Anno750(90))/2, 0, Anno750(90), Anno750(90));
}


@end

@implementation ShareView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
        [self setFristValue];
        self.backgroundColor = [UIColor clearColor];
        self.hidden = YES;
        self.userInteractionEnabled = YES;
    }
    return self;
}
- (void)creatUI{
    self.showView = [BYFactory creatViewWithColor:[UIColor clearColor]];
    self.bottomBtn = [BYFactory creatButtonWithTitle:@"取消"
                                     backGroundColor:[UIColor whiteColor] textColor:BYColor_Title
                                            textSize:font750(30)];
    self.bottomBtn.layer.cornerRadius = Anno750(10);
    self.topView = [BYFactory creatViewWithColor:[UIColor whiteColor]];
    self.topView.layer.cornerRadius = Anno750(10);
    NSArray * images = @[@"weixin",@"friends",@"QQ",@"Qzone",@"weibo"];
    NSArray * titles = @[@"微信好友",@"微信朋友圈",@"QQ好友",@"QQ空间",@"微博"];
    for (int i = 0; i<images.count; i++) {
        ShareButton * btn = [self creatShareButtonWithTitle:titles[i] imageName:images[i]];
        if (i == 0) {
            self.share_WXer = btn;
        }else if(i == 1){
            self.share_WXfriend = btn;
        }else if(i == 2){
            self.share_QQ = btn;
        }else if(i == 3){
            self.share_Qzone = btn;
        }else if(i ==4){
            self.share_weibo = btn;
        }
        btn.tag = i;
        [btn addTarget:self action:@selector(doShareWithButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.topView addSubview:btn];
        
    }
    self.clearButton = [BYFactory creatButtonWithTitle:@"" backGroundColor:[UIColor clearColor] textColor:[UIColor clearColor] textSize:1];
    [self addSubview:self.showView];
    [self addSubview:self.clearButton];
    [self.clearButton addTarget:self action:@selector(dissmiss) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomBtn addTarget:self action:@selector(dissmiss) forControlEvents:UIControlEventTouchUpInside];
    [self.showView addSubview:self.bottomBtn];
    [self.showView addSubview:self.topView];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.showView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.top.equalTo(@(UI_HEGIHT));
        make.height.equalTo(@(Anno750(330)));
    }];
    [self.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@(Anno750(-20)));
        make.left.equalTo(@(Anno750(24)));
        make.right.equalTo(@(-Anno750(24)));
        make.height.equalTo(@(Anno750(90)));
    }];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.bottomBtn.mas_top).offset(-Anno750(20));
        make.left.equalTo(@(Anno750(24)));
        make.right.equalTo(@(-Anno750(24)));
        make.height.equalTo(@(Anno750(200)));
    }];
    [self.share_WXer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.centerY.equalTo(@0);
        make.width.equalTo(@(buttonWith));
        make.height.equalTo(@(buttonWith));
    }];
    [self.share_WXfriend mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.share_WXer.mas_right);
        make.centerY.equalTo(@0);
        make.width.equalTo(@(buttonWith));
        make.height.equalTo(@(buttonWith));
    }];
    [self.share_QQ mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.share_WXfriend.mas_right);
        make.centerY.equalTo(@0);
        make.width.equalTo(@(buttonWith));
        make.height.equalTo(@(buttonWith));
    }];
    [self.share_Qzone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.share_QQ.mas_right);
        make.centerY.equalTo(@0);
        make.width.equalTo(@(buttonWith));
        make.height.equalTo(@(buttonWith));
    }];
    [self.share_weibo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.share_Qzone.mas_right);
        make.centerY.equalTo(@0);
        make.width.equalTo(@(buttonWith));
        make.height.equalTo(@(buttonWith));
    }];
    [self.clearButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.top.equalTo(@0);
        make.bottom.equalTo(@(-Anno750(330)));
    }];
}
- (ShareButton *)creatShareButtonWithTitle:(NSString *)title imageName:(NSString *)imageName{
    ShareButton * button = [ShareButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    [button setTitle:title forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:font750(26)];
    [button setTitleColor:BYColor_Title forState:UIControlStateNormal];
    
    return button;
}

- (void)setFristValue{
    self.shareTitle = @"拜仁慕尼黑";
    self.shareDesc = @"拜仁慕尼黑中国官方指定唯一正版APP";
    self.targeturl = @"https://itunes.apple.com/app/id1014233862";
    self.imageUrl = @"";
    self.image = [UIImage imageNamed:@"logo"];
}
- (void)updateShareInfoWithTitle:(NSString *)title desc:(NSString *)desc contentUlr:(NSString *)url imageUrl:(NSString *)imageUrl{
    if (title.length>0) {
        self.shareTitle = title;
    }
    if (desc.length>0) {
        self.shareDesc = desc;
    }
    if (url.length>0) {
        self.targeturl = url;
    }
    if (imageUrl.length>0) {
        self.imageUrl = imageUrl;
    }
}
- (void)doShareWithButton:(UIButton *)btn{
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    id image;
    if (self.imageUrl.length<1) {
        image = self.image;
    }else{
        image = self.imageUrl;
    }
    UMShareWebpageObject * shareObj = [UMShareWebpageObject shareObjectWithTitle:self.shareTitle descr:self.shareDesc thumImage:image];
    UMShareImageObject * shareImage = [UMShareImageObject shareObjectWithTitle:self.shareTitle descr:self.shareDesc thumImage:image];
    shareObj.webpageUrl = self.targeturl;
    UMSocialPlatformType type = UMSocialPlatformType_WechatSession;
    switch (btn.tag) {
        case 0:
            type = UMSocialPlatformType_WechatSession;
            break;
        case 1:
            type = UMSocialPlatformType_WechatTimeLine;
            break;
        case 2:
            type = UMSocialPlatformType_QQ;
            break;
        case 3:
            type = UMSocialPlatformType_Qzone;
            break;
        case 4:
        {
            type = UMSocialPlatformType_Sina;
            [shareImage setShareImage:image];
        }
            break;
    }

    messageObject.shareObject = shareObj;
    //调用分享接口
    if (type == UMSocialPlatformType_Sina) {
        messageObject.text = [NSString stringWithFormat:@"%@%@",self.shareDesc,self.targeturl];
        messageObject.shareObject = shareImage;
    }
    [[UMSocialManager defaultManager] shareToPlatform:type messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
    }];
    [self dissmiss];

}
- (void)show{
    if (self.hidden) {
        self.hidden = NO;
    }
    [UIView animateWithDuration:0.5 animations:^{
        self.backgroundColor = UIColorFromRGBA(0x000000, 0.3);
        self.showView.frame = CGRectMake(0, UI_HEGIHT - ShareViewHeigh, UI_WIDTH, ShareViewHeigh);
    }];
}
- (void)dissmiss{
    [UIView animateWithDuration:0.5 animations:^{
        self.showView.frame = CGRectMake(0, UI_HEGIHT, UI_WIDTH, ShareViewHeigh);
        self.backgroundColor = UIColorFromRGBA(0x000000, 0);
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.hidden = YES;
    });
}
@end
