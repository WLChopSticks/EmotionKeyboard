//
//  WLCEmotionLoad.m
//  Emotions
//
//  Created by 王 on 16/3/3.
//  Copyright © 2016年 WLChopSticks. All rights reserved.
//

#import "WLCEmotionLoad.h"
#import "WLCEmotionGroup.h"

@interface WLCEmotionLoad ()

//存储表情的数组
@property (strong, nonatomic) NSMutableArray *EmotionsSaved;

@end

@implementation WLCEmotionLoad

-(NSArray *)loadEmotionFile {
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"emoticons.plist" ofType:nil inDirectory:@"Emoticons.bundle"];
    if (path == nil) {
        NSLog(@"文件目录不存在");
        return nil;
    }

    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    
    NSArray *arrTem = dict[@"packages"];
   
    for (NSDictionary *dictTem in arrTem) {
        
        NSString *idName = dictTem[@"id"];

        [self loadEmotionsWithOneGroup:idName];
    }
    
    //返回读取好的表情列表
    return self.EmotionsSaved.copy;
}

//加载单组表情文件
-(void)loadEmotionsWithOneGroup: (NSString *)idName {

    NSString *path = [[NSBundle mainBundle]pathForResource:@"Info.plist" ofType:nil inDirectory:[NSString stringWithFormat:@"Emoticons.bundle/%@",idName]];

    
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    //字典转模型
    WLCEmotionGroup *emotionModel = [WLCEmotionGroup emotionModelWithDict:dict andIdName:idName];
    [self.EmotionsSaved addObject:emotionModel];
    
    
}

//懒加载
-(NSMutableArray *)EmotionsSaved {
    if (_EmotionsSaved == nil) {
        _EmotionsSaved = [NSMutableArray array];
    }
    return _EmotionsSaved;
}

@end
