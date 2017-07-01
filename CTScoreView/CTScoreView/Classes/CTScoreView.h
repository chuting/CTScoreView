//
//  CTScoreView.h
//  CTScoreView
//
//  Created by chuting on 2017/5/25.
//  Copyright © 2017年 chuting. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTScoreView : UIView



//分数 0-3 默认带动画效果
@property (nonatomic,assign) NSUInteger score;
//设置title数组
@property (nonatomic,copy,getter=getTitleArray) NSArray <NSString *>*titleArray;


/**
 设置分数

 @param score1 分数 0-3
 @param animation 是否带动画
 */
-(void)setScore:(NSUInteger)score1 animation:(BOOL)animation;

@end
