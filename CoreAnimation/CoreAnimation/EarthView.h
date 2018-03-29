//
//  EarthView.h
//  Earth
//
//  Created by 温天浩 on 16/8/20.
//  Copyright © 2016年 温天浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EarthView;
@protocol EarthViewDelegate <NSObject>

- (void)animationFinishWithEarthView:(EarthView *)earthView;

@end

@interface EarthView : UIView

- (void)removeAllAnimation;
- (void)startAniamtion;
@property(nonatomic,weak) id<EarthViewDelegate> delegate;

@end
