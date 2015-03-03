//
//  LayerLabel.m
//  CoreAnimationTest
//
//  Created by willie_wei on 14-5-14.
//  Copyright (c) 2014年 willie_wei. All rights reserved.
//

#import "LayerLabel.h"

@implementation LayerLabel

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
	//called when creating label using Interface Builder
	[self setUp];
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

- (void)setUp
{
	//set defaults from UILabel settings
	self.text = self.text;
	self.textColor = self.textColor;
	self.font = self.font;
	self.backgroundColor = self.backgroundColor;
	
	//we should really derive these from the UILabel settings too
	//but that's complicated, so for now we'll just hard-code them
	[self textLayer].alignmentMode = kCAAlignmentJustified;
	[self textLayer].wrapped = YES;
	[self.layer display];
}

- (void)setText:(NSString *)text
{
	super.text = text;
	//set layer text
	[self textLayer].string = text;
}

- (void)setTextColor:(UIColor *)textColor
{
	super.textColor = textColor;
	//set layer text color
	[self textLayer].foregroundColor = textColor.CGColor;
}

- (void)setFont:(UIFont *)font
{
	super.font = font;
	//set layer font
	CFStringRef fontName = (__bridge CFStringRef)font.fontName;
	CGFontRef fontRef = CGFontCreateWithFontName(fontName);
	[self textLayer].font = fontRef;
	[self textLayer].fontSize = font.pointSize;
	
	CGFontRelease(fontRef);
}

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
	super.backgroundColor = backgroundColor;
	[self textLayer].backgroundColor = backgroundColor.CGColor;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
