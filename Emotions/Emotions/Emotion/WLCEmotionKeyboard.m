//
//  WLCEmotionKeyboard.m
//  Emotions
//
//  Created by 王 on 16/3/3.
//  Copyright © 2016年 WLChopSticks. All rights reserved.
//

#import "WLCEmotionKeyboard.h"
#import "WLCEmotionViewCell.h"
#import "WLCEmotionLoad.h"
#import "WLCEmotionGroup.h"
#import "WLCEmotionTipView.h"
#import "Masonry.h"

#define ID @"emotionCell"
#define TOOLBAR_HEIGHT 30

@interface WLCEmotionKeyboard ()<UICollectionViewDataSource, UICollectionViewDelegate,emotionViewCellDelegate,UIGestureRecognizerDelegate>

@property (weak, nonatomic) UIToolbar *toolBar;
@property (weak, nonatomic) UICollectionView *emotionCollectionView;
@property (strong, nonatomic) NSArray *emotionArray;


@property (strong, nonatomic) WLCEmotionTipView *tipView;
@property (strong, nonatomic) NSMutableArray *emotionViewCellArray;

@end

@implementation WLCEmotionKeyboard

-(instancetype)initWithFrame:(CGRect)frame {
    //键盘frame设置
    CGRect rect = CGRectMake(0, 0, 300, 220);
    if (self = [super initWithFrame:rect]) {
        
        //加载数据
        WLCEmotionLoad *emotionLoad = [[WLCEmotionLoad alloc]init];
        self.emotionArray = [emotionLoad loadEmotionFile];
        
        
        //布局
        [self decorateUI];
        
        //添加长按手势
        UILongPressGestureRecognizer *gesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressGestureClicking:)];
        gesture.delegate = self;
        [self addGestureRecognizer:gesture];
        
        
    }
    
    return self;
}





#pragma -mark 布局
-(void)decorateUI {
    
    
    //设置toolbar
    UIToolbar *toolBar = [[UIToolbar alloc]init];
    self.toolBar = toolBar;
    [self toolBarDecorate];
    [self addSubview:toolBar];
    
    //设置表情的collectionView
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    CGFloat itemW = [UIScreen mainScreen].bounds.size.width / 7;
    layout.itemSize = CGSizeMake(itemW, itemW);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    CGFloat margin = (self.bounds.size.height - TOOLBAR_HEIGHT - 3 * itemW) / 4.00001;
    layout.sectionInset = UIEdgeInsetsMake(margin, 0, margin, 0);
    
    UICollectionView *emotionCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    self.emotionCollectionView = emotionCollectionView;
    emotionCollectionView.dataSource = self;
    emotionCollectionView.delegate = self;
    emotionCollectionView.pagingEnabled = YES;
    
    emotionCollectionView.backgroundColor = [UIColor whiteColor];
    
    [emotionCollectionView registerClass:[WLCEmotionViewCell class] forCellWithReuseIdentifier:ID];
    [self addSubview:emotionCollectionView];
    
    
    
    //约束
    //toolBar约束
    [toolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(TOOLBAR_HEIGHT);
    }];
    
    //表情的collectionView约束
    [emotionCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(toolBar.mas_top);
    }];
    
}

//toolbar布局
-(void)toolBarDecorate {
    NSMutableArray *itemArrM = [NSMutableArray array];
    
    self.toolBar.tintColor = [UIColor lightGrayColor];
    
    NSInteger typeIndex = WLCEmotionKeyboardTypeDefault;
    for (int i = 0; i < self.emotionArray.count; i++) {
        WLCEmotionGroup *emotionModel = self.emotionArray[i];
        UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:emotionModel.group_name_cn style:UIBarButtonItemStylePlain target:self action:@selector(toolBarButtonClicking:)];
        
        item.tag = typeIndex;
        typeIndex++;
        
        [itemArrM addObject:item];
        //添加弹簧
        UIBarButtonItem *bounceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        [itemArrM addObject:bounceItem];
    }

    //移除最后添加的弹簧
    [itemArrM removeLastObject];
    
    self.toolBar.items = itemArrM;
}


