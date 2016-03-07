//
//  WLCEmotionKeyboard.h
//  Emotions
//
//  Created by 王 on 16/3/3.
//  Copyright © 2016年 WLChopSticks. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface NSString (Emoji)

//将十六进制的编码转为emoji字符
+ (NSString *)emojiWithIntCode:(int)intCode;

//将十六进制的编码转为emoji字符
+ (NSString *)emojiWithStringCode:(NSString *)stringCode;
- (NSString *)emoji;


//是否为emoji字符
- (BOOL)isEmoji;

@end
