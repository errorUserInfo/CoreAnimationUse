//
//  CarView.m
//  Earth
//
//  Created by 温天浩 on 16/8/23.
//  Copyright © 2016年 温天浩. All rights reserved.
//

#import "CarView.h"
#import "YYImage.h"

@interface CarView ()

@property(nonatomic,strong) UIImageView *groundImageViewBg3;//背景3
@property(nonatomic,strong) UIImageView *groundImageViewBg2;//背景2
@property(nonatomic,strong) UIImageView *groundImageViewBg1;//背景1
@property(nonatomic,strong) UIImageView *groundImageView;//路面静态草坪

@property(nonatomic,strong) UIView *windMillContainer; //树和风车的容器
@property(nonatomic,strong) UIImageView *poleImageView;//杆
@property(nonatomic,strong) UIImageView *bladeImageView;//叶片
@property(nonatomic,strong) UIImageView *treeImageView;//树

@property(nonatomic,strong) UIView *windMillContainer1;//树和风车的容器
@property(nonatomic,strong) UIImageView *poleImageView1;//杆
@property(nonatomic,strong) UIImageView *bladeImageView1;//叶片
@property(nonatomic,strong) UIImageView *treeImageView1;//树

@property(nonatomic,strong) YYAnimatedImageView *grassImageView;//路面动态草坪
@property(nonatomic,strong) YYAnimatedImageView *roadSurfaceImageView;//路面
@property(nonatomic,strong) YYAnimatedImageView *zebraImageView;//斑马线

@property(nonatomic,strong) NSMutableArray *zebars;//斑马线序列帧
@property(nonatomic,strong) NSMutableArray *roadSurfaces;//路面序列帧
@property(nonatomic,strong) NSMutableArray *grasses;//草坪序列帧

/**
 *  汽车元素
 */
@property(nonatomic,strong) UIView *carContainerView;//汽车容器
@property(nonatomic,strong) UIImageView *carImageView;//汽车
@property(nonatomic,strong) YYAnimatedImageView *leftLightImageView1;//左车灯
@property(nonatomic,strong) YYAnimatedImageView *rightLightImageView1;//右车灯
@property(nonatomic,strong) YYAnimatedImageView *frontWheelImageView;//前轮
@property(nonatomic,strong) YYAnimatedImageView *backWheelImageView;//后轮
@property(nonatomic,strong) YYAnimatedImageView *frontSmokeImageView;//前烟尘
@property(nonatomic,strong) YYAnimatedImageView *backSmokeImageView;//后烟尘
@property(nonatomic,strong) NSMutableArray *smokeImages;
@property(nonatomic,strong) NSMutableArray *lightArray;
@property(nonatomic,strong) NSMutableArray *frontWheels;
@property(nonatomic,strong) NSMutableArray *backWheels;

@end

static CGFloat FPS = 1.0/11.0 ;

//static CGFloat topY = 200;
//static CGFloat bottomY = 250 * 2;
#define DESGIN_TRANSFORM_3X(V) (V*SCREEN_HEIGHT*1.0/640)
//static CGFloat radius = M_PI/180.0;

@implementation CarView

- (NSMutableArray *)grasses{
    if (!_grasses) {
        _grasses = [[NSMutableArray alloc] init];
        for (int i = 1; i < 9; i++) {
            NSString *imageName = [NSString stringWithFormat:@"cao000%d",i];
            NSString *filePath = [[NSBundle mainBundle] pathForResource:imageName ofType:@"png"];
            if (filePath) {
                [_grasses addObject:filePath];
            }
        }
    }
    return _grasses;
}

- (NSMutableArray *)roadSurfaces{
    if (!_roadSurfaces) {
        _roadSurfaces = [[NSMutableArray alloc] init];
        for (int i = 1; i < 4; i++) {
            NSString *imageName = [NSString stringWithFormat:@"road_surface0%d",i];
            NSString *filePath = [[NSBundle mainBundle] pathForResource:imageName ofType:@"png"];
            if (filePath) {
                [_roadSurfaces addObject:filePath];
            }
        }
    }
    return _roadSurfaces;
}

-(NSMutableArray *)zebars{
    if (!_zebars) {
        _zebars = [[NSMutableArray alloc] init];
        for (int i = 1; i < 4; i++) {
            NSString *imageName = [NSString stringWithFormat:@"zebra_crossing_%d",i];
            NSString *filePath = [[NSBundle mainBundle] pathForResource:imageName ofType:@"png"];
            if (filePath) {
                [_zebars addObject:filePath];
            }
        }
    }
    return _zebars;
}

