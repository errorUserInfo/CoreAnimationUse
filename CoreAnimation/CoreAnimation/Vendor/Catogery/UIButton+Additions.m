//
//  UIButton+Additions.m
//  music
//
//  Created by Javen on 14-5-27.
//  Copyright (c) 2014年 toraysoft. All rights reserved.
//

#import "UIButton+Additions.h"

@implementation UIButton (Additions)

+ (UIButton *)buttonWithTitle:(NSString *)title fontSize:(NSInteger)fontSize textColor:(UIColor *)color backGroundColor:(UIColor *)backgroundColor {
    UIButton *btn = [UIButton new];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    [btn setTitleColor:color forState:UIControlStateNormal];
    btn.backgroundColor = backgroundColor;
    return btn;
}

@end
