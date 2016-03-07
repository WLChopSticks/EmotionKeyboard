//
//  WLCEmotionKeyboard.h
//  Emotions
//
//  Created by 王 on 16/3/3.
//  Copyright © 2016年 WLChopSticks. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    WLCEmotionKeyboardTypeDefault,
    WLCEmotionKeyboardTypeEmoji,
    WLCEmotionKeyboardTypeLxh,
} WLCEmotionKeyboardType;

@class WLCEmotionKeyboard,WLCEmotionModel;
@protocol emotionKeyboardDelegate <NSObject>

-(void)emotionKeyboarView: (WLCEmotionKeyboard *)emotionKeyboard selectEmotion: (WLCEmotionModel *)emotionModel;

@end

@interface WLCEmotionKeyboard : UIView

@property (weak, nonatomic) id<emotionKeyboardDelegate> delegate;
@end
