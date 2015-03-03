//
//  ImplicitAnimationsViewController.m
//  CoreAnimationTest
//
//  Created by willie_wei on 14-4-9.
//  Copyright (c) 2014年 willie_wei. All rights reserved.
//

#import "ImplicitAnimationsViewController.h"

@interface ImplicitAnimationsViewController ()
{
	CALayer *_layer;
//	CALayer *tempLayer;
	BOOL bTransform;
}

@end

@implementation ImplicitAnimationsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		self.title = @"Implicit Animations";
		bTransform = YES;
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	_layer = [CALayer layer];
	[_layer setFrame:CGRectMake(60.0, 30.0, 200.0, 200.0)];
    [_layer setBackgroundColor:[UIColor blueColor].CGColor];
	[self.view.layer addSublayer:_layer];
	
//	tempLayer = [CALayer layer];
//	[tempLayer setFrame:CGRectMake(30.0, 60.0, 200.0, 200.0)];
//    [tempLayer setBackgroundColor:[UIColor redColor].CGColor];
//	[self.view.layer addSublayer:tempLayer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changeRoundCorners:(id)sender {
    [CATransaction setAnimationDuration:1];
    
    [_layer setCornerRadius:([_layer cornerRadius] == 0.0 ? 25.0 : 0.0)];
}

- (IBAction)changeColor:(id)sender {
    [CATransaction setAnimationDuration:1];
    
    [_layer setBackgroundColor:([_layer backgroundColor] == [UIColor blueColor].CGColor ? [UIColor greenColor].CGColor : [UIColor blueColor].CGColor)];
}

- (IBAction)changeBorder:(id)sender {
    [CATransaction setAnimationDuration:1];
	
    [_layer setBorderWidth:([_layer borderWidth] == 0.0 ? 10 : 0.0)];
}

- (IBAction)changeOpacity:(id)sender {
    [CATransaction setAnimationDuration:1];
    
    [_layer setOpacity:([_layer opacity] == 1.0 ? 0.2 : 1.0)];
}

- (IBAction)changeSize:(id)sender
{
    [CATransaction setAnimationDuration:1];
    
    CGRect layerBounds = _layer.bounds;
    layerBounds.size.width  = (layerBounds.size.width == layerBounds.size.height) ? 250.0 : 200.0;
    [_layer setBounds:layerBounds];
}

- (IBAction)changeAll:(id)sender {
	
    [self changeBorder:nil];
    [self changeColor:nil];
    [self changeOpacity:nil];
    [self changeRoundCorners:nil];
    [self changeSize:nil];
}

/*仿射变换*/
- (IBAction)changeAffineTransform:(id)sender
{
	[CATransaction setAnimationDuration:1];
	if (bTransform) {
		CGAffineTransform transform = CGAffineTransformIdentity; //scale by 50%
		transform = CGAffineTransformScale(transform, 0.5, 0.5); //rotate by 30 degrees
		transform = CGAffineTransformRotate(transform, M_PI / 180.0 * 30.0); //translate by 200 points
		transform = CGAffineTransformTranslate(transform, 200, 0);
		_layer.affineTransform = transform;
		bTransform = NO;
	}else{
		_layer.affineTransform = CGAffineTransformIdentity;
		bTransform = YES;
	}
}
/*
 CATransform3D结构成员的意义。
 
 struct
 
 CATransform3D
 {
     CGFloat  m11（x缩放）, m12（y切变）, m13（旋转）,  m14（）;
 
     CGFloat  m21（x切变）, m22（y缩放）, m23（）,     m24（）;
 
     CGFloat  m31（旋转）,  m32（）,     m33（）,     m34（透视效果，要操作的这个对象要有旋转的角度，否则没有效果。正直/负值都有意义）;
 
     CGFloat  m41（x平移）, m42（y平移）, m43（z平移）, m44（）;
 };
 */

- (IBAction)changeTransformRotation:(id)sender
{
	[CATransaction setAnimationDuration:1];
	if (bTransform) {
		/*沿着x,y,z所构成的向量旋转响应角度， x,y,z值的大小对旋转没有影响，其正负会有影响，因为正负决定了向量的方向
        */
		_layer.transform = CATransform3DMakeRotation((M_PI / 180.0) * 45.0f, 0.0f, 1.0f, 0.0f);
		bTransform = NO;
		/*当只对简单的Core Animation显示层使用一个平行投影，平行投影本质上是将场景扁平化到二维平面。该默认行为引起相同尺寸不同zPosition的图层显式的尺寸相同，即使是图层离z坐标很远。你一般在三维场景中会有一个透视的检视口。你可以通过更改图层的变换矩阵改变这个行为，让动画包含透视信息。
		 当更改一个场景的透视，你需要更改包含被观察的图层的父图层的sublayerTransform矩阵。更改父图层简化了你需要给所有子图层应用透视信息的代码。同时也保证了透视信息被正确的应用给不同平面互相覆盖的同胞子图层。以下是为父图层创建简单透视变换的方式。自定义eyePosition变量是沿着z坐标从观察点到视图图层相对距离。通常为eyePosition指定一个正数让图层按照预期的方式调整。eyePosition越大，结果则是一个更加扁平的场景，而值越小将引起图层间更加戏剧性的视觉表现*/
		
		/*为父图层创建透视变换*/
		CATransform3D perspective = CATransform3DIdentity;
		CGFloat eyePosition = 800;
		perspective.m34 = -1.0/eyePosition;
		self.view.layer.sublayerTransform = perspective;
		
		/*直接对图层进行透视变换*/
//		CATransform3D rotation = CATransform3DMakeRotation((M_PI / 180.0) * 45.0f, 1.0f, 0.0f, 0.0f);
//		_layer.transform = CATransform3DPerspect(rotation, CGPointMake(0, 0), 200);
	
	}else{
		_layer.transform = CATransform3DIdentity;
		bTransform = YES;
	}
}

