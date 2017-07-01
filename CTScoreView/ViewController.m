//
//  ViewController.m
//  CTScoreView
//
//  Created by zhutc on 2017/7/1.
//  Copyright © 2017年 zhuoApp. All rights reserved.
//

#import "ViewController.h"
#import "CTScoreView.h"
@interface ViewController ()
{
    CTScoreView *scoreView ;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 80, 200, 300)];
//    imageView.backgroundColor = [UIColor redColor];
    [self.view addSubview:imageView];
    
    scoreView = [[CTScoreView alloc]init];
    [self.view addSubview:scoreView];

    scoreView.frame = CGRectMake(60, 80, 200, 300);
    
    
    for (NSInteger i = 0; i < 4; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.frame = CGRectMake(i*80, 300, 60, 40);
        button.tag = i;
        [button setTitle:[NSString stringWithFormat:@"%zd分",i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];

        
    }
}


-(void)buttonClick:(UIButton *)button
{
//    [scoreView setScore:3 animation:YES];
    scoreView.score = button.tag;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
