//
//  ScheduDetailViewController.h
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/4/14.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "BaseViewController.h"
typedef NS_ENUM(NSInteger, ScheduType){
    ScheduTypeBundesliga = 0,//德甲
    ScheduTypeChampions,//欧冠
    ScheduTypeGermany,//德国杯
    ScheduTypeEles//其他
};

@interface ScheduDetailViewController : BaseViewController
@property (nonatomic, assign) ScheduType scheduType;
@end
