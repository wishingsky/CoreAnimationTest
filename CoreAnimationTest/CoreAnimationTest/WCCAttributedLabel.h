//
//  WCCAttributedLabel.h
//  wochacha
//
//  Created by willie_wei on 13-11-15.
//  Copyright (c) 2013年 wochacha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>
#import <QuartzCore/QuartzCore.h>

@interface WCCAttributedLabel : UILabel{
    NSMutableAttributedString          *_attString;
}

// 设置某段字的颜色
- (void)setColor:(UIColor *)color fromIndex:(NSInteger)location length:(NSInteger)length;

// 设置某段字的字体
- (void)setFont:(UIFont *)font fromIndex:(NSInteger)location length:(NSInteger)length;

// 设置某段字的风格
- (void)setStyle:(CTUnderlineStyle)style fromIndex:(NSInteger)location length:(NSInteger)length;

@end
