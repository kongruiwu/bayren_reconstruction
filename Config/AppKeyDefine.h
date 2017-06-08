//
//  AppKeyDefine.h
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/5/3.
//  Copyright © 2017年 wurui. All rights reserved.
//

#ifndef AppKeyDefine_h
#define AppKeyDefine_h
#import <UMSocialCore/UMSocialCore.h>
#import <UMSocialWechatHandler.h>
#import <UMSocialQQHandler.h>
#define Bayern_APP_STORE_URL @"itms-apps://itunes.apple.com/us/app/id1014233862?mt=8"
#ifdef DEBUG
#define JPUSHKey @"6c1cf57bc76529b3f47fe9b4"
#define isProduction  NO
#else
#define JPUSHKey @"9436c5959a32e18d68a04a33"
#define isProduction  YES
#endif

#define UmengAppKey @"556fb9bf67e58e92cf001646" //Umeng app key

#define WXAppId @"wxe74f684db173a3a1"
#define WXAppSecret @"d6f483f6a1fc95064a4bba7f88642c56" //weixin app key
#define WXShareUrl @"http://www.fcbayern.cn"

#define SinaAppId @"1787781573"
#define SinaAppSecret @"6e11939681a92353db3465c0463c5a1d" //Sina weibo app key

#define QQAppId @"1104603685" //16进制appId 41D6EA25
#define QQAppSecret @"HUogPie8Ivup5vPQ" //QQ/Qzone app key



#endif /* AppKeyDefine_h */
