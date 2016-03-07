//
//  WLCEmotionViewCell.m
//  Emotions
//
//  Created by 王 on 16/3/3.
//  Copyright © 2016年 WLChopSticks. All rights reserved.
//

#import "WLCEmotionViewCell.h"
#import "WLCEmotionTipView.h"
#import "NSString+Emoji.h"
#import "Masonry.h"

#define EMOTION_MARGIN 4

@interface WLCEmotionViewCell ()

@property (weak, nonatomic) UIButton *emotionBtn;

@end

@implementation WLCEmotionViewCell

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        
        //布局
        [self decorateUI];
        
    }
    return self;
}

#pragma -mark 布局
-(void)decorateUI {

    //设置表情按钮
    UIButton *emotionBtn = [[UIButton alloc]init];
    self.emotionBtn = emotionBtn;
    emotionBtn.backgroundColor = [UIColor whiteColor];
    emotionBtn.titleLabel.font = [UIFont systemFontOfSize:35];

    [self addSubview:emotionBtn];
    
    //约束
    [emotionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(EMOTION_MARGIN);
        make.left.equalTo(self.mas_left).offset(EMOTION_MARGIN);
        make.right.equalTo(self.mas_right).offset(-EMOTION_MARGIN);
        make.bottom.equalTo(self.mas_bottom).offset(-EMOTION_MARGIN);
    }];
    
}

#pragma -mark emotionModel赋值时,设置图片
-(void)setEmotionModel:(WLCEmotionModel *)emotionModel {
    _emotionModel = emotionModel;

    if ([emotionModel.type isEqualToString:@"1"]) {
        [self.emotionBtn setTitle:[emotionModel.code emoji] forState:UIControlStateNormal];
        [self.emotionBtn setImage:nil forState:UIControlStateNormal];
        
    }else if ([emotionModel.type isEqualToString:@"0"]){
        [self.emotionBtn setImage:[UIImage imageWithContentsOfFile:emotionModel.imagePath] forState:UIControlStateNormal];
        [self.emotionBtn setTitle:nil forState:UIControlStateNormal];
    }else if (emotionModel.isDelelateBtn) {
        NSString *deleteBtnImagePath = [NSString stringWithFormat:@"%@/Emoticons.bundle/compose_emotion_delete.imageset/compose_emotion_delete.png",[NSBundle mainBundle].bundlePath];
        [self.emotionBtn setImage:[UIImage imageWithContentsOfFile:deleteBtnImagePath ]forState:UIControlStateNormal];
        [self.emotionBtn setTitle:nil forState:UIControlStateNormal];
    }else if (emotionModel.isDEmptyBtn) {
        [self.emotionBtn setImage:nil forState:UIControlStateNormal];
        [self.emotionBtn setTitle:nil forState:UIControlStateNormal];
    }
    
    [self.emotionBtn addTarget:self action:@selector(emotionBtnClicking:) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma -mark 表情按钮的点击事件
-(void)emotionBtnClicking: (UIButton *)sender {

    if ([self.delegate respondsToSelector:@selector(emotionViewCell:didClickEmotionButton:withEmotionModel:)]) {
        [self.delegate emotionViewCell:self didClickEmotionButton:sender withEmotionModel:self.emotionModel];
    }
}





@end
