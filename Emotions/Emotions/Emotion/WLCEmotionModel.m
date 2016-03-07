//
//  WLCEmotionModel.m
//  Emotions
//
//  Created by 王 on 16/3/3.
//  Copyright © 2016年 WLChopSticks. All rights reserved.
//

#import "WLCEmotionModel.h"

@implementation WLCEmotionModel


+(instancetype)emotionModelWithDict:(NSDictionary *)dict {

    WLCEmotionModel *emotionModel = [[WLCEmotionModel alloc]init];
    [emotionModel setValuesForKeysWithDictionary:dict];
    
    return emotionModel;

}
///Users/wang/Desktop/OC/Emotions/Emotions/Emotion/Emoticons.bundle/com.sina.default/d_aini@2x.png
-(void)setValue:(id)value forUndefinedKey:(NSString *)key {}


-(NSString *)imagePath {
    //路径寻找不需要加2x 3x,通过UIImage的imagewithcontentsoffile方法自动实现
    NSString *bundle = [NSBundle mainBundle].bundlePath;
    NSString *directory = [NSString stringWithFormat:@"/Emoticons.bundle/%@",self.idName];
    NSString *path = [NSString stringWithFormat:@"%@/%@/%@",bundle,directory,self.png];
    
    return path;
}

-(instancetype)initWithDeleteBtn:(BOOL)isDelete {
    
    if (self = [super init]) {
        
        self.isDelelateBtn = isDelete;
    }
    return self;
    
    
}

-(instancetype)initWithEmptyBtn:(BOOL)isEmpty {
    
    if (self = [super init]) {
        
        self.isDEmptyBtn = isEmpty;
    }
    return self;
    
    
}

@end
