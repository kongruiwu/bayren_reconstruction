//
//  PhotoListModel.h
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/4/24.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "BaseModel.h"

@interface PhotoListModel : BaseModel

@property (nonatomic, retain) NSNumber * id;

@property (nonatomic, strong) NSString * type;
/**背景图*/
@property (nonatomic, strong) NSString * pic;
/**图片标题*/
@property (nonatomic, strong) NSString * title;
/**图片描述*/
@property (nonatomic, strong) NSString * content;
/**日期*/
@property (nonatomic, strong) NSString * date;
/**展示的图片数组  弃用*/
@property (nonatomic, strong) NSArray * thmub;
/**图片数量*/
@property (nonatomic, retain) NSNumber * count;
@end
