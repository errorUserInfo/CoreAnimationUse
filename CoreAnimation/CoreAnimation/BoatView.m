//
//  BoatView.m
//  Earth
//
//  Created by 温天浩 on 16/8/22.
//  Copyright © 2016年 温天浩. All rights reserved.
//

#import "BoatView.h"
#import "YYImage.h"

@interface BoatView ()

/**
 *  浪
 */
@property(nonatomic,strong) UIImageView *waterImageView1;
@property(nonatomic,strong) UIImageView *waterImageView2;
@property(nonatomic,strong) UIImageView *waterImageView3;
@property(nonatomic,strong) UIImageView *waterImageView4;

/**
 *  烟花
 */
@property(nonatomic,strong) YYAnimatedImageView *fireWorkImageView1;
@property(nonatomic,strong) YYAnimatedImageView *heartImageView1;

@property(nonatomic,strong) YYAnimatedImageView *fireWorkImageView2;
@property(nonatomic,strong) YYAnimatedImageView *heartImageView2;

/**
 *  游艇和底部的浪花
 */
@property(nonatomic,strong) UIView *shipContainerView;
@property(nonatomic,strong) UIImageView *shipImageView;
@property(nonatomic,strong) UIImageView *boatShadowImageView;
@property(nonatomic,strong) YYAnimatedImageView *waveImageView;

@property(nonatomic,strong) NSMutableArray *waveImages;
@property(nonatomic,strong) NSMutableArray *fireWorkImages;
@property(nonatomic,strong) NSMutableArray *heartImages;

@end

static CGFloat radius = M_PI/10.0;

@implementation BoatView

- (NSMutableArray *)waveImages{
    if (!_waveImages) {
        self.waveImages = [[NSMutableArray alloc] init];
        for (int i = 1; i < 9; i++) {
            NSString *imageName = [NSString stringWithFormat:@"wave%d",i];
            NSString *filePath = [[NSBundle mainBundle] pathForResource:imageName ofType:@"png"];
      
            if (filePath) {
                [self.waveImages addObject:filePath];
            }
        }
    }
    return _waveImages;
}

- (NSMutableArray *)fireWorkImages{
    if (!_fireWorkImages) {
        self.fireWorkImages = [[NSMutableArray alloc] init];
        for (int i = 1; i < 12; i++) {
            NSString *imageName = [NSString stringWithFormat:@"boat_firework%d",i];
            NSString *filePath = [[NSBundle mainBundle] pathForResource:imageName ofType:@"png"];
            
            if (filePath) {
                [self.fireWorkImages addObject:filePath];
            }
        }
    }
    return _fireWorkImages;
}