- (NSMutableArray *)smokeImages{
    if (!_smokeImages) {
        _smokeImages = [[NSMutableArray alloc] init];
        for (int i = 1; i < 12; i++) {
            NSString *imageName = [NSString stringWithFormat:@"smoke%d",i];
            NSString *filePath = [[NSBundle mainBundle] pathForResource:imageName ofType:@"png"];
            
            if (filePath) {
                [_smokeImages addObject:filePath];
            }
        }
    }
    return _smokeImages;
}

- (NSMutableArray *)lightArray{
    if (!_lightArray) {
        _lightArray = [[NSMutableArray alloc] init];
        for (int i = 1; i < 3; i++) {
            NSString *imageName = [NSString stringWithFormat:@"light_high%d",i];
            NSString *filePath = [[NSBundle mainBundle] pathForResource:imageName ofType:@"png"];
            
            if (filePath) {
                [_lightArray addObject:filePath];
            }
        }
    }
    return _lightArray;
}

- (NSMutableArray *)frontWheels{
    if (!_frontWheels) {
        _frontWheels = [[NSMutableArray alloc] init];
        for (int i = 1; i < 3; i++) {
            NSString *imageName = [NSString stringWithFormat:@"front_wheel%d",i];
            NSString *filePath = [[NSBundle mainBundle] pathForResource:imageName ofType:@"png"];
            
            if (filePath) {
                [_frontWheels addObject:filePath];
            }
        }
    }
    return _frontWheels;
}

