//
//  ConfigHeader.h
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/3/20.
//  Copyright © 2017年 wurui. All rights reserved.
//

#ifndef ConfigHeader_h
#define ConfigHeader_h

#import "BYFactory.h"
#import <Masonry.h>
#import "ToastView.h"
#import "NetWorkManger.h"
#import <ReactiveObjC.h>
#import <UIImageView+WebCache.h>
#import <SVProgressHUD.h>
#import "UserManager.h"
#import <UMMobClick/MobClick.h>


//全局返回通用配置选项
typedef NS_ENUM(NSInteger, SelectorBackType){
    SelectorBackTypePopBack = 0,
    SelectorBackTypeDismiss,
    SelectorBackTypePoptoRoot
};




//750状态下字体适配
#define font750(x) ((x)/ 1334.0f) * UI_HEGIHT
//750状态下像素适配宏
#define Anno750(x) ((x)/ 1334.0f) * UI_HEGIHT

#define UI_BOUNDS   [UIScreen mainScreen].bounds
#define UI_HEGIHT   [UIScreen mainScreen].bounds.size.height
#define UI_WIDTH    [UIScreen mainScreen].bounds.size.width


#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define UIColorFromRGBA(rgbValue,sec) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:sec]

#define BYColor_Title   UIColorFromRGB(0x444444)
#define BYColor_Tag     UIColorFromRGB(0x999999)
#define BYColor_gray_6  UIColorFromRGB(0x666666)
#define BYColor_gray_3  UIColorFromRGB(0x333333)
//总体背景色
#define BYColor_Ground  UIColorFromRGB(0xf2f2f2)
//线条色
#define BYColor_Line    UIColorFromRGBA(0x000000,0.2)
//拜仁主色调
#define BYColor_Main    UIColorFromRGB(0x961432)
//登录界面灰色背景
#define BYColor_login   UIColorFromRGBA(0x000000,0.8)

#define BYColor_Alpha_gray  UIColorFromRGBA(0x000000,0.6)
//规避空值
#define INCASE_EMPTY(str, replace) \
( ([(str) length]==0)?(replace):(str) )

#define EventID_Topbar @"Topbar"
#define EventID_Index @"Index"
#define EventID_News @"News"
#define EventID_Photos @"Photos"
#define EventID_Videos @"Videos"

#define KN_MainNav @"MainNav"
#define KN_GameCenter @"GameCenter"
#define KN_List @"List"
#define KN_NewsList @"NewsList"
#define KN_PhotosList @"PhotosList"
#define KN_VideosList @"VideosList"


#endif /* ConfigHeader_h */