- (NSMutableArray *)heartImages{
    if (!_heartImages) {
        self.heartImages = [[NSMutableArray alloc] init];
        for (int i = 1; i < 4; i++) {
            NSString *imageName = [NSString stringWithFormat:@"heart%d",i];
            NSString *filePath = [[NSBundle mainBundle] pathForResource:imageName ofType:@"png"];
            
            if (filePath) {
                [self.heartImages addObject:filePath];
            }
        }
    }
    return _heartImages;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        /**
         波浪的元素
         */
        self.waterImageView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sea_wave.png"]];
        CGFloat waterHeight = [self heigtForImage:self.waterImageView1.image]+20;
        self.waterImageView1.width = SCREEN_WIDTH;
        self.waterImageView1.height = waterHeight;
        self.waterImageView1.bottom = self.bottom;
        self.waterImageView1.left = self.left;
        [self addSubview:self.waterImageView1];
        
        self.waterImageView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sea_wave.png"]];
        self.waterImageView2.frame = self.waterImageView1.frame;
        [self addSubview:self.waterImageView2];
        
        self.waterImageView3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sea_wave.png"]];
        self.waterImageView3.frame = self.waterImageView1.frame;
        [self addSubview:self.waterImageView3];
        
        self.waterImageView4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sea_wave.png"]];
        self.waterImageView4.frame = self.waterImageView1.frame;
        [self addSubview:self.waterImageView4];
        
        /**
         烟花的元素
         */
        self.fireWorkImageView1 = [[YYAnimatedImageView alloc] init];
        self.fireWorkImageView1.image = [[YYFrameImage alloc]initWithImagePaths:self.fireWorkImages oneFrameDuration:0.1 loopCount:0];
        self.fireWorkImageView1.autoPlayAnimatedImage = NO;
        self.fireWorkImageView1.hidden = YES;
        [self addSubview:self.fireWorkImageView1];
        
        self.heartImageView1 = [[YYAnimatedImageView alloc] init];
        self.heartImageView1.image = [[YYFrameImage alloc]initWithImagePaths:self.heartImages oneFrameDuration:0.15 loopCount:0];
        self.heartImageView1.width = 156;
        self.heartImageView1.height = 130;
        self.heartImageView1.hidden = YES;
        
        
        self.fireWorkImageView2 = [[YYAnimatedImageView alloc] init];
        self.fireWorkImageView2.image = [[YYFrameImage alloc]initWithImagePaths:self.fireWorkImages oneFrameDuration:0.1 loopCount:0];
        self.fireWorkImageView2.hidden = YES;
        self.fireWorkImageView2.autoPlayAnimatedImage = NO;
        [self addSubview:self.fireWorkImageView2];
        
        self.heartImageView2 = [[YYAnimatedImageView alloc] init];
        self.heartImageView2.image = [[YYFrameImage alloc]initWithImagePaths:self.heartImages oneFrameDuration:0.15 loopCount:0];
        self.heartImageView2.hidden = YES;
        [self addSubview:self.heartImageView2];
        
//        self.fireWorkImageView1.transform = CGAffineTransformRotate(self.fireWorkImageView2.transform, -(18.0 / 180.0 * M_PI));
        self.fireWorkImageView2.transform = CGAffineTransformRotate(self.fireWorkImageView2.transform, M_LN2 - (M_PI/20.0));
        self.heartImageView2.transform = CGAffineTransformRotate(self.heartImageView2.transform, M_LN2 - radius);
        
        /**
         轮船的元素
         */
        self.shipContainerView = [[UIView alloc] init];
        self.shipContainerView.width = SCREEN_WIDTH;
        self.shipContainerView.height = self.waterImageView1.height + 50;
        self.shipContainerView.top = self.waterImageView1.top - 10;
        self.shipContainerView.left = 0;
        [self addSubview:self.shipContainerView];
        
        self.shipImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ship.png"]];
        self.shipImageView.width = SCREEN_WIDTH * 0.9;
        self.shipImageView.height = SCREEN_WIDTH * 0.9 * 0.4;
        self.shipImageView.left = SCREEN_WIDTH * 0.9 * 0.05;
        self.shipImageView.top = 0;
        [self.shipContainerView addSubview:self.shipImageView];
        
        self.boatShadowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"boat_shadow.png"]];
        self.boatShadowImageView.width = SCREEN_WIDTH * 0.7;
        self.boatShadowImageView.height = SCREEN_WIDTH * 0.25;
        self.boatShadowImageView.top = self.shipImageView.bottom;
        self.boatShadowImageView.centerX = self.shipImageView.centerX;
        self.boatShadowImageView.alpha = 0;
        [self.shipContainerView addSubview:self.boatShadowImageView];
        
        self.waveImageView = [[YYAnimatedImageView alloc] init];
        self.waveImageView.width = SCREEN_WIDTH * 0.56;
        self.waveImageView.height = SCREEN_WIDTH * 0.56 * 0.28 + 1;
        self.waveImageView.bottom = self.shipImageView.bottom ;
        self.waveImageView.left = self.shipImageView.left - 30;
        self.waveImageView.image = [[YYFrameImage alloc]initWithImagePaths:self.waveImages oneFrameDuration:0.1 loopCount:0];
        
        
        [self.fireWorkImageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@110);
            make.centerX.equalTo(self);
            make.width.equalTo(@120);
            make.height.equalTo(@144);
        }];
        
        [self.fireWorkImageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.fireWorkImageView1).offset(30);
            make.left.equalTo(self.fireWorkImageView1.mas_right).offset(-80);
            make.width.equalTo(@90);
            make.height.equalTo(@108);
        }];
        
        [self.heartImageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.height.equalTo(@92);
            make.width.equalTo(@110);
            make.center.equalTo(self.fireWorkImageView2);
        }];
        
        self.alpha = 0.0;
