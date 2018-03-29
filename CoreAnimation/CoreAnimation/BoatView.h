//
//  BoatView.h
//  Earth
//
//  Created by 温天浩 on 16/8/22.
//  Copyright © 2016年 温天浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BoatView;
@protocol BoatViewDelegate <NSObject>

- (void)animationStopWithBoatView:(BoatView *)boatView;

@end

@interface BoatView : UIView

@property(nonatomic,weak) id<BoatViewDelegate> delegate;
- (void)startAnimation;
- (void)removeAllAnimation;
@end
