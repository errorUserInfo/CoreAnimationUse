//
//  ViewController.m
//  CoreAnimation
//
//  Created by 天浩 on 16/8/19.
//  Copyright © 2016年 天浩. All rights reserved.
//

#import "ViewController.h"
#import "BoatView.h"
#import "CarView.h"
#import "EarthView.h"

@interface ViewController ()<BoatViewDelegate,CarViewDelegate,EarthViewDelegate>

@property(nonatomic,strong)BoatView *shipView;
@property(nonatomic,strong)CarView *carView;
@property(nonatomic,strong)EarthView *earthView;
@property(nonatomic,strong)NSMutableArray *countainer;
@property(nonatomic,assign)BOOL isAnimation;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isAnimation = YES;
    
    self.countainer = [NSMutableArray array];
    
    UIButton *btn1 = [UIButton buttonWithTitle:@"游艇" fontSize:20 textColor:[UIColor blackColor] backGroundColor:[UIColor orangeColor]];
    btn1.tag = 1;
    [btn1 addTarget:self action:@selector(startAnimationWithBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [UIButton buttonWithTitle:@"汽车" fontSize:20 textColor:[UIColor blackColor] backGroundColor:[UIColor orangeColor]];
    btn2.tag = 2;
    [btn2 addTarget:self action:@selector(startAnimationWithBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    UIButton *btn3 = [UIButton buttonWithTitle:@"地球" fontSize:20 textColor:[UIColor blackColor] backGroundColor:[UIColor orangeColor]];
    btn3.tag = 3;
    [btn3 addTarget:self action:@selector(startAnimationWithBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn3];
    
    [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(@40);
    }];
    
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(btn2.mas_left).offset(-20);
        make.top.equalTo(btn2);
    }];
    
    [btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(btn2.mas_right).offset(20);
        make.top.equalTo(btn1);
    }];
    
}

#pragma mark - Touch Btn

- (void)startAnimationWithBtn:(UIButton *)sender{//点击开始动画
    [self.countainer addObject:[NSNumber numberWithInteger:sender.tag]];
    [self startAnimation];
}

#pragma mark - Methond

- (void)startAnimation{
    if (self.countainer.count > 0 && self.isAnimation == YES) {
        NSInteger tag = [[self.countainer objectAtIndex:0] integerValue];
        if (tag == 1) {//开始游轮动画
            self.shipView = [[BoatView alloc] initWithFrame:self.view.bounds];
            self.shipView.userInteractionEnabled = NO;
            self.shipView.delegate = self;
            [self.view addSubview:self.shipView];
            [self.shipView startAnimation];
        }else if (tag == 2){//开始汽车动画
            self.carView = [[CarView alloc] initWithFrame:self.view.bounds];
            self.carView.userInteractionEnabled = NO;
            self.carView.delegate = self;
            [self.view addSubview:self.carView];
            [self.carView startAnimation];
        }else{//开始地球动画
            self.earthView = [[EarthView alloc] initWithFrame:self.view.bounds];
            self.earthView.userInteractionEnabled = NO;
            self.earthView.delegate = self;
            [self.view addSubview:self.earthView];
            [self.earthView startAniamtion];
        }
    }
    self.isAnimation = NO;
}

/********
 以下是动画停止执行的操作
********/

- (void)animationStop{
    if (self.countainer.count > 0) {
        self.isAnimation = YES;
        [self startAnimation];
        [self.countainer removeObjectAtIndex:0];
    }
}

#pragma mark - BoatViewDelegate

- (void)animationStopWithBoatView:(BoatView *)boatView{
    [self.shipView removeAllAnimation];
    [self.shipView removeFromSuperview];
    self.shipView = nil;
    [self animationStop];
}

#pragma mark - CarViewDelegate

- (void)animationFinishWithFerrariCarView:(CarView *)carView{
    [self.carView removeAllAnimation];
    [self.carView removeFromSuperview];
    self.carView = nil;
    [self animationStop];
}

#pragma mark - EarthViewDelegate

- (void)animationFinishWithEarthView:(EarthView *)earthView{
    [self.earthView removeAllAnimation];
    [self.earthView removeFromSuperview];
    self.earthView = nil;
    [self animationStop];
}

@end
