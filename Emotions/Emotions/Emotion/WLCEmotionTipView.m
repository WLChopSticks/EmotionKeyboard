//
//  WLCEmotionTipView.m
//  Emotions
//
//  Created by 王 on 16/3/4.
//  Copyright © 2016年 WLChopSticks. All rights reserved.
//

#import "WLCEmotionTipView.h"
#import "NSString+Emoji.h"
#import "Masonry.h"

@interface WLCEmotionTipView ()

@property (weak, nonatomic) UIButton *emotionImageBtn;

@end

@implementation WLCEmotionTipView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self decorateUI];
    }
    
    return self;
}

#pragma -mark 布局
-(void)decorateUI {    
    
    NSString *deleteBtnImagePath = [NSString stringWithFormat:@"%@/Emoticons.bundle/emoticon_keyboard_magnifier.imageset/emoticon_keyboard_magnifier.png",[NSBundle mainBundle].bundlePath];
    self.image = [UIImage imageWithContentsOfFile:deleteBtnImagePath];


    
    //设置显示表情的button,否则emoji表情不显示
    UIButton *emotionImageBtn = [[UIButton alloc]init];
    self.emotionImageBtn = emotionImageBtn;
    //emoji表情大小
    emotionImageBtn.titleLabel.font = [UIFont systemFontOfSize:40];
    
    [self addSubview:emotionImageBtn];
    
    
    //约束
    [emotionImageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(0);
        make.left.equalTo(self.mas_left).offset(50);
        make.right.equalTo(self.mas_right).offset(-5);
        make.height.mas_equalTo(self.frame.size.height * 0.55);
    }];
    
    
}

#pragma -mark 获取图片路径,读取图片
-(void)setEmotionModel:(WLCEmotionModel *)emotionModel {
    _emotionModel = emotionModel;
    
    if ([emotionModel.type isEqualToString:@"0"]) {
        
        [self.emotionImageBtn setImage:[UIImage imageWithContentsOfFile:emotionModel.imagePath] forState:UIControlStateNormal];
        [self.emotionImageBtn setTitle:nil forState:UIControlStateNormal];
        //    [self.emotionImageView sizeToFit];
        self.emotionImageBtn.contentMode = UIViewContentModeScaleAspectFill;
        //更新约束,否则不显示图片
        [self updateConstraintsAfterSetImageOrTitle];

    }else if ([emotionModel.type isEqualToString:@"1"]){
        [self.emotionImageBtn setTitle:[emotionModel.code emoji] forState:UIControlStateNormal];
        [self.emotionImageBtn setImage:nil forState:UIControlStateNormal];
        //更新约束,否则不显示图片
        [self updateConstraintsAfterSetImageOrTitle];

    }else {
        [self.emotionImageBtn setTitle:nil forState:UIControlStateNormal];
        [self.emotionImageBtn setImage:nil forState:UIControlStateNormal];
        //更新约束,否则不显示图片
        [self updateConstraintsAfterSetImageOrTitle];

    }
    
}


//更新约束
-(void)updateConstraintsAfterSetImageOrTitle {
    [self.emotionImageBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(self.frame.size.height * 0.1);
        make.left.equalTo(self.mas_left).offset(5);
        make.right.equalTo(self.mas_right).offset(-5);
        make.height.mas_equalTo(self.frame.size.height * 0.55);
    }];
}


@end
