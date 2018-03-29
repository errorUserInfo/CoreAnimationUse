//
//  EarthView.m
//  Earth
//
//  Created by 温天浩 on 16/8/20.
//  Copyright © 2016年 温天浩. All rights reserved.
//

#import "EarthView.h"

@interface EarthView ()

/**
 *  地球元素
 */
@property(nonatomic,strong) UIImageView *backgroundImageView;
@property(nonatomic,strong) UIImageView *earthImageView;//地球

@property(nonatomic,strong) UIImageView *balloon1;//顶部的气球
@property(nonatomic,strong) UIImageView *balloon2;//中间的气球
@property(nonatomic,strong) UIImageView *balloon3;//底部的气球

@property(nonatomic,strong) UIView *cloud1ContainerView;//底部云的承载
@property(nonatomic,strong) UIImageView *cloud1;//底部的云

@property(nonatomic,strong) UIView *cloud2ContainerView;//中间云的承载
@property(nonatomic,strong) UIImageView *cloud2;//中间的云

@property(nonatomic,strong) UIView *cloud3ContainerView;//底部云的承载
@property(nonatomic,strong) UIImageView *cloud3;//顶部的云

@property(nonatomic,strong) UIView *airPlaneContainerView;
@property(nonatomic,strong) UIImageView *airPlane;

/**
 *  文字元素
 */
@property(nonatomic,strong) UIView *grandeView;//遮罩层
@property(nonatomic,strong) UIView *wordContainerView;//文字容器
@property(nonatomic,strong) UIImageView *leftWingImageView;//左翅膀
@property(nonatomic,strong) UIImageView *rightWingImageView;//右翅膀
@property(nonatomic,strong) UIImageView *sunImageView;//太阳
@property(nonatomic,strong) UIImageView *wordImageView;//文字
@property(nonatomic,strong) UIImageView *leftBalloonImageView;//左气球
@property(nonatomic,strong) UIImageView *leftGooseImageView;//左大雁
@property(nonatomic,strong) UIImageView *rightBalloonImageView;//右气球
@property(nonatomic,strong) UIImageView *rightGooseImageView;//右大雁

@property(nonatomic,assign) CGFloat radiusDistance;//距离差

@end

static CGFloat radius = M_PI/180;
static CGFloat FPS = 16.0/360.0;