#pragma -mark toolBar点击方法
-(void)toolBarButtonClicking: (UIBarButtonItem *)sender {
    //点击toolbar滚动到相应的表情首页
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:sender.tag];
    [self.emotionCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
}


#pragma -mark 表情collectionView数据源代理方法
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.emotionArray.count;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    WLCEmotionGroup *emotionModel = self.emotionArray[section];
    return emotionModel.emoticons.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    WLCEmotionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    WLCEmotionGroup *emotionGroup = self.emotionArray[indexPath.section];
    WLCEmotionModel *emotionModel = emotionGroup.emoticons[indexPath.item];
    cell.emotionModel = emotionModel;
    
    cell.delegate = self;
    

    
    [self.emotionViewCellArray addObject:cell];
//        cell.backgroundColor = indexPath.item % 2 == 0 ? [UIColor redColor] : [UIColor yellowColor];
    return cell;
}


#pragma -mark 点击表情按钮的代理方法
-(void)emotionViewCell:(WLCEmotionViewCell *)emotionViewCell didClickEmotionButton:(UIButton *)emotionButton withEmotionModel:(WLCEmotionModel *)emotionModel {
    

    
    //再传一层
    if ([self.delegate respondsToSelector:@selector(emotionKeyboarView:selectEmotion:)]) {
        [self.delegate emotionKeyboarView:self selectEmotion:emotionModel];
    }
}

#pragma -mark 长按手势点击事件
-(void)longPressGestureClicking: (UIGestureRecognizer *)gesture {
    
    CGPoint point = [gesture locationInView:self];

    //判断条件是frame,所以想让图片显示在屏幕上 需要根据contentOffset更改
    point.x += self.emotionCollectionView.contentOffset.x;

    WLCEmotionViewCell *cellTem = nil;
    for (WLCEmotionViewCell *cell in self.emotionViewCellArray) {

        //判断点击的位置是在哪个表情cell中
        BOOL isInposition = CGRectContainsPoint(cell.frame, point);
        if (isInposition) {
            [self addSubview:self.tipView];

            CGFloat tipViewX = cell.frame.origin.x - self.emotionCollectionView.contentOffset.x;
            CGFloat tipViewY = cell.frame.origin.y - cell.frame.size.height;
            CGFloat tipViewW = cell.frame.size.width;
            CGFloat tipViewH = cell.frame.size.height * 1.5;
            self.tipView.frame = CGRectMake(tipViewX, tipViewY, tipViewW, tipViewH);
            self.tipView.emotionModel = cell.emotionModel;
            
            cellTem = cell;
            
            break;
        }
    }
    
    //松手后将tipView移除
    if (gesture.state == UIGestureRecognizerStateEnded || gesture.state == UIGestureRecognizerStateCancelled) {
        
        [self.tipView removeFromSuperview];
        
        //再传一层
        if ([self.delegate respondsToSelector:@selector(emotionKeyboarView:selectEmotion:)]) {
            [self.delegate emotionKeyboarView:self selectEmotion:cellTem.emotionModel];
        }
    }
    
}




//懒加载
-(NSArray *)emotionArray {
    if (_emotionArray == nil) {
        _emotionArray = [NSArray array];
    }
    return _emotionArray;
}
-(NSMutableArray *)emotionViewCellArray {
    if (_emotionViewCellArray == nil) {
        _emotionViewCellArray = [NSMutableArray array];
    }
    return _emotionViewCellArray;
}
//设置表情的tipView
-(WLCEmotionTipView *)tipView {
    if (_tipView == nil) {
        _tipView = [[WLCEmotionTipView alloc]init];
    }
    return _tipView;
}



@end
