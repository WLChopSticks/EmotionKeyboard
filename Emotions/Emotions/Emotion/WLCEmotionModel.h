//
//  WLCEmotionModel.h
//  Emotions
//
//  Created by 王 on 16/3/3.
//  Copyright © 2016年 WLChopSticks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLCEmotionModel : NSObject

@property (copy, nonatomic) NSString *chs;
@property (copy, nonatomic) NSString *cht;
@property (copy, nonatomic) NSString *png;
@property (copy, nonatomic) NSString *gif;
//0为正常图片表情,1为emoji表情
@property (copy, nonatomic) NSString *type;

//emoji表情
@property (copy, nonatomic) NSString *code;

//完整表情路径
@property (copy, nonatomic) NSString *imagePath;
//表情的文件夹路径
@property (copy, nonatomic) NSString *idName;

//是否是最后的删除图片
@property (assign, nonatomic) BOOL isDelelateBtn;
-(instancetype)initWithDeleteBtn: (BOOL)isDelete;

//空白表情图片
@property (assign, nonatomic) BOOL isDEmptyBtn;
-(instancetype)initWithEmptyBtn: (BOOL)isEmpty;

//字典转模型
+(instancetype)emotionModelWithDict: (NSDictionary *)dict;

@end