@implementation EarthView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.radiusDistance = radius * 20;
        //背景
        self.backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sky.png"]];
        self.backgroundImageView.alpha = 0.0;
        [self addSubview:self.backgroundImageView];
        
        self.cloud1ContainerView = [[UIView alloc] init];
        [self addSubview:self.cloud1ContainerView];
        
        self.cloud1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cloud2.png"]];
        [self.cloud1ContainerView addSubview:self.cloud1];
        
        self.balloon1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"balloon.png"]];
        [self addSubview:self.balloon1];

        self.balloon2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"balloon.png"]];
        [self addSubview:self.balloon2];
        
        self.earthImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"earth.png"]];
        CGFloat earthHeight = [self heigtForImage:self.earthImageView.image];
        [self addSubview:self.earthImageView];

        self.balloon3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"balloon.png"]];
        [self addSubview:self.balloon3];
        
        self.cloud2ContainerView = [[UIView alloc] init];
        [self addSubview:self.cloud2ContainerView];
        
        self.cloud2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cloud1.png"]];
        [self.cloud2ContainerView addSubview:self.cloud2];
        
        self.cloud3ContainerView = [[UIView alloc] init];
        [self addSubview:self.cloud3ContainerView];
        
        self.cloud3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cloud1.png"]];
        [self.cloud3ContainerView addSubview:self.cloud3];
        
        //飞机
        self.airPlaneContainerView = [[UIView alloc] init];
        [self addSubview:self.airPlaneContainerView];
        
        self.airPlane = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"plane.png"]];
        [self.airPlaneContainerView addSubview:self.airPlane];
        
        //文字
        self.wordContainerView = [[UIView alloc] init];
        self.wordContainerView.width = DESGIN_TRANSFORM_3X(250);
        self.wordContainerView.height = DESGIN_TRANSFORM_3X(100);
        self.wordContainerView.top = 100;
        self.wordContainerView.centerX = self.centerX;
        [self addSubview:self.wordContainerView];
        
        self.leftWingImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"left_wing.png"]];
        self.leftWingImageView.alpha = 0;
        [self.wordContainerView addSubview:self.leftWingImageView];
        
        self.rightWingImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"right_wing.png"]];
        self.rightWingImageView.alpha = 0;
        [self.wordContainerView addSubview:self.rightWingImageView];
        
        self.sunImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"earth_sun.png"]];
        self.sunImageView.hidden = YES;
        [self.wordContainerView addSubview:self.sunImageView];
        
        self.wordImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"earth_word.png"]];
        [self.wordContainerView addSubview:self.wordImageView];
        
        self.leftBalloonImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"left_balloon.png"]];
        [self.wordContainerView addSubview:self.leftBalloonImageView];
        
        self.leftGooseImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"left_goose.png"]];
        [self.wordContainerView addSubview:self.leftGooseImageView];
        
        self.rightBalloonImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"right_balloon.png"]];
        [self.wordContainerView addSubview:self.rightBalloonImageView];
        
        self.rightGooseImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"right_goose.png"]];
        [self.wordContainerView addSubview:self.rightGooseImageView];
        
        [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        [self.earthImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_bottom);
            make.centerX.equalTo(self);
            make.width.equalTo(@(SCREEN_WIDTH + 50));
            make.height.equalTo(@(earthHeight));
        }];
        
        [self.cloud1ContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.earthImageView);
            make.width.equalTo(self.cloud1.mas_width);
            make.height.equalTo(@(earthHeight + 40 * 2));
        }];
        
        [self.cloud1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.centerX.equalTo(self.cloud1ContainerView);
            make.width.equalTo(@80);
            make.height.equalTo(@40);
        }];
        
        [self.cloud2ContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.earthImageView);
            make.width.equalTo(self.cloud2.mas_width);
            make.height.equalTo(@(earthHeight + 80 * 2));
        }];
        
        [self.cloud2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.centerX.equalTo(self.cloud2ContainerView);
            make.width.height.equalTo(self.cloud1);
        }];
        
        [self.cloud3ContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.earthImageView);
            make.width.equalTo(self.cloud3);
            make.height.equalTo(@(earthHeight + (80 + 35) * 2));
        }];
        
        [self.cloud3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.centerX.equalTo(self.cloud3ContainerView);
            make.width.equalTo(@70);
            make.height.equalTo(@35);
        }];
        
        [self.balloon1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.earthImageView.mas_top).offset(-50);
            make.right.equalTo(@(-10));
            make.width.equalTo(@20);
            make.height.equalTo(@26);
        }];
        
        [self.balloon2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.earthImageView.mas_right);
            make.top.equalTo(self.earthImageView).offset(10);
            make.width.height.equalTo(self.balloon1);
        }];
        
        [self.balloon3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.earthImageView.mas_right);
            make.top.equalTo(self.earthImageView).offset(10);
            make.width.equalTo(@40);
            make.height.equalTo(@52);
        }];
        
        [self.airPlaneContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.earthImageView);
            make.centerY.equalTo(self.earthImageView).offset(100);
            make.width.equalTo(@120);
            make.height.equalTo(@(SCREEN_HEIGHT + 250));
        }];
        
        [self.airPlane mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.centerX.equalTo(self.airPlaneContainerView);
            make.width.equalTo(@DESGIN_TRANSFORM_3X(135));
            make.height.equalTo(@DESGIN_TRANSFORM_3X(90));
        }];
        
        
        
        [self.wordImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.wordContainerView);
            make.width.equalTo(@200);
            make.height.equalTo(@70);
        }];
        
        [self.leftWingImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.wordImageView.mas_left).offset(58);
            make.centerY.equalTo(self.wordImageView);
            make.width.equalTo(@46);
            make.height.equalTo(@50);
        }];

        [self.rightWingImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.wordImageView.mas_right).offset(-58);
            make.centerY.equalTo(self.wordImageView);
            make.width.height.equalTo(self.leftWingImageView);
        }];
        
        [self.leftBalloonImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@60);
            make.top.equalTo(@18);
            make.height.width.equalTo(@18);
        }];
        
        [self.leftGooseImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@55);
            make.bottom.equalTo(@(-3));
            make.width.equalTo(@34);
            make.height.equalTo(@16);
        }];
        
        [self.rightBalloonImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.wordImageView.mas_right).offset(-10);
            make.bottom.equalTo(self.wordImageView);
            make.width.height.equalTo(@21);
        }];
        
        [self.rightGooseImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@20);
            make.right.equalTo(self.wordImageView).offset(-40);
            make.width.equalTo(@23);
            make.height.equalTo(@11);
        }];
        
        [self.sunImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.rightGooseImageView.mas_left);
            make.bottom.equalTo(self.rightGooseImageView);
            make.width.height.equalTo(@22);
        }];
        
        self.leftWingImageView.layer.anchorPoint = CGPointMake(1, 0.5);
        self.rightWingImageView.layer.anchorPoint = CGPointMake(0, 0.5);
        
        //遮罩层
        CAGradientLayer *gradientLayer = [self layerWithFrame:self.wordContainerView.bounds];
        self.grandeView = [[UIView alloc] initWithFrame:self.wordContainerView.bounds];
        [self.grandeView.layer addSublayer:gradientLayer];
        self.wordContainerView.maskView = self.grandeView;
        
        CGRect frame = self.grandeView.frame;
        frame.origin.x -= 250;
        self.grandeView.frame = frame;
        
        [self setOtherViewAlpha:0.0];
        
    }
    return self;
}

