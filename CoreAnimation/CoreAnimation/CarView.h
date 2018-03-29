//
//  CarView.h
//  Earth
//
//  Created by 温天浩 on 16/8/23.
//  Copyright © 2016年 温天浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CarView;
@protocol CarViewDelegate <NSObject>

- (void)animationFinishWithFerrariCarView:(CarView *)carView;

@end

@interface CarView : UIView

- (void)removeAllAnimation;
- (void)startAnimation;
@property(nonatomic,weak) id<CarViewDelegate> delegate;

@end
