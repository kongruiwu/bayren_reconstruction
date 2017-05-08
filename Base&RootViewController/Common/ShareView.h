//
//  ShareView.h
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/4/28.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfigHeader.h"
#import <UMSocialCore/UMSocialCore.h>
#define buttonWith Anno750(140)
#define ShareViewHeigh Anno750(460)

@interface ShareButton : UIButton

@end


@interface ShareView : UIView

//分享标题
@property (nonatomic, strong) NSString * shareTitle;
//分享描述
@property (nonatomic, strong) NSString * shareDesc;
//分享图片
@property (nonatomic, strong) NSString * imageUrl;
//分享目标
@property (nonatomic, strong) NSString * targeturl;
//图片
@property (nonatomic, strong) UIImage * image;

@property (nonatomic, strong) UIView * showView;
@property (nonatomic, strong) UIView * topView;
@property (nonatomic, strong) UIButton * bottomBtn;
@property (nonatomic, strong) ShareButton * share_WXfriend;
@property (nonatomic, strong) ShareButton * share_WXer;
@property (nonatomic, strong) ShareButton * share_weibo;
@property (nonatomic, strong) ShareButton * share_Qzone;
@property (nonatomic, strong) ShareButton * share_QQ;
@property (nonatomic, strong) UIButton * clearButton;

- (void)show;
- (void)showWithNavtionBarHidden;
- (void)dissmiss;
//刷新界面
- (void)updateShareInfoWithTitle:(NSString *)title desc:(NSString *)desc contentUlr:(NSString *)url imageUrl:(NSString *)imageUrl;
@end
