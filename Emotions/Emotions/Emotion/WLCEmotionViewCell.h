//
//  WLCEmotionViewCell.h
//  Emotions
//
//  Created by 王 on 16/3/3.
//  Copyright © 2016年 WLChopSticks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLCEmotionModel.h"

@class WLCEmotionViewCell;
@protocol emotionViewCellDelegate <NSObject>

-(void)emotionViewCell: (WLCEmotionViewCell *)emotionViewCell didClickEmotionButton: (UIButton *)emotionButton withEmotionModel: (WLCEmotionModel *)emotionModel;

@end

@interface WLCEmotionViewCell : UICollectionViewCell

@property (strong, nonatomic) WLCEmotionModel *emotionModel;

@property (weak, nonatomic) id<emotionViewCellDelegate> delegate;

@end
