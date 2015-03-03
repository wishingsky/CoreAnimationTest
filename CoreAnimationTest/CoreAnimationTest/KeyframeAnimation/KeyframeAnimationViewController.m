//
//  KeyframeAnimationViewController.m
//  CoreAnimationTest
//
//  Created by willie_wei on 14-4-11.
//  Copyright (c) 2014年 willie_wei. All rights reserved.
//

#import "KeyframeAnimationViewController.h"

@interface KeyframeAnimationViewController ()
{
	CALayer *_theLayer;
}

@end

@implementation KeyframeAnimationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		self.title = @"Keyframe Animations";
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	_theLayer = [[CALayer alloc]init];
    _theLayer.backgroundColor = [[UIColor blueColor] CGColor];
    _theLayer.frame = CGRectMake(10, 30, 20, 20);
    _theLayer.cornerRadius = 10;
    [self.view.layer addSublayer:_theLayer];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changePosition:(id)sender
{
	CGMutablePathRef thePath = CGPathCreateMutable();
	CGPathMoveToPoint(thePath,NULL,10.0,30.0);//设置动画起点
	CGPathAddCurveToPoint(thePath,NULL,10.0,300.0,150.0,300.0,150.0,30.0);
	CGPathAddCurveToPoint(thePath,NULL,150.0,300.0,300.0,300.0,300.0,30.0);
	CAKeyframeAnimation * theAnimation;
	//创建一个动画对象，指定位置属性作为键路径
	theAnimation=[CAKeyframeAnimation animationWithKeyPath:@"position"];
	theAnimation.path=thePath;
	theAnimation.duration=4.0;
	CGPathRelease(thePath);
	
	//更新图层树
//	_theLayer.position = CGPointMake(300, 30);
	
	// 为图层添加动画
	[_theLayer addAnimation:theAnimation forKey:nil];
}

- (IBAction)changePosition1:(id)sender
{
	CGMutablePathRef thePath = CGPathCreateMutable();
	CGPathMoveToPoint(thePath,NULL,10.0,30.0);//设置动画起点
	CGPathAddCurveToPoint(thePath,NULL,85.0,30.0,85.0,30.0,85.0,300.0);
	CGPathAddCurveToPoint(thePath,NULL,85.0,30.0,235.0,30.0,235.0,300.0);
	CGPathAddCurveToPoint(thePath,NULL,235.0,30.0,235.0,30.0,310.0,30.0);
	CAKeyframeAnimation * theAnimation;
	//创建一个动画对象，指定位置属性作为键路径
	theAnimation=[CAKeyframeAnimation animationWithKeyPath:@"position"];
	theAnimation.path=thePath;
	theAnimation.duration=4.0;
	CGPathRelease(thePath);
	
	//更新图层树
	//	_theLayer.position = CGPointMake(300, 30);
	
	// 为图层添加动画
	[_theLayer addAnimation:theAnimation forKey:nil];
}

- (IBAction)changeAnimationGroup:(id)sender
{
//	[_theLayer setFrame:CGRectMake(100, 30, 100, 100)];
//	_theLayer.cornerRadius = 50;
	CAKeyframeAnimation* widthAnim = [CAKeyframeAnimation animationWithKeyPath:@"borderWidth"];
	NSArray* widthValues = [NSArray arrayWithObjects:@1.0, @10.0, @5.0, @30.0, @0.5,@15.0, @2.0, @50.0, @0.0, nil];
	widthAnim.values = widthValues;
	widthAnim.calculationMode = kCAAnimationPaced;
	// Animation 2
	CAKeyframeAnimation* colorAnim = [CAKeyframeAnimation animationWithKeyPath:@"borderColor"];
	NSArray*colorValues=[NSArray arrayWithObjects:(id)[UIColor greenColor].CGColor,(id)[UIColor redColor].CGColor,(id)[UIColor blueColor].CGColor, nil];
	colorAnim.values = colorValues;
	colorAnim.calculationMode = kCAAnimationPaced;
	// Animation group
	CAAnimationGroup* group = [CAAnimationGroup animation];
	group.animations = [NSArray arrayWithObjects:colorAnim, widthAnim, nil];
	group.duration = 5.0;
	group.fillMode = kCAFillModeBackwards;
	[_theLayer addAnimation:group forKey:@"BorderChanges"];
	
	CGMutablePathRef thePath = CGPathCreateMutable();
	CGPathMoveToPoint(thePath,NULL,10.0,30.0);//设置动画起点
	CGPathAddCurveToPoint(thePath,NULL,85.0,30.0,85.0,30.0,85.0,300.0);
	CGPathAddCurveToPoint(thePath,NULL,85.0,30.0,235.0,30.0,235.0,300.0);
	CGPathAddCurveToPoint(thePath,NULL,235.0,30.0,235.0,30.0,310.0,30.0);
	CAKeyframeAnimation * theAnimation;
	//创建一个动画对象，指定位置属性作为键路径
	theAnimation=[CAKeyframeAnimation animationWithKeyPath:@"position"];
	theAnimation.path=thePath;
	theAnimation.duration=4.0;
	theAnimation.fillMode = kCAFillModeForwards;
	theAnimation.beginTime = CACurrentMediaTime()+5.0;
	CGPathRelease(thePath);
	
	//更新图层树
	//	_theLayer.position = CGPointMake(300, 30);
	
	// 为图层添加动画
	[_theLayer addAnimation:theAnimation forKey:nil];
}
@end
