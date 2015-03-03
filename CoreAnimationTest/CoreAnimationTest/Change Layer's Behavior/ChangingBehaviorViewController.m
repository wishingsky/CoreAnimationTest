//
//  ChangingBehaviorViewController.m
//  CoreAnimationTest
//
//  Created by willie_wei on 14-4-22.
//  Copyright (c) 2014年 willie_wei. All rights reserved.
//

#import "ChangingBehaviorViewController.h"

@interface ChangingBehaviorViewController ()
{
	CALayer *_layer;
	BOOL bChange;
}

@end

@implementation ChangingBehaviorViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		self.title = @"Changing a Layer’s Default Behavior";
		bChange = YES;
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	_layer = [CALayer layer];
	[_layer setFrame:CGRectMake(60.0, 30.0, 200.0, 200.0)];
	[self.view.layer addSublayer:_layer];
	[_layer setBackgroundColor:[UIColor blueColor].CGColor];
    /* 1. 使用图片为图层提供内容*/
//	CGImageRef theImage = [[UIImage imageNamed:@"Icon-120.png"] CGImage];
//	_layer.contents = (__bridge id)(theImage);
	
	/*2. 使用代理提供图层的内容,displayLayer:或drawLayer:inContext:
	 如果图层的内容是动态改变的，你可以使用一个代理对象在需要的时候提供图层并更新内容。图层显示的时候，图层调用你的代理方法以提供需要的内容
	 实现委托重绘的方法并不意味会自动的触发图层使用实现的方法来重绘内容。而是你要显式的告诉一个图层实例来重新缓存内容，通过发送以下任何一个方法setNeedsDisplay或者setNeedsDisplayInRect:的消息，或者把图层的needsDisplayOnBoundsChange属性值设置为YES。*/
	_layer.delegate = self;
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
	_layer.delegate = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changeContents:(id)sender
{
	[_layer setNeedsDisplay];
	[_layer setValue:[NSNumber numberWithBool:bChange] forKey:@"state"];
	bChange = !bChange;
}

- (IBAction)changeOpacity:(id)sender
{
	[_layer setOpacity:([_layer opacity] == 1.0 ? 0.2 : 1.0)];
}

- (IBAction)changeDefaultBehavior:(id)sender {
    _layer.actions = [NSDictionary dictionaryWithObjectsAndKeys:_layer.delegate, @"test", nil];
	//实际触发的地方，当设置test参数，其实最后触发的是runActionForKey种的立方体旋转
	[_layer setValue:[NSNumber numberWithInt:19] forKey:@"test"];
}

#pragma mark - CALayer delegate

-(void)runActionForKey:(NSString *)event object:(id)anObject arguments:(NSDictionary *)dict{
	NSLog(@"runActionForKey:\"%@\" object:%@ arguments:%@", event, anObject, dict);
	CATransition *theAnimation=nil;
	if([event isEqualToString:@"test"]){
		theAnimation=[CATransition animation];
		theAnimation.duration=2;
		theAnimation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
		theAnimation.type=@"cube";
		theAnimation.subtype=kCATransitionFromRight;
	}
	
	[(CALayer*)anObject addAnimation:theAnimation forKey:nil];
}

/*重载隐式动画
 你可以为行为标识符提供隐式的动画，通过插入一个CAAnimation的实例到style字典里面的actions的字典里面，通过实现委托方法 actionForLayer:forKey:或者继承图层类并重载defaultActionForKey:方法返回一个相应的行为对象*/
- (id<CAAction>)actionForLayer:(CALayer *)theLayer forKey:(NSString *)theKey
{
    CATransition *theAnimation=nil;
	
	if ([theKey isEqualToString:kCAOnOrderIn]){
		theAnimation = [[CATransition alloc] init];
        theAnimation.duration = 2.0;
        theAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        theAnimation.type = @"pageUnCurl";
        theAnimation.subtype = kCATransitionFromTop;
	}
	
    if ([theKey isEqualToString:@"contents"])
    {
		theAnimation = [[CATransition alloc] init];
        theAnimation.duration = 2.0;
        theAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        theAnimation.type = @"rippleEffect";
        theAnimation.subtype = kCATransitionFromTop;
    }
	
	if ([theKey isEqualToString:@"opacity"]) {
		theAnimation = [[CATransition alloc] init];
        theAnimation.duration = 2.0;
        theAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        theAnimation.type = @"oglFlip";
        theAnimation.subtype = kCATransitionFromTop;
	}
	
    return theAnimation;
}

- (void)displayLayer:(CALayer *)theLayer
{
    // check the value of the layer's state key
    if ([[theLayer valueForKey:@"state"] boolValue])
    {
        // display the yes image
        theLayer.contents=(__bridge id)([self loadStateYesImage]);
		theLayer.contentsGravity = kCAGravityCenter;
		theLayer.shadowColor = [UIColor blackColor].CGColor;
		theLayer.shadowOpacity = 0.5;
		theLayer.shadowOffset = CGSizeMake(-5, 5);
		theLayer.shadowRadius = 10;
    }
    else {
        // display the no image
        theLayer.contents=(__bridge id)([self loadStateNoImage]);
		theLayer.contentsGravity = kCAGravityResizeAspect;
    }
}

- (CGImageRef)loadStateYesImage
{
	CGImageRef theImage = [[UIImage imageNamed:@"Icon-120.png"] CGImage];
	return theImage;
}

- (CGImageRef)loadStateNoImage
{
	CGImageRef theImage = [[UIImage imageNamed:@"Default.png"] CGImage];
	return theImage;
}
@end
