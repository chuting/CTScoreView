//
//  CTScoreView.m
//  CTScoreView
//
//  Created by chuting on 2017/5/25.
//  Copyright © 2017年 chuting. All rights reserved.
//

#import "CTScoreView.h"



#define StarTag 1000
#define YellowStarTag 2000
#define FontWhiteColor [UIColor whiteColor]
#define FontTitle   [UIFont systemFontOfSize:18]
@interface CTScoreView ()
{
    UIView  *backView;
    UIView  *fireView;
    UIView  *starView;
    UIImageView  *redRobbinView;
    UILabel *lable;
    CGFloat scale ;
}

@end

@implementation CTScoreView
@synthesize score;
@synthesize titleArray;
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
//
//-(instancetype)init
//{
//    self = [super init];
//    if (!self) {
//        return nil;
//    }
//    [self configUIWithFrame:CGRectZero];
//    
//    return self;
//}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) {
        return nil;
    }
    
    [self configUIWithFrame:frame];
    
    return self;
    
}

-(void)configUIWithFrame:(CGRect)frame
{
    
    backView = [[UIView alloc]initWithFrame:frame];
    [self addSubview:backView];
    
    UIImage *image = [UIImage imageNamed:@"firework_0"];
    
    //烟花
    fireView = [[UIView alloc] init ];
    [backView addSubview:fireView];
    
    image = [UIImage imageNamed:@"red_robbin"];
    
    //红色丝带
    redRobbinView=[[UIImageView alloc]initWithImage:[image resizableImageWithCapInsets:UIEdgeInsetsMake(image.size.height/2, image.size.width/2-1, image.size.height/2, image.size.width/2-1)]];
    redRobbinView.userInteractionEnabled=YES;
    redRobbinView.tag = 10000;
    [backView addSubview:redRobbinView];
    
    [backView bringSubviewToFront:fireView];

    lable = [[UILabel alloc] init];
    lable.textAlignment = NSTextAlignmentCenter;
    lable.textColor = FontWhiteColor;
    lable.font = FontTitle;
    [redRobbinView addSubview:lable];
    
    
    CGFloat x = 0;
    
    starView = [[UIView alloc]initWithFrame:CGRectZero];
    [backView addSubview:starView];
    for (int i = 1 ; i < 4; i++) {
        
        for (NSInteger j = 0; j< 2; j++) {
            
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"star%d_un",i]];
            UIImage *image1 = [UIImage imageNamed:[NSString stringWithFormat:@"star%d",i]];
            UIImageView *starIMV = [[UIImageView alloc] init];
            [starIMV setImage:image];
            starIMV.tag = StarTag + i;
            [starView addSubview:starIMV];
            if (j == 1) {
                x = CGRectGetMaxX(starIMV.frame);
                starIMV.tag = YellowStarTag + i;
                [starIMV setImage:image1];
                starIMV.hidden = YES;
            }
        }
        
    }
    
    if (!CGRectEqualToRect(frame, CGRectZero)) {
        [self fitSize];
    }
    

}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [self fitSize];
}


-(void)fitSize
{
    CGRect frame = self.frame;
    
    UIImage *image = [UIImage imageNamed:@"firework_0"];
    image = [UIImage imageNamed:@"red_robbin"];
    if (frame.size.width > image.size.width) {
        frame.size.width = image.size.width;
    }
    scale = frame.size.width/image.size.width;
    image = [UIImage imageNamed:@"firework_0"];
    fireView.frame = CGRectMake(0, 0, frame.size.width, image.size.height * scale) ;
    image = [UIImage imageNamed:@"red_robbin"];
    redRobbinView.frame = CGRectMake(0, CGRectGetMaxY(fireView.frame)-3, CGRectGetWidth(self.frame), image.size.height*scale);
 
    lable.frame = CGRectMake(0, CGRectGetHeight(redRobbinView.frame)*0.3 , CGRectGetWidth(redRobbinView.frame), CGRectGetHeight(redRobbinView.frame)*0.7);
    lable.font = [UIFont systemFontOfSize:( (NSInteger)CGRectGetHeight(lable.frame)*0.5)];
    
    
    CGFloat x = 0;
    for (int i = 1 ; i < 4; i++) {
        
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"star%d_un",i]];
        UIImageView *starIMV = [starView viewWithTag: StarTag + i];
        UIImageView *yellowStarIMV = [starView viewWithTag: YellowStarTag + i];
        
        starIMV.frame = CGRectMake(x, 0, image.size.width*scale, image.size.height*scale);
        yellowStarIMV.frame = CGRectMake(x, 0, image.size.width*scale, image.size.height*scale);
        x = CGRectGetMaxX(starIMV.frame);
        if (i == 3) {
            starView.frame = CGRectMake( (CGRectGetWidth(redRobbinView.frame) -  CGRectGetMaxX(starIMV.frame)) /2 + CGRectGetMinX(redRobbinView.frame) , CGRectGetMinY(redRobbinView.frame)-CGRectGetHeight(starIMV.frame)/3*2.2, CGRectGetMaxX(starIMV.frame), CGRectGetHeight(starIMV.frame));
//            starView.backgroundColor = [UIColor grayColor];
        }
        
    }
    
    backView.frame = CGRectMake(0 ,0, CGRectGetWidth(self.frame) , CGRectGetMaxY(redRobbinView.frame));
    frame.size.height = CGRectGetHeight(backView.frame);
    self.frame = frame;
    
}