- (NSMutableArray *)backWheels{
    if (!_backWheels) {
        _backWheels = [[NSMutableArray alloc] init];
        for (int i = 1; i < 3; i++) {
            NSString *imageName = [NSString stringWithFormat:@"back_wheel%d",i];
            NSString *filePath = [[NSBundle mainBundle] pathForResource:imageName ofType:@"png"];
            
            if (filePath) {
                [_backWheels addObject:filePath];
            }
        }
    }
    return _backWheels;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        /**
         *  路面元素
         */
        
        self.groundImageViewBg3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ground_bg3.png"]];
        [self addSubview:self.groundImageViewBg3];
        
        self.groundImageViewBg2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ground_bg2.png"]];
        [self addSubview:self.groundImageViewBg2];
        
        self.groundImageViewBg1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ground_bg1.png"]];
        [self addSubview:self.groundImageViewBg1];
        
        self.groundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ground.png"]];
        CGFloat groundHeight = [self heigtForImage:self.groundImageView.image];
        [self addSubview:self.groundImageView];
        
        self.grassImageView = [[YYAnimatedImageView alloc] initWithImage:[UIImage imageNamed:@"cao0001.png"]];
        self.grassImageView.width = DESGIN_TRANSFORM_3X(127);
        self.grassImageView.height = DESGIN_TRANSFORM_3X(130);
        self.grassImageView.right = self.right;
        self.grassImageView.bottom = self.bottom;
        self.grassImageView.image = [[YYFrameImage alloc] initWithImagePaths:self.grasses oneFrameDuration:0.1 loopCount:0];
        
        self.windMillContainer = [[UIView alloc] init];
        [self addSubview:self.windMillContainer];
        
        self.poleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pole.png"]];
        [self.windMillContainer addSubview:self.poleImageView];
        
        self.bladeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"blade.png"]];
        [self.windMillContainer addSubview:self.bladeImageView];
        
        self.treeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tree.png"]];
        [self.windMillContainer addSubview:self.treeImageView];
        
        self.windMillContainer1 = [[UIView alloc] init];
        [self addSubview:self.windMillContainer1];
        
        self.poleImageView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pole.png"]];
        [self.windMillContainer1 addSubview:self.poleImageView1];
        
        self.bladeImageView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"blade.png"]];
        [self.windMillContainer1 addSubview:self.bladeImageView1];
        
        self.treeImageView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tree.png"]];
        [self.windMillContainer1 addSubview:self.treeImageView1];
        
        self.roadSurfaceImageView = [[YYAnimatedImageView alloc] init];
        self.roadSurfaceImageView.image = [[YYFrameImage alloc] initWithImagePaths:self.roadSurfaces oneFrameDuration:0.1 loopCount:0];
        
        self.zebraImageView = [[YYAnimatedImageView alloc] init];
        self.zebraImageView.image = [[YYFrameImage alloc] initWithImagePaths:self.zebars oneFrameDuration:0.1 loopCount:0];
        
        [self.groundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.width.equalTo(self);
            make.height.equalTo(@(groundHeight));
        }];
        
        [self.groundImageViewBg3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.groundImageView.mas_top).offset(SCREEN_WIDTH * 1.7 * 0.16);
            make.width.equalTo(@(SCREEN_WIDTH * 1.7));
            make.right.equalTo(self);
            make.height.equalTo(@(SCREEN_WIDTH * 1.7 * 0.25));
        }];
        
        [self.groundImageViewBg2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.groundImageView.mas_top).offset(20);
            make.right.equalTo(self);
            make.width.equalTo(@(SCREEN_WIDTH * 1.4));
            make.height.equalTo(@(SCREEN_WIDTH * 1.4 * 0.1));
        }];
        
        [self.groundImageViewBg1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.groundImageView.mas_top).offset(30);
            make.right.equalTo(self);
            make.width.equalTo(@(SCREEN_WIDTH * 1.5));
            make.height.equalTo(@(SCREEN_WIDTH * 1.5 * 0.13));
        }];
        
        [self.windMillContainer mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.groundImageView.mas_top).offset(20);
            make.centerX.equalTo(self.groundImageView);
            make.width.equalTo(@150);
            make.height.equalTo(@85);
        }];
        
        [self.bladeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self.windMillContainer);
            make.width.equalTo(@60);
            make.height.equalTo(@60);
        }];
        
        [self.poleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.bladeImageView).offset(10);
            make.top.equalTo(self.bladeImageView.mas_centerY);
            make.width.equalTo(@43);
            make.height.equalTo(@53);
        }];
        
        [self.treeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@0);
            make.bottom.equalTo(self.poleImageView).offset(-5);
            make.width.equalTo(@25);
            make.height.equalTo(@35);
        }];
        
        [self.windMillContainer1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.groundImageView.mas_top).offset(30);
            make.right.equalTo(self.windMillContainer.mas_left).offset(-100);
            make.width.equalTo(@150);
            make.height.equalTo(@85);
        }];
        
        [self.bladeImageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self.windMillContainer1);
            make.width.equalTo(@60);
            make.height.equalTo(@60);
        }];
        
        [self.poleImageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.bladeImageView1).offset(10);
            make.top.equalTo(self.bladeImageView1.mas_centerY);
            make.width.equalTo(@43);
            make.height.equalTo(@53);
        }];
        
        [self.treeImageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@0);
            make.bottom.equalTo(self.poleImageView1).offset(-5);
            make.width.equalTo(@25);
            make.height.equalTo(@35);
        }];
        
        /**
         *  汽车元素
         */
        
        self.carContainerView = [[UIView alloc] init];
        [self addSubview:self.carContainerView];
        
        self.leftLightImageView1 = [[YYAnimatedImageView alloc] init];
        self.leftLightImageView1.image = [[YYFrameImage alloc]initWithImagePaths:self.lightArray oneFrameDuration:0.25 loopCount:0];
        self.leftLightImageView1.autoPlayAnimatedImage = NO;
        self.leftLightImageView1.hidden = YES;
        [self.carContainerView addSubview:self.leftLightImageView1];
        
        self.backSmokeImageView = [[YYAnimatedImageView alloc] init];
        self.backSmokeImageView.autoPlayAnimatedImage = NO;
        self.backSmokeImageView.image = [[YYFrameImage alloc]initWithImagePaths:self.smokeImages oneFrameDuration:1.5/11 loopCount:1];
        [self.carContainerView addSubview:self.backSmokeImageView];
        
        self.carImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"car.png"]];
        [self.carContainerView addSubview:self.carImageView];
        
        self.frontWheelImageView = [[YYAnimatedImageView alloc] init];
        self.frontWheelImageView.image = [[YYFrameImage alloc]initWithImagePaths:self.frontWheels oneFrameDuration:FPS loopCount:0];
        
        self.backWheelImageView = [[YYAnimatedImageView alloc] init];
        self.backWheelImageView.image = [[YYFrameImage alloc]initWithImagePaths:self.backWheels oneFrameDuration:FPS loopCount:0];
        
        self.rightLightImageView1 = [[YYAnimatedImageView alloc] init];
        self.rightLightImageView1.image = [[YYFrameImage alloc]initWithImagePaths:self.lightArray oneFrameDuration:0.25 loopCount:0];
        
        self.frontSmokeImageView = [[YYAnimatedImageView alloc] init];
        self.frontSmokeImageView.image = [[YYFrameImage alloc]initWithImagePaths:self.smokeImages oneFrameDuration:1.5/11 loopCount:1];
        
        [self.leftLightImageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@(60));
            make.left.equalTo(@-90);
            make.width.equalTo(@(96 * 2));
            make.height.equalTo(@(48 * 2));
        }];
        
        [self.backSmokeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@65);
            make.left.equalTo(@220);
            make.width.equalTo(@90);
            make.height.equalTo(@50);
        }];
        
        [self.carContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.width.equalTo(@320);
            make.height.equalTo(@188);
        }];
        
        [self.carImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.carContainerView);
        }];
        
        self.alpha = 0.0;
        
    }
    return self;
}

