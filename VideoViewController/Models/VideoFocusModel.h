//
//  VideoFocusModel.h
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/3/21.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "BaseModel.h"

@interface VideoFocusModel : BaseModel
@property (nonatomic, strong) NSString * content;
@property (nonatomic, strong) NSString * date;
@property (nonatomic, strong) NSNumber * id;
@property (nonatomic, strong) NSNumber * orderby;
/**视屏图片*/
@property (nonatomic, strong) NSString * pic;
@property (nonatomic, strong) NSNumber * show_id;
@property (nonatomic, strong) NSNumber * show_type;
/**视频标题*/
@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSNumber * type;
/**视屏地址*/
@property (nonatomic, strong) NSString * url;
@end