- (void)makeFireworksDisplayWithAnimation:(BOOL)animation {
    UIImage *image = [UIImage imageNamed:@"firework_0"];
    for (NSInteger i = 0; i < 2; i++) {
        //烟花筒
        UIImageView *fireworksImageView  = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"firework_%zd",i]]];
        fireworksImageView.frame = CGRectMake( i==0?0 : CGRectGetWidth(fireView.frame)-image.size.width*scale, 0, image.size.width*scale, image.size.height*scale);
        [fireView addSubview:fireworksImageView];
        
        CGPoint firePositon =  CGPointMake(i ==0 ? 39*scale: CGRectGetWidth(fireworksImageView.frame)-39*scale,CGRectGetHeight(fireworksImageView.frame) -  26*scale);
        
        
        //烟花丝带
        CGRect frame = CGRectZero;
        frame.origin = CGPointMake(CGRectGetMinX(fireworksImageView.frame)+firePositon.x, CGRectGetMinY(fireworksImageView.frame)+firePositon.y);
        frame.size = CGSizeMake(10, 10);
        image =  [UIImage imageNamed:[NSString stringWithFormat:@"firework_robbin_%zd",i]];
        UIImageView *fireworkRibbonimageView=[[UIImageView alloc]initWithImage:image];
        fireworkRibbonimageView.userInteractionEnabled=YES;
        fireworkRibbonimageView.frame = frame;
        fireworkRibbonimageView.alpha = 0;
        [fireView addSubview:fireworkRibbonimageView];
        [fireView insertSubview:fireworkRibbonimageView atIndex:0];
        
        if (!animation) {
            fireworkRibbonimageView.alpha = 1;
            fireworkRibbonimageView.frame = fireworksImageView.frame;
        }else
        {
            //下面为烟花效果
            CAEmitterLayer *fireworksEmitter = [CAEmitterLayer layer];
            fireworksEmitter.emitterPosition =  firePositon;
            fireworksEmitter.emitterSize = CGSizeMake(10, 10);
            fireworksEmitter.emitterMode = kCAEmitterLayerLine;
            fireworksEmitter.emitterShape = kCAEmitterLayerRectangle;
            fireworksEmitter.renderMode = kCAEmitterLayerBackToFront;
            fireworksEmitter.seed = (arc4random()%100)+1;
            [fireworksImageView.layer addSublayer:fireworksEmitter];
            
            NSMutableArray *cellArray = [[NSMutableArray alloc]init];
            for (NSInteger j = 1; j < 9; j++) {
                
                CAEmitterCell* spark = [CAEmitterCell emitterCell];
                spark.birthRate = 5;
                spark.velocity = 200;
                spark.emissionRange = M_PI/2;
                if (i == 0) {
                    spark.emissionLongitude = - M_PI*(1/2.0-1/5.5);
                }else
                {
                    spark.emissionLongitude = - M_PI*(1/5.5 + 1/2.0) ;
                }
                spark.spinRange = M_PI * 2;
                spark.yAcceleration = 90;
                spark.lifetime = 6;
                spark.contents = (id) [[UIImage imageNamed:[NSString stringWithFormat:@"emitter_%zd",j]] CGImage];
                [cellArray addObject:spark];
                spark.scale = 0.2;
                if (j>6) {
                    spark.scale = 0.3;
                    spark.birthRate = 1;
                }
            }
            fireworksEmitter.emitterCells = [cellArray copy];
            
            [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseOut   animations:^{
                fireworkRibbonimageView.alpha = 1;
                fireworkRibbonimageView.frame = fireworksImageView.frame;
            } completion:^(BOOL finished) {
                fireworksEmitter.birthRate = 0;
            }];
            
        }
        
    }
}


#pragma mark - 设置分数
-(void)setScore:(NSUInteger)score1
{
    [self setScore:score1 animation:YES];
}


-(void)setScore:(NSUInteger)score1 animation:(BOOL)animation
{
    NSAssert((score1>=0&&score1<=3), @"分数不在指定范围内");
    score = score1>3?3:score1;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self setScoreWithAnimation:animation];
    });
}


-(void)setScoreWithAnimation:(BOOL)animation
{
    
    if (score>2) {
        [self makeFireworksDisplayWithAnimation:animation];
    }else
    {
        [fireView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperview];
        }];
    }
    
    for (NSInteger i = 0; i<4; i++) {
        
        NSInteger j = i;
        if (i == 2) {
            j =3;
        }
        if (i == 3) {
            j = 2;
        }
        
        UIImageView *yellowStarImageView = [starView viewWithTag:YellowStarTag + j];
        if (i <= score) {
            yellowStarImageView.hidden = NO;
            
            if (animation) {
                yellowStarImageView.transform = CGAffineTransformMakeScale(0.8, 0.8);
                [UIView animateWithDuration:0.2 delay:j*0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    yellowStarImageView.transform = CGAffineTransformIdentity;
                } completion:^(BOOL finished) {
                    
                }];
            }
            
        }else
        {
            yellowStarImageView.hidden = YES;
        }
    }
    
    lable.text =self.titleArray[score];
}

-(NSArray *)getTitleArray
{
    if (titleArray) {
        return titleArray;
    }
    return  @[@"哎呀，失败了",@"再接再厉",@"棒棒哒",@"完美过关"];
}


@end