/**
 *  开始翅膀动画
 */
- (void)startWingAnimation{
    
    [UIView animateWithDuration:2.0 animations:^{
        self.rightWingImageView.alpha = 1.0;
        self.leftWingImageView.alpha = 1.0;
    }];
    
    CAAnimation *leftAnimation1 = [self animationFromAngle:-M_1_PI toAngle:M_1_PI duration:0.3 begainTime:0.3 repeatCount:1];
    CAAnimation *leftAnimation2 = [self animationFromAngle:M_1_PI toAngle:-M_1_PI duration:0.3 begainTime:0 repeatCount:1];
    CAAnimationGroup *leftGroupAnimation = [CAAnimationGroup animation];
    leftGroupAnimation.animations = @[leftAnimation1,leftAnimation2];
    leftGroupAnimation.duration = 0.6;
    leftGroupAnimation.repeatCount = 2;
    leftGroupAnimation.fillMode = kCAFillModeForwards;
    leftGroupAnimation.removedOnCompletion = NO;
    [self.leftWingImageView.layer addAnimation:leftGroupAnimation forKey:nil];
    
    CAAnimation *rightAnimation1 = [self animationFromAngle:M_1_PI toAngle:-M_1_PI duration:0.3 begainTime:0.3 repeatCount:1];
    CAAnimation *rightAnimation2 = [self animationFromAngle:-M_1_PI toAngle:M_1_PI duration:0.3 begainTime:0 repeatCount:1];
    CAAnimationGroup *rightGroupAnimation = [CAAnimationGroup animation];
    rightGroupAnimation.animations = @[rightAnimation1,rightAnimation2];
    rightGroupAnimation.duration = 0.6;
    rightGroupAnimation.repeatCount = 2;
    rightGroupAnimation.fillMode = kCAFillModeForwards;
    rightGroupAnimation.removedOnCompletion = NO;
    [self.rightWingImageView.layer addAnimation:rightGroupAnimation forKey:nil];
    
}

/**
 *  太阳升起动画
 */
