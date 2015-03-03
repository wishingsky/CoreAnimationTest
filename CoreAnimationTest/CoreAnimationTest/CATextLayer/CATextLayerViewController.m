//
//  CATextLayerViewController.m
//  CoreAnimationTest
//
//  Created by willie_wei on 14-5-14.
//  Copyright (c) 2014年 willie_wei. All rights reserved.
//

#import "CATextLayerViewController.h"
#import <CoreText/CoreText.h>
#import "WCCAttributedLabel.h"

@interface CATextLayerViewController ()
@property (weak, nonatomic) IBOutlet UIView *labelView;
@property (weak, nonatomic) IBOutlet WCCAttributedLabel *attributedLabel;

@end

@implementation CATextLayerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		self.title = @"CATextLayer";
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//	CATextLayer *textLayer = [CATextLayer layer];
//	textLayer.frame = self.labelView.bounds;
//	textLayer.contentsScale = [UIScreen mainScreen].scale;
//	[self.labelView.layer addSublayer:textLayer];
//	
//	//set text attributes
//	textLayer.alignmentMode = kCAAlignmentJustified;
//	textLayer.wrapped = YES;
//	
//	//choose a font
//	UIFont *font = [UIFont systemFontOfSize:15];
//	
//	//choose some text
//	NSString *text = @"爽歪歪给我个如果给他人合格水果为各位各位给水果为各位各位给十多个外挂外挂嘎嘎嘎好";
//	
//	//create attributed string
//	NSMutableAttributedString *string = nil;
//	string = [[NSMutableAttributedString alloc] initWithString:text];
//	
//	//convert UIFont to a CTFont
//	CFStringRef fontName = (__bridge CFStringRef)font.fontName;
//	CGFloat fontSize = font.pointSize;
//	CTFontRef fontRef = CTFontCreateWithName(fontName, fontSize, NULL);
//	
//	//set text attributes
//	NSDictionary *attribs = @{
//							  (__bridge id)kCTForegroundColorAttributeName:(__bridge id)[UIColor blackColor].CGColor,
//							  (__bridge id)kCTFontAttributeName: (__bridge id)fontRef
//							  };
//	
//	[string setAttributes:attribs range:NSMakeRange(0, [text length])];
//	attribs = @{
//				(__bridge id)kCTForegroundColorAttributeName: (__bridge id)[UIColor redColor].CGColor,
//				(__bridge id)kCTUnderlineStyleAttributeName: @(kCTUnderlineStyleSingle),
//				(__bridge id)kCTFontAttributeName: (__bridge id)fontRef
//				};
//	[string setAttributes:attribs range:NSMakeRange(15, 7)];
//	
//	//release the CTFont we created earlier
//	CFRelease(fontRef);
//	
//	//set layer text
//	textLayer.string = string;    // Do any additional setup after loading the view from its nib.
	
//	WCCAttributedLabel *layerLabel = [[WCCAttributedLabel alloc] initWithFrame:CGRectMake(10, 300, 200, 21)];
//	layerLabel.text = @"尚未完工五个五个个人个人";
////	layerLabel.backgroundColor = [UIColor blueColor];
//	layerLabel.textAlignment = NSTextAlignmentCenter;
//	[layerLabel setColor:[UIColor redColor] fromIndex:1 length:2];
//	[self.view addSubview:layerLabel];
	
	_attributedLabel.text = @"尚未完工五个五个个人sgw额呵呵然后让他回头恶化特好听我给他问过突然给他人感染人工外国人文化融合";
//	_attributedLabel.textAlignment = NSTextAlignmentRight;
	
	_attributedLabel.backgroundColor = [UIColor greenColor];
	[_attributedLabel setColor:[UIColor redColor] fromIndex:1 length:2];
	[_attributedLabel setFont:[UIFont systemFontOfSize:15.0f] fromIndex:3 length:2];
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