- (IBAction)changeTransformScale:(id)sender
{
	[CATransaction setAnimationDuration:1];
	
	if (bTransform) {
		/*x,y,z 分别表示沿X轴,Y轴和Z轴方向缩放的比例，当某个值为负时，发生沿相应坐标轴的对称等比变换。*/
		_layer.transform = CATransform3DMakeScale(0.5, 0.5, 2);
		bTransform = NO;
	}else{
		_layer.transform = CATransform3DIdentity;
		bTransform = YES;
	}
}

- (IBAction)changeTransformPosition:(id)sender
{
	[CATransaction setAnimationDuration:1];
	
	if (bTransform) {
		/*沿着x,y,z 构成的向量方向移动相应的像素，x为正，向右移动；为负，向左移动；
											y为正，向下移动；为负，向上移动；
											z为正，向前移动；为负，向后移动。*/
		_layer.transform = CATransform3DMakeTranslation(50, 0, 0);
//		tempLayer.transform = CATransform3DIdentity;
		bTransform = NO;
	}else{
		_layer.transform = CATransform3DIdentity;
//		tempLayer.transform = CATransform3DMakeTranslation(0, 0, 50);
		bTransform = YES;
	}
}

- (IBAction)changeTransformAll:(id)sender
{
	[CATransaction setAnimationDuration:1];
	
	if (bTransform) {
		CATransform3D rotateTransform = CATransform3DMakeRotation((M_PI / 180.0) * 180.0f, -1.0f, 1.0f, 0.0f);//旋转
		CATransform3D scaleTransform = CATransform3DMakeScale(0.5, 0.5, 1);//缩放
		CATransform3D positionTransform = CATransform3DMakeTranslation(50, 0, 0); //位置移动
		CATransform3D combinedTransform = CATransform3DConcat(rotateTransform, scaleTransform); //先合并两个动画
		combinedTransform = CATransform3DConcat(combinedTransform, positionTransform); //再combine一次把三个动作连起来
		_layer.transform = combinedTransform;
		bTransform = NO;
	}else{
		_layer.transform = CATransform3DIdentity;
		bTransform = YES;
	}

}

//透视投影
/*CALayer默认使用正交投影，因此没有远小近大效果，而且没有明确的API可以使用透视投影矩阵。所幸可以通过矩阵连乘自己构造透视投影矩阵。构造透视投影矩阵的代码如下*/
CATransform3D CATransform3DMakePerspective(CGPoint center, float disZ)
{
	CATransform3D transToCenter = CATransform3DMakeTranslation(-center.x, -center.y, 0);
	CATransform3D transBack = CATransform3DMakeTranslation(center.x, center.y, 0);
	CATransform3D scale = CATransform3DIdentity;
	scale.m34 = -1.0f/disZ;
	return CATransform3DConcat(CATransform3DConcat(transToCenter, scale), transBack);
}

CATransform3D CATransform3DPerspect(CATransform3D t, CGPoint center, float disZ)
{
	return CATransform3DConcat(t, CATransform3DMakePerspective(center, disZ));
}

/*对图层属性的每次更改都是事务的一部分。CATransaction类管理动画的创建和分组并在适当的时间执行动画。在大部分情况下，你不需要创建你自己的事务。无论什么时候，给图层添加显式或隐式动画，Core Animation会自动创建一个隐式事务。然而你也可以创建显式事务以能够更精确的管理动画。
 
 使用CATransaction类提供的方法创建与管理事务。通过调用begin类方法,可以开始（或隐式地创建）一个新的事务；调用commit类方法可结束一个事务。两个方法之间的代码就是作为事务部分的变化*/
//事务嵌套
- (IBAction)nestingExplicitTransactions:(id)sender
{
	[CATransaction begin]; // Outer transaction
	[CATransaction setValue:[NSNumber numberWithFloat:2.0f]
					 forKey:kCATransactionAnimationDuration];
	// Move the layer to a new position
	_layer.position = CGPointMake(0.0,0.0);
	[CATransaction begin]; // Inner transaction
	[CATransaction setValue:[NSNumber numberWithFloat:5.0f]
					 forKey:kCATransactionAnimationDuration];
	_layer.opacity=0.0;
	[CATransaction commit]; // Inner transaction
	[CATransaction commit]; // Outer transaction
}

- (IBAction)testCompletionBlock:(id)sender
{
	[CATransaction begin];
    [CATransaction setAnimationDuration:2.0];
    [CATransaction setCompletionBlock:^{
		[CATransaction setAnimationDuration:3.0];
        CGAffineTransform transform = _layer.affineTransform;
        transform = CGAffineTransformRotate(transform, M_PI_2);
        _layer.affineTransform = transform;
    }];
    _layer.backgroundColor = [UIColor redColor].CGColor;
    [CATransaction commit];
}
@end
