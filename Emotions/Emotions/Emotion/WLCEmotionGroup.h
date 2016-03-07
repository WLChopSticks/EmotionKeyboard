//
//  WLCEmotionModel.h
//  Emotions
//
//  Created by 王 on 16/3/3.
//  Copyright © 2016年 WLChopSticks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLCEmotionGroup : NSObject

//分组路径
@property (copy, nonatomic) NSString *idName;
//组名字
@property (copy, nonatomic) NSString *group_name_cn;
//表情
@property (strong, nonatomic) NSArray *emoticons;



+(instancetype)emotionModelWithDict: (NSDictionary *)dict andIdName: (NSString *)idName;

@end
