//
//  VideoListModel.h
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/3/21.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "BaseModel.h"

@interface VideoListModel : BaseModel

@property (nonatomic, strong) NSNumber * cont_type;
/**内容*/
@property (nonatomic, strong) NSString * content;
/**时间*/
@property (nonatomic, strong) NSString * date;

@property (nonatomic, strong) NSNumber * id;
/**网页地址 可能为空*/
@property (nonatomic, strong) NSString * link;
/**缩略图地址*/
@property (nonatomic, strong) NSString * pic;
/**链接地址*/
@property (nonatomic, strong) NSString * src;
/**视屏标签*/
@property (nonatomic, strong) NSArray * tags;
/**视屏标题*/
@property (nonatomic, strong) NSString * title;

@end
