//
//  JpushModel.h
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/5/8.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "BaseModel.h"

@interface JpushModel : BaseModel
@property(nonatomic,copy) NSString *type;//资源类型 （videos/news/photos）
@property(nonatomic,copy) NSString *url; //视频链接
@property(nonatomic,copy) NSString * id; //新闻/图集地址id
/*type      1 : videos          视频
 2 : news            新闻
 3 : photos          图集
 */

@property(nonatomic,copy) NSString *version; //版本号
@end