//        self.waveImageView.transform = CGAffineTransformRotate(self.waveImageView.transform, - radius * 4);
    }
    return self;
}

/**
 *  烟花动画
 */
- (void)startFireWorkAnimation{
    
    self.fireWorkImageView1.hidden = NO;
    [self.fireWorkImageView1 startAnimating];
    
    [self addSubview:self.heartImageView1];
    
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    
    CAAnimation *animation1 = [self frontAnimationDuration:1.0 beginTime:0.0 fromPoint:CGPointMake(self.fireWorkImageView1.centerX, self.fireWorkImageView1.centerY +100) endPoint:CGPointMake(self.fireWorkImageView1.centerX , self.fireWorkImageView1.centerY)];
    
    CAAnimation *animation2 = [self animaionFromScale:0.5 toScale:1.0 begainTime:0.0 duration:1.0];
    
    CAAnimation *animation3 = [self animationFromOpacity:0.2 toOpacity:1.0 begainTime:0.0 duration:1.0];
    
    groupAnimation.animations = @[animation1,animation2,animation3];
    groupAnimation.duration = 1.0;
    groupAnimation.repeatCount = 1;
    groupAnimation.fillMode = kCAFillModeForwards;
    groupAnimation.removedOnCompletion = NO;
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^(void){
        self.heartImageView1.hidden = NO;
        [self.heartImageView1.layer addAnimation:groupAnimation forKey:nil];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^(void){
            self.fireWorkImageView1.hidden = YES;
            self.fireWorkImageView2.hidden = NO;
            [self.fireWorkImageView2 startAnimating];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^(void){
                self.fireWorkImageView2.hidden = YES;
                self.heartImageView2.hidden = NO;
                
            });
        });

    });
    
    
}

/**
 *  游轮底部浪花
 */
- (void)startBoatWaveAniamtion{
    
    [self.shipContainerView addSubview:self.waveImageView];
}

/**
 *  游轮动画
 */
- (void)startShipAnimation{
    //游艇位移的动画
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    
    CAAnimation *animation1 = [self frontAnimationDuration:3.0 beginTime:0.0 fromPoint:CGPointMake(-self.shipContainerView.centerX, self.shipContainerView.centerY - 80) endPoint:CGPointMake(self.shipContainerView.centerX - 20, self.shipContainerView.centerY + 30)];
    animation1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    CAAnimation *animation2 = [self frontAnimationDuration:2.0 beginTime:3.0 fromPoint:CGPointMake(self.shipContainerView.centerX - 20, self.shipContainerView.centerY + 30) endPoint:CGPointMake(self.shipContainerView.centerX + 20, self.shipContainerView.centerY + 30)];
    CAAnimation *animation3 = [self frontAnimationDuration:3.0 beginTime:5.0 fromPoint:CGPointMake(self.shipContainerView.centerX + 20, self.shipContainerView.centerY + 30) endPoint:CGPointMake(self.width + self.shipContainerView.centerX + 150, self.shipContainerView.centerY + 110)];
    animation3.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    CAAnimation *animation4 = [self animaionFromScale:0.9 toScale:1.0 begainTime:0.0 duration:3.0];
//    CAAnimation *aniamtion5 = [self animaionFromScale:1.0 toScale:1.1 begainTime:3.0 duration:2.0];
    CAAnimation *animation6 = [self animaionFromScale:1.0 toScale:1.4 begainTime:5.0 duration:3.0];
    
    groupAnimation.animations = @[animation1,animation2,animation3,animation4,animation6];
    groupAnimation.duration = 8.0;
    groupAnimation.repeatCount = 1;
    groupAnimation.fillMode = kCAFillModeForwards;
    groupAnimation.removedOnCompletion = NO;
    groupAnimation.delegate = self;
    [self.shipContainerView.layer addAnimation:groupAnimation forKey:nil];
    
    //透明度动画、阴影放大
    [UIView animateWithDuration:3.0 animations:^{
        self.boatShadowImageView.alpha = 0.2;
    } completion:^(BOOL finished) {
        [self startFireWorkAnimation];
        [UIView animateWithDuration:2.0 animations:^{
            self.boatShadowImageView.alpha = 0.3;
        } completion:^(BOOL finished){
            [UIView animateWithDuration:3.0 animations:^{
                self.boatShadowImageView.transform = CGAffineTransformMakeScale(1.6, 1.6);
            }];
        }];
    }];
    
}

