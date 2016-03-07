//
//  ViewController.m
//  Emotions
//
//  Created by 王 on 16/3/3.
//  Copyright © 2016年 WLChopSticks. All rights reserved.
//

#import "ViewController.h"
#import "WLCEmotionKeyboard.h"
#import "WLCEmotionModel.h"
#import "NSString+Emoji.h"

@interface ViewController ()<emotionKeyboardDelegate>

@property (weak, nonatomic) UITextView *textView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UITextView *textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 50, 300, 300)];
    self.textView = textView;
    textView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:textView];
    [textView becomeFirstResponder];
    
    
    WLCEmotionKeyboard *keyboard = [[WLCEmotionKeyboard alloc]init];
    keyboard.delegate = self;
    
    textView.inputView = keyboard;
}

-(void)emotionKeyboarView:(WLCEmotionKeyboard *)emotionKeyboard selectEmotion:(WLCEmotionModel *)emotionModel {

//    [self.textView insertText: emotionModel.chs];
    
    if (self.textView.font == nil) {
        self.textView.font = [UIFont systemFontOfSize:12];
    }
    
    
    
    //判断是否是emoji表情
    if ([emotionModel.type isEqualToString:@"1"]) {
        NSString *emojiStr = [emotionModel.code emoji];

        [self.textView replaceRange:self.textView.selectedTextRange withText:emojiStr];
        //此处不用insert方法
//        [self.textView insertText:emojiStr];
    }else if ([emotionModel.type isEqualToString:@"0"]) {
        //1.通过模型取出图片地址并读取图片
        UIImage *image = [UIImage imageNamed:emotionModel.imagePath];
        //2.初始化富文本的附件,并将图片赋值给附件
        NSTextAttachment *emotionAttach = [[NSTextAttachment alloc]init];
        emotionAttach.image = image;
        CGFloat lineHeight = self.textView.font.lineHeight;
        emotionAttach.bounds = CGRectMake(0, -3, lineHeight, lineHeight);
        //3.将附件赋给富文本字符串
        NSAttributedString *emotionAttr = [NSAttributedString attributedStringWithAttachment:emotionAttach];
        //4.读取textView本身的富文本字符串,因其不可变,转接后添加进去
        NSMutableAttributedString *originalAttr = [[NSMutableAttributedString alloc]initWithAttributedString:self.textView.attributedText];
        
        //获取光标的位置
        NSRange selectRange = self.textView.selectedRange;
        
        [originalAttr replaceCharactersInRange:selectRange withAttributedString:emotionAttr];
        
        //添加字体属性
        
        [originalAttr addAttribute:NSFontAttributeName value:self.textView.font range:NSMakeRange(0, originalAttr.length)];
        
        
        self.textView.attributedText = originalAttr;
        
        //改变光标的位置
        self.textView.selectedRange = NSMakeRange(selectRange.location + 1, 0);
        

    }else if (emotionModel.isDelelateBtn) {

        [self.textView deleteBackward];
    }
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