/**
 *  背景移动动画
 */
- (void)startBackgroundMoveAnimation{
    [UIView animateWithDuration:10.0 animations:^{
        self.groundImageViewBg3.transform = CGAffineTransformMakeTranslation(SCREEN_WIDTH, 0);
        self.groundImageViewBg2.transform = CGAffineTransformMakeTranslation(SCREEN_WIDTH, 0);
        self.groundImageViewBg1.transform = CGAffineTransformMakeTranslation(SCREEN_WIDTH, 0);
        self.windMillContainer.transform = CGAffineTransformMakeTranslation(SCREEN_WIDTH, 0);
        self.windMillContainer1.transform = CGAffineTransformMakeTranslation(SCREEN_WIDTH, -10);
    }];
    CAAnimation *scaleAnimation = [self animaitonFromScale:1.0 toScale:0.6 begainTime:0.0 duration:10.0];
    [self.windMillContainer.layer addAnimation:scaleAnimation forKey:nil];
}

/**
 *  路面动画
 */
- (void)startGroundAnimation{
    
    [self insertSubview:self.roadSurfaceImageView belowSubview:self.carContainerView];
    [self insertSubview:self.zebraImageView belowSubview:self.carContainerView];
//    [self insertSubview:self.grassImageView belowSubview:self.carContainerView];
    
    [self.zebraImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(self);
        make.height.equalTo(@(SCREEN_WIDTH * 0.24));
        make.top.equalTo(self.groundImageView).offset(DESGIN_TRANSFORM_3X(18));
    }];
    
    [self.roadSurfaceImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.centerY.equalTo(self.groundImageView).offset(5);
        make.width.equalTo(self);
        make.height.equalTo(@(SCREEN_WIDTH * 0.48));
    }];
    
}

/**
 *  风车动画
 */
- (void)startWindMillAnimation{
    CAAnimation *rotationAnimation = [self animationFromAngle:0 toAngle:-M_PI * 2 duration:1.5 begainTime:0.0 repeatCount:MAXFLOAT];
    [self.bladeImageView.layer addAnimation:rotationAnimation forKey:@"transform.rotation.z"];
    [self.bladeImageView1.layer addAnimation:rotationAnimation forKey:@"transform.rotation.z"];
}

/**
 *  烟尘动画
 */
- (void)startSmokeAnimation{
    
    [self.backSmokeImageView startAnimating];
    [self.carContainerView addSubview:self.frontSmokeImageView];
    
    [self.frontSmokeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@(-30));
        make.left.equalTo(@173);
        make.width.equalTo(@170);
        make.height.equalTo(@85);
    }];
    
}

/**
 *  车灯动画
 */
- (void)startLightAnimation{
    
    self.leftLightImageView1.hidden = NO;
    [self.leftLightImageView1 startAnimating];
    [self.carContainerView addSubview:self.rightLightImageView1];
    
    [self.rightLightImageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@85);
        make.left.equalTo(@(-50));
        make.width.equalTo(@(100 *2));
        make.height.equalTo(@(50 *2));
    }];

}

/**
 *  轮胎动画
 */
- (void)startWheelAnimation{
    
    [self.carContainerView addSubview:self.frontWheelImageView];
    [self.carContainerView addSubview:self.backWheelImageView];
    
    [self.frontWheelImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.carContainerView);
    }];
    
    [self.backWheelImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.carContainerView);
    }];
    
}

/**
 *  位移放大动画
 */