- (void)startSunAnimation{
    self.sunImageView.hidden = NO;
    //位移动画
    CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"position.y"];
    animation1.repeatCount = 1;
    animation1.beginTime = 0.0;
    animation1.fromValue = @(self.sunImageView.centerY + 20);
    animation1.toValue = @(self.sunImageView.centerY - 5);
    animation1.duration = 1.0;
    
    //透明度变化
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation2.repeatCount = 1;
    animation2.beginTime = 0.0;
    animation2.fromValue = @(0);
    animation2.toValue = @(1);
    animation2.duration = 1.0;
    
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.animations = @[animation1,animation2];
    groupAnimation.repeatCount = 1;
    groupAnimation.duration = 1.0;
    groupAnimation.fillMode = kCAFillModeForwards;
    groupAnimation.removedOnCompletion = NO;
    [self.sunImageView.layer addAnimation:groupAnimation forKey:nil];
    
}

- (void)startWordAnimation{
    CGRect rect = self.grandeView.frame;
    rect.origin.x += 250;
    [UIView animateWithDuration:2.0 animations:^{
        self.grandeView.frame = rect;
    } completion:^(BOOL finished) {
        [self startSunAnimation];
        [self startWingAnimation];
    }];
}

/**
 *  遮罩层
 *
 */
- (CAGradientLayer *)layerWithFrame:(CGRect)frame{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    [gradientLayer setFrame:frame];//遮罩层的区域
    [gradientLayer setColors:@[(__bridge id)[UIColor blackColor].CGColor,
                               (__bridge id)[UIColor blackColor].CGColor]];//渐变的颜色数组 __bridge id类型
    [gradientLayer setLocations:@[@(0.0),@(1.0)]];//渐变的区域 整个是1 0.25就是1/4处以此类推
    [gradientLayer setStartPoint:CGPointMake(0, 0)];
    [gradientLayer setEndPoint:CGPointMake(1, 0)];//渐变的方向(1,0)就是横向 (1,1)就是从左上角到右下角以此类推
    return gradientLayer;
}

/**
 *  根据屏幕宽度获取图片的高度
 */
- (CGFloat)heigtForImage:(UIImage *)image {
    CGFloat height = image.size.height /(image.size.width/(SCREEN_WIDTH + 50));
    return height;
}

/**
 *  设置alpha
 */
- (void)setOtherViewAlpha:(CGFloat)alpha{
    self.cloud1ContainerView.alpha = alpha;
    self.cloud2ContainerView.alpha = alpha;
    self.cloud3ContainerView.alpha = alpha;
    self.earthImageView.alpha = alpha;
    self.balloon1.alpha = alpha;
    self.balloon2.alpha = alpha;
    self.balloon3.alpha = alpha;
    self.airPlaneContainerView.alpha = alpha;
}

/**
 *  地球动画
 */
- (void)startEarthAnimation{
    CAAnimation *rotationAnimation = [self animationFromAngle:0 toAngle:-M_PI * 2 duration:16 begainTime:0.0 repeatCount:MAXFLOAT];
    [self.earthImageView.layer addAnimation:rotationAnimation forKey:@"transform.rotation.z"];
}

/**
 *  飞机动画
 */
- (void)startPlaneAnimation{
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    CAAnimation *animation1 = [self animationFromAngle:-M_PI * 0.5 toAngle:-radius * 5 duration:3.0 begainTime:0.0 repeatCount:1];
    animation1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    CAAnimation *animation2 = [self animationFromAngle:-radius * 5 toAngle:radius * 5 duration:2.0 begainTime:3.0 repeatCount:1];
    CAAnimation *animation3 = [self animationFromAngle:radius * 5 toAngle:M_PI * 0.22 duration:3.0 begainTime:5.0 repeatCount:1];
    animation3.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    groupAnimation.animations = @[animation1,animation2,animation3];
    groupAnimation.duration = 8.0;
    groupAnimation.repeatCount = 1;
    groupAnimation.fillMode = kCAFillModeForwards;
    groupAnimation.removedOnCompletion = NO;
    groupAnimation.autoreverses = NO;
    groupAnimation.delegate = self;
    [self.airPlaneContainerView.layer addAnimation:groupAnimation forKey:nil];
}

/**
 *  白云动画
 */
- (void)startCloudAnimation{
    [self startCloud1Animation];
    [self startCloud2Animation];
    [self startCloud3Aniamtion];
}

