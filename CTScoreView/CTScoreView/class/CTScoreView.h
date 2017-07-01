//
//  CTScoreView.h
//  CTScoreView
//
//  Created by chuting on 2017/5/25.
//  Copyright © 2017年 chuting. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTScoreView : UIView



//分数 0-3
@property (nonatomic,assign) NSUInteger score;
@property (nonatomic,copy,getter=getTitleArray) NSArray <NSString *>*titleArray;

-(void)setScore:(NSUInteger)score1 animation:(BOOL)animation;

@end
