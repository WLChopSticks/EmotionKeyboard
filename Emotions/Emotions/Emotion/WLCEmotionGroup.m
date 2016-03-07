//
//  WLCEmotionModel.m
//  Emotions
//
//  Created by 王 on 16/3/3.
//  Copyright © 2016年 WLChopSticks. All rights reserved.
//

#import "WLCEmotionGroup.h"
#import "WLCEmotionModel.h"

@interface WLCEmotionGroup ()

//暂存表情数量的数组
@property (strong, nonatomic) NSMutableArray *arrM;

@end

@implementation WLCEmotionGroup

+(instancetype)emotionModelWithDict:(NSDictionary *)dict andIdName:(NSString *)idName {
    WLCEmotionGroup *emotionModel = [[WLCEmotionGroup alloc]init];
    
    emotionModel.idName = idName;
    [emotionModel setValuesForKeysWithDictionary:dict];
 
    return emotionModel;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key {}

-(void)setEmoticons:(NSArray *)emoticons {
//    _emoticons = emoticons;
    //将单个表情字典转模型
//    NSMutableArray *arrM = [NSMutableArray array];
    NSInteger index = 0;
    for (NSDictionary *dict in emoticons) {
        WLCEmotionModel *emotionModel = [WLCEmotionModel emotionModelWithDict:dict];
        emotionModel.idName = self.idName;
        [self.arrM addObject:emotionModel];
        index++;
        if (index == 20) {
            WLCEmotionModel *emotionModel = [[WLCEmotionModel alloc]initWithDeleteBtn:YES];
            [self.arrM addObject:emotionModel];
            index = 0;
        }
    }
    //插入空表情
    [self insertEmptyEmotion:emoticons];
    
    _emoticons = self.arrM;
}


//每页不足20个表情,增加空白表情
-(void)insertEmptyEmotion: (NSArray *)emoticons {
    
    
    NSInteger count = emoticons.count % 20;
    
    if (count == 0) {
        return;
    }
    for (int i = 0; i < (20 - count); i++) {
        WLCEmotionModel *emotionModel = [[WLCEmotionModel alloc]initWithEmptyBtn:YES];
        [self.arrM addObject:emotionModel];
    }
    
    [self.arrM addObject:[[WLCEmotionModel alloc]initWithDeleteBtn:YES]];


}


//懒加载
-(NSMutableArray *)arrM {
    if (_arrM == nil) {
        _arrM = [NSMutableArray array];
    }
    return _arrM;
}


@end