//底部的白云动画
- (void)startCloud1Animation{
    CGFloat fromAngle = radius * 10 + self.radiusDistance;
    CGFloat toAngle = (-M_PI * 2.0) + fromAngle;
    CGFloat time = M_PI * 2.0 * (180/M_PI) * FPS + 30;
    CAAnimation *rotationAnimation = [self animationFromAngle:fromAngle toAngle:toAngle duration:time begainTime:0.0 repeatCount:1];
    [self.cloud1ContainerView.layer addAnimation:rotationAnimation forKey:nil];
}

//中间的白云动画
- (void)startCloud2Animation{
    CGFloat fromAngle = M_PI * 0.35 + self.radiusDistance;
    CGFloat toAngle = (-M_PI * 2.0) + fromAngle;
    CGFloat time = M_PI * 2.0 * (180/M_PI) * FPS + 30;
    CAAnimation *rotationAnimation = [self animationFromAngle:fromAngle toAngle:toAngle duration:time begainTime:0.0 repeatCount:1];
    [self.cloud2ContainerView.layer addAnimation:rotationAnimation forKey:nil];
}

//顶部的白云动画
- (void)startCloud3Aniamtion{
    CGFloat fromAngle = self.radiusDistance;
    CGFloat toAngle = -M_PI * 2.0 + self.radiusDistance;
    CGFloat time = M_PI * 2.0 * (180/M_PI) * FPS + 30;
    CAAnimation *rotationAnimation = [self animationFromAngle:fromAngle toAngle:toAngle duration:time begainTime:0.0 repeatCount:1];
    [self.cloud3ContainerView.layer addAnimation:rotationAnimation forKey:nil];
}

/**
 *  气球动画
 */
- (void)startBalloonAnimation{
    [self startBalloon1Animation];
    [self startBalloon2Animation];
    [self startBalloon3Animation];
}

- (void)startBalloon1Animation{
    [UIView animateWithDuration:14.0 animations:^{
        self.balloon1.transform = CGAffineTransformMakeTranslation(-(SCREEN_WIDTH), -200);
    }];
}

- (void)startBalloon2Animation{
    [UIView animateWithDuration:12.0 animations:^{
        self.balloon2.transform = CGAffineTransformMakeTranslation(-(SCREEN_WIDTH), -50);
    }];
}

- (void)startBalloon3Animation{
    [UIView animateWithDuration:9.0 animations:^{
        self.balloon3.transform = CGAffineTransformMakeTranslation(-(SCREEN_WIDTH + 40), 0);
    }];
}

//旋转动画
- (CAAnimation *)animationFromAngle:(CGFloat)fromAngle toAngle:(CGFloat)toAngle duration:(CGFloat)duration begainTime:(CFTimeInterval)begainTime repeatCount:(float)reapCount{
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.fromValue = @(fromAngle);
    rotationAnimation.toValue = @(toAngle);
    rotationAnimation.beginTime = begainTime;
    rotationAnimation.duration = duration;
    rotationAnimation.repeatCount = reapCount;
    return rotationAnimation;
}

#pragma mark - Public Method

- (void)startAniamtion{
    [UIView animateWithDuration:1.0 animations:^{
        self.backgroundImageView.alpha = 1.0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1.0 animations:^{
            [self setOtherViewAlpha:1.0];
        }];
       [self startBalloonAnimation];
       [self startEarthAnimation];
       [self startPlaneAnimation];
       [self startCloudAnimation];
       [self startWordAnimation];
    }];
}

#pragma mark - AnimationDelegate

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    [UIView animateWithDuration:1.0 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeAllAnimation];
        [self.delegate animationFinishWithEarthView:self];
    }];
}

- (void)removeAllAnimation{
    [self.earthImageView.layer removeAllAnimations];
    [self.cloud1ContainerView.layer removeAllAnimations];
    [self.cloud2ContainerView.layer removeAllAnimations];
    [self.cloud3ContainerView.layer removeAllAnimations];
    [self.airPlaneContainerView.layer removeAllAnimations];
    [self.layer removeAllAnimations];
}

@end
