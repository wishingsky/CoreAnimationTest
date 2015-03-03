//
//  BasicAnimationtViewController.m
//  CoreAnimationTest
//
//  Created by willie_wei on 14-4-9.
//  Copyright (c) 2014年 willie_wei. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "BasicAnimationtViewController.h"

@interface BasicAnimationtViewController ()
{
	CALayer *kkLayer;
	//	CALayer *tempLayer;
	BOOL bTransform;
}

@end

@implementation BasicAnimationtViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		self.title = @"Basic Animationts";
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	kkLayer = [[CALayer alloc]init];
    kkLayer.backgroundColor = [[UIColor redColor]CGColor];
    kkLayer.frame = CGRectMake(50, 60, 40, 40);
    kkLayer.cornerRadius = 5;
    [self.view.layer addSublayer:kkLayer];
	    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//移动位置
- (IBAction)moveLayerPosition:(id)sender
{
	CABasicAnimation *animation  = [CABasicAnimation animationWithKeyPath:@"position"];
	animation.fromValue = [NSValue valueWithCGPoint:kkLayer.position];
	CGPoint toPoint = kkLayer.position;
	toPoint.x += 180;
	animation.toValue = [NSValue valueWithCGPoint:toPoint];
    animation.autoreverses = YES;// 完成后反向完成
    animation.duration = 3;
    animation.repeatCount = NSNotFound;
//	//改变图层实际的最后数据值
//	kkLayer.position = toPoint;// 记得更新图层树
	
    [kkLayer addAnimation:animation forKey:@"animationPosition"];
	
	/*要使动画产生永久性的效果，就需要更新图层的属性。
	 官方文档上将更新图层属性放在addAnimation之后，但是这样会出现动画开始之前一闪而过的情况,
	 原因是：当更新属性的时候，我们需要设置一个新的事务，并且禁用图层行为。否则动画会发生两次，一个是因为显式的CABasicAnimation，另一次是因为隐式动画。
	 正确做法需要用CATransaction来禁用隐式动画行为，否则默认的图层行为会干扰我们的显式动画*/
//	//改变图层实际的最后数据值
//	[CATransaction begin];
//	[CATransaction setDisableActions:YES];
//	kkLayer.position = toPoint;// 记得更新图层树
//	[CATransaction commit];
}

//缩放
- (IBAction)moveLayerScale:(id)sender
{
	// 对kkLayer进行放大缩小
	CABasicAnimation *scaoleAnimation  = [CABasicAnimation animationWithKeyPath:@"transform.scale.x"];
	scaoleAnimation.duration = 3;
    scaoleAnimation.autoreverses = YES;
	scaoleAnimation.fromValue = [NSNumber numberWithFloat:1.0];
	scaoleAnimation.toValue = [NSNumber numberWithFloat:2.5];
    scaoleAnimation.fillMode = kCAFillModeForwards;
    scaoleAnimation.repeatCount = NSNotFound;
    
    [kkLayer addAnimation:scaoleAnimation forKey:@"animationScale"];
	
	//更新图层树
//	CALayer * layer = kkLayer.presentationLayer ?:kkLayer;
//	scaoleAnimation.fromValue = [NSValue valueWithCATransform3D:layer.transform];
//	[CATransaction begin];
//	[CATransaction setDisableActions:YES];
//	kkLayer.transform = CATransform3DMakeScale(2.5, 1, 1);
//	[CATransaction commit];

}

//旋转
- (IBAction)moveLayerRotate:(id)sender
{
	// 以x轴进行旋转
	CABasicAnimation *rotateAnimation  = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
	rotateAnimation.fromValue = [NSNumber numberWithFloat:0.0];
	rotateAnimation.toValue = [NSNumber numberWithFloat:6.0 * M_PI];
    rotateAnimation.duration = 3;
    rotateAnimation.repeatCount = NSNotFound;
    
    [kkLayer addAnimation:rotateAnimation forKey:@"animationRotate"];
}

//淡化
- (IBAction)moveLayerOpacity:(id)sender
{
	CABasicAnimation* fadeAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
	fadeAnimation.fromValue = [NSNumber numberWithFloat:1.0];
	fadeAnimation.toValue = [NSNumber numberWithFloat:0.0];
	fadeAnimation.duration = 3.0;
	
	fadeAnimation.delegate = self;//通过animation的代理在动画结束后更新图层树
	/*CAAnimation实现了KVC（键-值-编码）协议，为了在animation的代理中区分动画,需要在此给动画打标签*/
	[fadeAnimation setValue:@"animationOpacity" forKey:@"animationType"];
	
	[kkLayer addAnimation:fadeAnimation forKey:@"animationOpacity"];
}

