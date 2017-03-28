//
//  Common.h
//  WFHospital
//
//  Created by 淇翔科技 on 15/12/7.
//  Copyright © 2015年 淇翔科技. All rights reserved.
//

#ifndef Common_h
#define Common_h

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kTabBarHeight 49
#define kNavgationBarHeight 64

//输入框的高度
#define inputHeight 44


//获得RGB颜色
#define RGBA(r, g, b, a)           [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r, g, b)               RGBA(r, g, b, 1.0f)


#define heightForNav    44;


#define navBackagroundColor     RGB(0,133,62);

#endif /* Common_h */
