//
//  THHeader.h
//  CoreAnimation
//
//  Created by 天浩 on 2018/3/28.
//  Copyright © 2018年 天浩. All rights reserved.
//

#ifndef THHeader_h
#define THHeader_h

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define DESGIN_TRANSFORM_3X(V) (V*SCREEN_HEIGHT*1.0/640)
#define DESGIN_TRANSFORM_FROM_iPhone6_3X(V) (V*SCREEN_HEIGHT*1.0/750)

#endif /* THHeader_h */