//组合动画
- (IBAction)moveLayer:(id)sender
{
	// 移动kkLayer的position
	CABasicAnimation *animation  = [CABasicAnimation animationWithKeyPath:@"position"];
	animation.fromValue = [NSValue valueWithCGPoint:kkLayer.position];
	CGPoint toPoint = kkLayer.position;
	toPoint.x += 180;
	animation.toValue = [NSValue valueWithCGPoint:toPoint];
	
    // 以x轴进行旋转
	CABasicAnimation *rotateAnimation  = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
	rotateAnimation.fromValue = [NSNumber numberWithFloat:0.0];
	rotateAnimation.toValue = [NSNumber numberWithFloat:6.0 * M_PI];
    
    // 对kkLayer进行放大缩小
	CABasicAnimation *scaoleAnimation  = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
	scaoleAnimation.duration = 3;
    scaoleAnimation.autoreverses = YES;
	scaoleAnimation.fromValue = [NSNumber numberWithFloat:1.0];
	scaoleAnimation.toValue = [NSNumber numberWithFloat:2.5];
    scaoleAnimation.fillMode = kCAFillModeForwards;
	
	//淡出
	CABasicAnimation* fadeAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
	fadeAnimation.fromValue = [NSNumber numberWithFloat:1.0];
	fadeAnimation.toValue = [NSNumber numberWithFloat:0.0];
	fadeAnimation.duration = 3.0;
	fadeAnimation.autoreverses = YES;

	// 把上面的动画组合起来
	CAAnimationGroup *group = [CAAnimationGroup animation];
	group.autoreverses = YES;  // 完成后反向完成
	group.duration = 3.0;
	group.animations = [NSArray arrayWithObjects:animation,rotateAnimation, scaoleAnimation, fadeAnimation, nil];
	group.repeatCount = NSNotFound;
    
    group.fillMode = kCAFillModeForwards;
	
	[kkLayer addAnimation:group forKey:@"kkLayerMove"];
}

//连接两个动画
/*动画的时间线的情况就不同了,当一个动画创建好,被加入到某个Layer的时候,会先被拷贝一份出来用于加入当前的图层,在CA事务被提交的时候,如果图层中的动画的beginTime为0,则beginTime会被设定为当前图层的当前时间,使得动画立即开始.如果你想某个直接加入图层的动画稍后执行,可以通过手动设置这个动画的beginTime,但需要注意的是这个beginTime需要为 CACurrentMediaTime()+延迟的秒数,因为beginTime是指其父级对象的时间线上的某个时间,这个时候动画的父级对象为加入的这个图层,图层当前的时间其实为[layer convertTime:CACurrentMediaTime() fromLayer:nil],其实就等于CACurrentMediaTime(),那么再在这个layer的时间线上往后延迟一定的秒数便得到上面的那个结果.*/
- (IBAction)moveLayerConnectionAnimation:(id)sender
{
	// 移动kkLayer的position
	CABasicAnimation *animation  = [CABasicAnimation animationWithKeyPath:@"position"];
	animation.fromValue = [NSValue valueWithCGPoint:kkLayer.position];
	CGPoint toPoint = kkLayer.position;
	toPoint.x += 180;
	animation.duration = 2;
	animation.toValue = [NSValue valueWithCGPoint:toPoint];
	kkLayer.position = toPoint;
	[kkLayer addAnimation:animation forKey:nil];
	
    // 以x轴进行旋转
	CABasicAnimation *rotateAnimation  = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
	rotateAnimation.fromValue = [NSNumber numberWithFloat:0.0];
	rotateAnimation.toValue = [NSNumber numberWithFloat:6.0 * M_PI];
	rotateAnimation.duration = 2;
	rotateAnimation.beginTime = CACurrentMediaTime()+2;
	kkLayer.transform = CATransform3DMakeRotation(6.0 * M_PI, 1, 0, 0);
	[kkLayer addAnimation:rotateAnimation forKey:nil];
}