//位移动画
- (CAAnimation *)frontAnimationDuration:(CGFloat)duration beginTime:(CGFloat)begainTime fromPoint:(CGPoint)fromPoint endPoint:(CGPoint)endPoint{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.fromValue = [NSValue valueWithCGPoint:fromPoint];
    animation.toValue = [NSValue valueWithCGPoint:endPoint];
    animation.repeatCount = 1;
    animation.duration = duration;
    animation.beginTime = begainTime;
//    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    return animation;
}

//从小到大动画
- (CAAnimation *)animaionFromScale:(CGFloat)fromScale toScale:(CGFloat)toScale begainTime:(CGFloat)begainTime duration:(CGFloat)duration{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.fromValue = @(fromScale);
    animation.toValue = @(toScale);
    animation.repeatCount = 1;
    animation.duration = duration;
    animation.beginTime = begainTime;
    return animation;
}

//透明度动画
- (CAAnimation *)animationFromOpacity:(CGFloat)fromOpacity toOpacity:(CGFloat)toOpacity begainTime:(CGFloat)begainTime duration:(CGFloat)duration{
    CABasicAnimation *animaiton = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animaiton.fromValue = @(fromOpacity);
    animaiton.toValue = @(toOpacity);
    animaiton.repeatCount = 1;
    animaiton.beginTime = begainTime;
    animaiton.duration = duration;
    return animaiton;
}

/**
 *  从左边出来的海浪
 */
- (void)startSeaWaveAnimationFromLeft{
    CGFloat width = self.bounds.size.width;
    [self.waterImageView1.layer addAnimation:[self animationWithFromX:0 toX:width duration:2.0] forKey:nil];
    [self.waterImageView2.layer addAnimation:[self animationWithFromX:-width toX:0 duration:2.0] forKey:nil];
}

/**
 *  从右边出来的海浪
 */
- (void)startSeaWaveAnimationFromRight{
    CGFloat width = self.bounds.size.width;
    [self.waterImageView3.layer addAnimation:[self animationWithFromX:width toX:0 duration:2.0] forKey:nil];
    [self.waterImageView4.layer addAnimation:[self animationWithFromX:0 toX:-width duration:2.0] forKey:nil];
}

- (CAAnimation *)animationWithFromX:(NSInteger)fromX toX:(NSInteger)toX duration:(NSInteger)duration {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    animation.fromValue = @(fromX);
    animation.toValue = @(toX);
    animation.duration = duration;
    animation.repeatCount = FLT_MAX;
    animation.removedOnCompletion = NO;
    return animation;
}

/**
 *  根据屏幕宽度获取图片的高度
 */
- (CGFloat)heigtForImage:(UIImage *)image {
    CGFloat height = image.size.height /(image.size.width/SCREEN_WIDTH);
    return height;
}

#pragma mark - Public Method

- (void)startAnimation{
    [UIView animateWithDuration:1.0 animations:^{
        self.alpha = 1.0;
    }];
    [self startSeaWaveAnimationFromLeft];
    [self startSeaWaveAnimationFromRight];
    [self startShipAnimation];
    [self startBoatWaveAniamtion];
//    [self startFireWorkAnimation];
}

#pragma mark - AnimationDelegate

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if (flag) {
        [UIView animateWithDuration:0.5 animations:^{
            self.alpha = 0.0;
        } completion:^(BOOL finished) {
            [self removeAllAnimation];
            [self.delegate animationStopWithBoatView:self];
        }];
    }
}

- (void)removeAllAnimation{
    self.heartImageView1.image = nil;//爱心桃1
    self.heartImageView2.image = nil;//爱心桃2
    self.waveImageView.image = nil;//浪花
    /**
     *  海浪
     */
    [self.waterImageView1.layer removeAllAnimations];
    [self.waterImageView2.layer removeAllAnimations];
    [self.waterImageView1.layer removeAllAnimations];
    [self.waterImageView1.layer removeAllAnimations];
    /**
     *  轮船移动
     */
    [self.shipContainerView.layer removeAllAnimations];
    
}

@end