- (void)startCarMoveAnimation{
    
    CGFloat frontDuration = 1.3;
    CGFloat centerDuration = 2.4;
    CGFloat backDuraiton = 1.3;
    
    CGFloat y_differ = DESGIN_TRANSFORM_3X(50);
    CGFloat distance = DESGIN_TRANSFORM_3X(20);
    
    CAAnimation *animation1 = [self animationFromPoint:CGPointMake(self.bounds.size.width + self.centerX, self.bounds.size.height - y_differ * 3 - DESGIN_TRANSFORM_3X(40)) toPoint:CGPointMake(self.centerX, self.bounds.size.height - y_differ * 3 + DESGIN_TRANSFORM_3X(10)) duration:frontDuration begainTime:0.0];
    animation1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    CAAnimation *animation2 = [self animationFromPoint:CGPointMake(self.centerX, self.bounds.size.height - y_differ*3 + DESGIN_TRANSFORM_3X(10)) toPoint:CGPointMake(self.centerX - 50, self.bounds.size.height - y_differ * 3 + distance) duration:centerDuration begainTime:frontDuration];
    
    CAAnimation *animation3 = [self animationFromPoint:CGPointMake(self.centerX - 50, self.bounds.size.height - y_differ * 3 + distance) toPoint:CGPointMake(-self.centerX- 90, self.bounds.size.height - y_differ * 1) duration:backDuraiton begainTime:frontDuration + centerDuration];
    animation3.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    CAAnimation *animation4 = [self animaitonFromScale:0.05 toScale:0.7 begainTime:0.0 duration:frontDuration];
    CAAnimation *animation5 = [self animaitonFromScale:0.7 toScale:0.9 begainTime:frontDuration duration:centerDuration];
    CAAnimation *animation6 = [self animaitonFromScale:0.9 toScale:1.8 begainTime:frontDuration + centerDuration duration:backDuraiton];
    
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.animations = @[animation1,animation2,animation3,animation4,animation5,animation6];
    groupAnimation.fillMode = kCAFillModeForwards;
    groupAnimation.removedOnCompletion = NO;
    groupAnimation.duration = frontDuration + centerDuration + backDuraiton;
    groupAnimation.repeatCount = 1;
    groupAnimation.delegate = self;
    [self.carContainerView.layer addAnimation:groupAnimation forKey:nil];
    
    [self performSelector:@selector(startLightAnimation) withObject:nil afterDelay:frontDuration];
    
}

/**
 *  马路动画
 */
- (void)startHighWayAnimation{
    [self startGroundAnimation];
    [self startWindMillAnimation];
    [self startBackgroundMoveAnimation];
}

/**
 *  汽车动画
 */
- (void)startCarAnimtion{
    [self startWheelAnimation];
    [self startCarMoveAnimation];
    [self performSelector:@selector(startSmokeAnimation) withObject:nil afterDelay:0.5];
//    [self startSmokeAnimation];
//    [self startLightAnimation];
}

/**
 *  根据屏幕宽度获取图片的高度
 */
- (CGFloat)heigtForImage:(UIImage *)image {
    CGFloat height = image.size.height /(image.size.width/SCREEN_WIDTH);
    return height;
}

//位移
- (CAAnimation *)animationFromPoint:(CGPoint)fromPoint toPoint:(CGPoint)toPoint duration:(CGFloat)duration begainTime:(CGFloat)begainTime{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.fromValue = [NSValue valueWithCGPoint:fromPoint];
    animation.toValue = [NSValue valueWithCGPoint:toPoint];
    animation.duration = duration;
    animation.beginTime = begainTime;
    return animation;
}

//由小到大
- (CAAnimation *)animaitonFromScale:(CGFloat)fromScale toScale:(CGFloat)toScale begainTime:(CGFloat)begainTime duration:(CGFloat)duration{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.fromValue = @(fromScale);
    animation.toValue = @(toScale);
    animation.duration = duration;
    animation.beginTime = begainTime;
    return animation;
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

- (void)startAnimation{
    [UIView animateWithDuration:1.0 animations:^{
        self.alpha = 1.0;
    }];
    [self startCarAnimtion];
    [self startHighWayAnimation];
}

#pragma mark - Animation Delegate

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if (flag) {
        [UIView animateWithDuration:1.0 animations:^{
            self.alpha = 0.0;
        } completion:^(BOOL finished) {
            [self removeAllAnimation];
            [self.delegate animationFinishWithFerrariCarView:self];
        }];
    }
}

- (void)removeAllAnimation{
    [self.bladeImageView.layer removeAllAnimations];//风车旋转
    [self.bladeImageView1.layer removeAllAnimations];//风车旋转
    self.grassImageView.image = nil;//路面动态草坪
    self.roadSurfaceImageView.image = nil;//路面
    self.zebraImageView.image = nil;//斑马线
    self.leftLightImageView1.image = nil;//左车灯
    self.rightLightImageView1.image = nil;//右车灯
    self.frontWheelImageView.image = nil;//前轮
    self.backWheelImageView.image = nil;//后轮
    [self.carContainerView.layer removeAllAnimations];//汽车移动
}

@end
