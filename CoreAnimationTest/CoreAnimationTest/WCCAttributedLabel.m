//
//  WCCAttributedLabel.m
//  wochacha
//
//  Created by willie_wei on 13-11-15.
//  Copyright (c) 2013年 wochacha. All rights reserved.
//

#import "WCCAttributedLabel.h"

@interface WCCAttributedLabel ()

@property (nonatomic,retain) NSMutableAttributedString *attString;
@end

@implementation WCCAttributedLabel
@synthesize attString = _attString;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
		[self setUp];
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
	[self setUp];
}

- (void)setUp
{
	//		textLayer.backgroundColor = [UIColor purpleColor].CGColor;
	[self textLayer].alignmentMode = kCAAlignmentJustified;
	[self textLayer].wrapped = YES;
	[self.layer display];

}

+ (Class)layerClass
{
	//this makes our label create a CATextLayer //instead of a regular CALayer for its backing layer
	return [CATextLayer class];
}

- (CATextLayer *)textLayer
{
	return (CATextLayer *)self.layer;
}


//- (void)drawRect:(CGRect)rect{
//    if (self.text !=nil) {
//        CGContextRef context = UIGraphicsGetCurrentContext();
//        CGContextSaveGState(context);
//        CGContextTranslateCTM(context, 0.0, 0.0);//move
//        CGContextScaleCTM(context, 1.0, -1.0);
//        CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((__bridge  CFAttributedStringRef)_attString);
//        CGMutablePathRef pathRef = CGPathCreateMutable();
//        CGPathAddRect(pathRef,NULL , CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height));//const CGAffineTransform *m
//        CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), pathRef,NULL );//CFDictionaryRef frameAttributes
//        CGContextTranslateCTM(context, 0, -self.bounds.size.height);
////        CGContextSetTextPosition(context, 0, 0);
//        CTFrameDraw(frame, context);
//        CGContextRestoreGState(context);
//        CGPathRelease(pathRef);
//        UIGraphicsPushContext(context);
//    }
//}

- (void)setText:(NSString *)text{
    [super setText:text];
    if (text == nil) {
        self.attString = nil;
    }else{
        self.attString = [[NSMutableAttributedString alloc] initWithString:text];
		CGFloat fHeight = [WCCAttributedLabel heightForLabel:self WithText:text];
		CGRect frame = self.frame;
		frame.size.height = fHeight;
		self.lineBreakMode = UILineBreakModeCharacterWrap;
		[self setFrame:frame];
		[self textLayer].frame = frame;
    }
	[self textLayer].string = _attString;
}

// 设置某段字的颜色
- (void)setColor:(UIColor *)color fromIndex:(NSInteger)location length:(NSInteger)length{
    if (location < 0||location>self.text.length-1||length+location>self.text.length) {
        return;
    }
    [_attString addAttribute:(NSString *)kCTForegroundColorAttributeName
					   value:(id)color.CGColor
					   range:NSMakeRange(location, length)];
	[self textLayer].string = _attString;
}

// 设置某段字的字体
- (void)setFont:(UIFont *)font fromIndex:(NSInteger)location length:(NSInteger)length{
    if (location < 0||location>self.text.length-1||length+location>self.text.length) {
        return;
    }
    [_attString addAttribute:(NSString *)kCTFontAttributeName
					   value:(__bridge id)CTFontCreateWithName((__bridge CFStringRef)font.fontName,
													  font.pointSize,
													  NULL)
					   range:NSMakeRange(location, length)];
	[self textLayer].string = _attString;
}

// 设置某段字的风格
- (void)setStyle:(CTUnderlineStyle)style fromIndex:(NSInteger)location length:(NSInteger)length{
    if (location < 0||location>self.text.length-1||length+location>self.text.length) {
        return;
    }
    [_attString addAttribute:(NSString *)kCTUnderlineStyleAttributeName
					   value:(id)[NSNumber numberWithInt:style]
					   range:NSMakeRange(location, length)];
	[self textLayer].string = _attString;
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment
{
	switch (textAlignment) {
		case NSTextAlignmentCenter:
			[self textLayer].alignmentMode = kCAAlignmentCenter;
			break;
		case NSTextAlignmentLeft:
			[self textLayer].alignmentMode = kCAAlignmentLeft;
			break;
		case NSTextAlignmentRight:
			[self textLayer].alignmentMode = kCAAlignmentRight;
			break;
		default:
			[self textLayer].alignmentMode = kCAAlignmentNatural;
			break;
	}
	
}

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
	[self textLayer].backgroundColor = backgroundColor.CGColor;
	[self textLayer].string = _attString;
}

- (void)setFont:(UIFont *)font
{
	super.font = font;
	//set layer font
	CFStringRef fontName = (__bridge CFStringRef)font.fontName;
	CGFontRef fontRef = CGFontCreateWithFontName(fontName);
	[self textLayer].font = fontRef;
	[self textLayer].fontSize = font.pointSize;
	[self textLayer].string = _attString;
	CGFontRelease(fontRef);
}

- (void)setTextColor:(UIColor *)textColor
{
	super.textColor = textColor;
	//set layer text color
	[self textLayer].foregroundColor = textColor.CGColor;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

+ (CGFloat) heightForLabel: (UILabel *)label WithText: (NSString *) strText
{
	CGSize constraint = CGSizeMake(label.frame.size.width, CGFLOAT_MAX);
	if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0) {
		NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:label.font, NSFontAttributeName,nil];
		CGSize size;
		if ([strText length]) {
			size =[strText boundingRectWithSize:constraint options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:tdic context:nil].size;
		}else{
			size.width = 0.0f;
			size.height = 0.0f;
		}
        
		return ceil(size.height);
	}else{
		CGSize size = [strText sizeWithFont: label.font constrainedToSize:constraint lineBreakMode:label.lineBreakMode];
		return size.height;
	}
}

@end
