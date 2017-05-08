//
//  JpushHander.m
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/5/8.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "JpushHander.h"

@implementation JpushHander
static JpushHander * hander = nil;
+ (instancetype)defaultHander{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        hander = [[self alloc] init];
    });
    return hander;
}
- (void)handerPushUserInfo:(NSDictionary *)dic withBack:(BOOL)isBack vc:(UIViewController *)vc{
    if (isBack) {
        [self handerUserinfo:dic withVc:vc];
    }else{
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:@"最新战报" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"知道了"
                                                          style:(UIAlertActionStyleCancel) handler:nil];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"去查看"
                                                          style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                                                               [self handerUserinfo:dic withVc:vc];
                                                          }];
        [alertVC addAction:action1];
        [alertVC addAction:action2];
        [vc presentViewController:alertVC animated:YES completion:nil];
    }
}
- (void)handerUserinfo:(NSDictionary *)dic withVc:(UIViewController *)vc{
    JpushModel * model = [[JpushModel alloc]initWithDictionary:dic];
    if ([model.type intValue] == 1 || [model.type isEqualToString:@"video"]) {
        MainWebViewController * video = [[MainWebViewController alloc]initWithTitle:@"视频"
                                                                                url:model.url
                                                                        andFromType:FromTypeVideo];
        video.backType = SelectorBackTypeDismiss;
        UINavigationController * nvc = [[UINavigationController alloc]initWithRootViewController:video];
        [vc presentViewController:nvc animated:YES completion:nil];
    }else if ([model.type intValue] == 2 || [model.type isEqualToString:@"news"]) {
        NSNumber * num = [NSNumber numberWithInt:[model.id intValue]];
        NewsDetailViewController * news = [[NewsDetailViewController alloc]initWithNewsid:num];
        news.backType = SelectorBackTypeDismiss;
        UINavigationController * nvc = [[UINavigationController alloc]initWithRootViewController:news];
        [vc presentViewController:nvc animated:YES completion:nil];
    }else if ([model.type intValue] == 3 || [model.type isEqualToString:@"photos"]) {
        NSNumber * num = [NSNumber numberWithInt:[model.id intValue]];
        PhotoDetailViewController * photo = [[PhotoDetailViewController alloc]initWithPhotoDetailid:num];
        photo.backType = SelectorBackTypeDismiss;
        UINavigationController * nvc = [[UINavigationController alloc]initWithRootViewController:photo];
        [vc presentViewController:nvc animated:YES completion:nil];
    }
}
@end