//3D缩放
- (IBAction)moveLayerTransform3DScale:(id)sender
{
	CABasicAnimation *theAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    CATransform3D transform = CATransform3DMakeScale(1.5, 1.5, -1);  //x,y,z放大缩小倍数
    NSValue *value = [NSValue valueWithCATransform3D:transform];
    [theAnimation setToValue:value];
    
    transform = CATransform3DMakeScale(1.0, 1.0, 1.0);
    value = [NSValue valueWithCATransform3D:transform];
    [theAnimation setFromValue:value];
	
    [theAnimation setAutoreverses:YES];
    [theAnimation setDuration:3.0];
    [theAnimation setRepeatCount:NSNotFound];
    
	[kkLayer addAnimation:theAnimation forKey:nil];
}

//3D旋转
- (IBAction)moveLayerTransform3DRotation:(id)sender
{
	CABasicAnimation *theAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
	CATransform3D transform = CATransform3DMakeRotation((M_PI / 180.0) * 180.0f, -1.0f, 1.0f, 0.0f);
    NSValue *value = [NSValue valueWithCATransform3D:transform];
    [theAnimation setToValue:value];
    
    transform = CATransform3DIdentity;
    value = [NSValue valueWithCATransform3D:transform];
    [theAnimation setFromValue:value];
	
    [theAnimation setAutoreverses:YES];
    [theAnimation setDuration:2.0];
    [theAnimation setRepeatCount:NSNotFound];
    
	[kkLayer addAnimation:theAnimation forKey:nil];
}

//3D旋转+缩放+移动
- (IBAction)moveLayerTransform3D:(id)sender
{
	CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform"];
	CATransform3D rotateTransform = CATransform3DMakeRotation((M_PI / 180.0) * 45.0f, -1.0f, 1.0f, 0.0f);
    CATransform3D scaleTransform = CATransform3DMakeScale(1.5, 1.5, -1);
    CATransform3D positionTransform = CATransform3DMakeTranslation(150, 0, 0); //位置移动
    CATransform3D combinedTransform = CATransform3DConcat(rotateTransform, scaleTransform);
    combinedTransform = CATransform3DConcat(combinedTransform, positionTransform);
	
	[anim setFromValue:[NSValue valueWithCATransform3D:CATransform3DIdentity]]; //放在3D坐标系中最正的位置
    [anim setToValue:[NSValue valueWithCATransform3D:combinedTransform]];
    [anim setDuration:3.0f];

//	[kkLayer setTransform:combinedTransform];
	anim.delegate = self;
	[kkLayer addAnimation:anim forKey:nil];
}

//停止显式动画，注意：不能直接移除图层的隐式动画
- (IBAction)stopLayerAnimation:(id)sender
{
//	[kkLayer removeAnimationForKey:@"animationOpacity"];
	[kkLayer removeAllAnimations];
}

- (IBAction)pauseLayerAnimation:(id)sender
{
	[self pauseLayer:kkLayer];
}

- (IBAction)resumeLayerAnimation:(id)sender
{
	[self resumeLayer:kkLayer];
}

-(void)pauseLayer:(CALayer*)layer {
	CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime()
										 fromLayer:nil];
	layer.speed = 0.0;
	layer.timeOffset = pausedTime;
}


-(void)resumeLayer:(CALayer*)layer {
	CFTimeInterval pausedTime = [layer timeOffset];
	layer.speed = 1.0;
	layer.timeOffset = 0.0;
	layer.beginTime = 0.0;
	CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime()
											 fromLayer:nil] - pausedTime;
	layer.beginTime = timeSincePause;
}

- (void)animationDidStop:(CABasicAnimation *)anim finished:(BOOL)flag
{
	/*因为所有的动画都会调用同一个回调方法，所以就要区分动画
	 在-addAnimation:forKey:的时候给动画指定了唯一标识，但是在代理中通过-animationForKey:却获取不到动画，为什么？*/
//	CAAnimation *animation = [kkLayer animationForKey:@"animationOpacity"];
	if ([[anim valueForKey:@"animationType"] isEqualToString:@"animationOpacity"]) {
		[CATransaction begin];
		[CATransaction setDisableActions:YES];
		kkLayer.opacity = 0.0;
		[CATransaction commit];
	}
}
/*总结：在动画之前更新图层属性比在动画结束之后更新属性更加方便*/
@end
