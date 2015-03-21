//
//  StyleConstant.h
//  dreamMaster
//
//  Created by Derek Cheung on 21/3/15.
//  Copyright (c) 2015 Derek Cheung. All rights reserved.
//

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define UIColorFromRGBAndAlpha(rgbValue, alp) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:alp]

#define COLOR_NormalText        UIColorFromRGB(0xEBEEE5)
#define COLOR_Facebook_Inside   UIColorFromRGB(0x384e87)
#define COLOR_White             UIColorFromRGB(0xFFFFFF)
#define COLOR_TransparentButton UIColorFromRGBAndAlpha(0xFFFFFF, 0.7f)
#define COLOR_SelectedButton    UIColorFromRGB(0x282828)

#define FONT_MEDIUM_SIZE(x)     [UIFont fontWithName:FONT_UniversLTStd size:(x)]
#define FONT_REGULAR_SIZE(x)    [UIFont fontWithName:FONT_UniversLTStd size:(x)]
#define FONT_BOLD_SIZE(x)       [UIFont fontWithName:FONT_UniversLTStd size:(x)]

#define FONT_DIN_MEDIUM         @"DIN-Medium"
#define FONT_DIN_REGULAR        @"DIN-Regular"
#define FONT_DIN_BOLD           @"DIN-Bold"
#define FONT_UniversLTStd       @"UniversLTStd-LightCn"