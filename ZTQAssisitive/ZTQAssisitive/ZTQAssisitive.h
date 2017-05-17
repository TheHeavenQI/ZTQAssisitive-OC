//
//  ZTQAssisitive.h
//  ZTQAssisitive
//
//  Created by Ztq on 2017/3/21.
//  Copyright © 2017年 jiafakeji. All rights reserved.
//

#ifndef ZTQAssisitive_h
#define ZTQAssisitive_h

// frame control

#define ZTQSCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define ZTQSCREENHEIGHT [UIScreen mainScreen].bounds.size.height

#define ZTQDEFAULTWIDTH 375.0
#define ZTQDEFAULTHEIGHT 667.0

#define ZTQADAPTIVEWIDTH(a) a * ZTQSCREENWIDTH / ZTQDEFAULTWIDTH

#define ZTQADAPTIVEHEIGHT(b) b * ZTQSCREENHEIGHT / ZTQDEFAULTHEIGHT


#endif /* ZTQAssisitive_h */
