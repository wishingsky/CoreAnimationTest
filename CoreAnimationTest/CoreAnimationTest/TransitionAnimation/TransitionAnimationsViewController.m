//
//  TransitionAnimationsViewController.m
//  CoreAnimationTest
//
//  Created by willie_wei on 14-4-14.
//  Copyright (c) 2014年 willie_wei. All rights reserved.
//

#import "TransitionAnimationsViewController.h"

@interface TransitionAnimationsViewController ()
{
	int _number;
}

@end

@implementation TransitionAnimationsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		self.title = @"Transition Animations";
		_number = 0;
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(60, 20, 200, 200)];
	label.backgroundColor = [UIColor greenColor];
	label.textAlignment = NSTextAlignmentCenter;
	label.font = [UIFont boldSystemFontOfSize:32];
	[label setText:[NSString stringWithFormat:@"%d",_number]];
	[label setTag:101];
	[self.view addSubview:label];
	// Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doUIViewAnimation:(id)sender{
	[UIView beginAnimations:@"animationID" context:nil];
	[UIView setAnimationDuration:0.5f];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationRepeatAutoreverses:NO];
	
	/*typedef NS_ENUM(NSInteger, UIViewAnimationTransition) {
     UIViewAnimationTransitionNone,
	 UIViewAnimationTransitionFlipFromLeft, 左侧翻转
	 UIViewAnimationTransitionFlipFromRight,右侧翻转
	 UIViewAnimationTransitionCurlUp,       向上翻页
	 UIViewAnimationTransitionCurlDown,     向下翻页
	 };
	*/
	
	[UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.view cache:YES];
	[self.view exchangeSubviewAtIndex:1 withSubviewAtIndex:0];
	[UIView commitAnimations];
	
	_number ++;
	UILabel *label = (UILabel*)[self.view viewWithTag:101];
	[label setText:[NSString stringWithFormat:@"%d",_number]];
}

- (IBAction)doPublicCATransition:(id)sender{
	CATransition *animation = [CATransition animation];
	animation.startProgress = 0;
	animation.endProgress = 1;
    animation.duration = 0.5f;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
	animation.fillMode = kCAFillModeForwards;
	
	/*
	 kCATransitionFade;
	 kCATransitionMoveIn;
	 kCATransitionPush;
	 kCATransitionReveal;
	 */
	/*
	 kCATransitionFromRight;
	 kCATransitionFromLeft;
	 kCATransitionFromTop;
	 kCATransitionFromBottom;
	 */
	animation.type = kCATransitionPush;
	animation.subtype = kCATransitionFromRight;
		
	[self.view.layer addAnimation:animation forKey:@"animation"];
	
	_number ++;
	UILabel *label = (UILabel*)[self.view viewWithTag:101];
	[label setText:[NSString stringWithFormat:@"%d",_number]];
}

- (IBAction)doPrivateCATransition:(id)sender{
	//http://www.iphonedevwiki.net/index.php?title=UIViewAnimationState
	/*
	 Don't be surprised if Apple rejects your app for including those effects,
	 and especially don't be surprised if your app starts behaving strangely after an OS update.
	 */
	CATransition *animation = [CATransition animation];
	animation.startProgress = 0;
	animation.endProgress = 1;
    animation.delegate = self;
    animation.duration = 0.5f;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
	animation.fillMode = kCAFillModeForwards;
	animation.removedOnCompletion = NO;
	
	/*私有的类型的动画类型：
	 立方体、吸收、翻转、波纹、翻页、反翻页、镜头开、镜头关
	 animation.type = @"cube"
	 animation.type = @"suckEffect";
	 animation.type = @"oglFlip";//不管subType is "fromLeft" or "fromRight",official只有一种效果
	 animation.type = @"rippleEffect";
	 animation.type = @"pageCurl";
	 animation.type = @"pageUnCurl"
	 animation.type = @"cameraIrisHollowOpen ";
	 animation.type = @"cameraIrisHollowClose "; 
	 */
	
	animation.type = @"suckEffect";
	animation.subtype = kCATransitionFromTop;
	[self.view.layer addAnimation:animation forKey:@"animation"];
	[self.view exchangeSubviewAtIndex:1 withSubviewAtIndex:0];//Just remove, not release or dealloc
	
	_number ++;
	UILabel *label = (UILabel*)[self.view viewWithTag:101];
	[label setText:[NSString stringWithFormat:@"%d",_number]];
}

- (IBAction)animatingLayerAttachedToView:(id)sender
{
	/*基于视图的动画块内部的隐式动画的时间取决于动画块所设定的时间，即使通过CATransaction设置隐式动画的动画时间也不起作用
	 动画块内部的显示动画的时间不受外部动画块所设时间影响，动画会按照显示动画所设时间进行动画*/
	[UIView animateWithDuration:5.0 animations:^{
		// Change the opacity implicitly.
		self.view.layer.opacity = 0.0;
		// Change the position explicitly.
		CABasicAnimation *rotateAnimation  = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
		rotateAnimation.fromValue = [NSNumber numberWithFloat:0.0];
		rotateAnimation.toValue = [NSNumber numberWithFloat:6.0 * M_PI];
		rotateAnimation.duration = 5.0;
		[self.view.layer addAnimation:rotateAnimation forKey:@"AnimateFrame"];
	}];
}
@end
