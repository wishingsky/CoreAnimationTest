//
//  CAShapeLayerViewController.m
//  CoreAnimationTest
//
//  Created by willie_wei on 14-5-14.
//  Copyright (c) 2014年 willie_wei. All rights reserved.
//

#import "CAShapeLayerViewController.h"

@interface CAShapeLayerViewController ()

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIView *containerView2;
@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@end

@implementation CAShapeLayerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		self.title = @"CAShapeLayer";
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	//http://blog.csdn.net/crayondeng/article/details/11093689
	
	UIBezierPath *path = [[UIBezierPath alloc] init];
	[path moveToPoint:CGPointMake(175, 100)];
	
	[path addArcWithCenter:CGPointMake(150, 100) radius:25 startAngle:0 endAngle:2*M_PI clockwise:YES];
	[path moveToPoint:CGPointMake(150, 125)];
	[path addLineToPoint:CGPointMake(150, 175)];
	[path addLineToPoint:CGPointMake(125, 225)];
	[path moveToPoint:CGPointMake(150, 175)];
	[path addLineToPoint:CGPointMake(175, 225)];
	[path moveToPoint:CGPointMake(100, 150)];
	[path addLineToPoint:CGPointMake(200, 150)];
	[path addQuadCurveToPoint:CGPointMake(100, 150) controlPoint:CGPointMake(150, 300)];
	[path addCurveToPoint:CGPointMake(150, 25) controlPoint1:CGPointMake(100, 75) controlPoint2:CGPointMake(125, 100)];
	[path addCurveToPoint:CGPointMake(200, 150) controlPoint1:CGPointMake(175, 100) controlPoint2:CGPointMake(200, 75)];
	//create shape layer
	_shapeLayer = [CAShapeLayer layer];
	_shapeLayer.strokeColor = [UIColor redColor].CGColor;
	_shapeLayer.fillColor = [UIColor clearColor].CGColor;
	_shapeLayer.lineWidth = 5;
	_shapeLayer.lineJoin = kCALineJoinRound;
	_shapeLayer.lineCap = kCALineCapRound;
	_shapeLayer.path = path.CGPath;
	//add it to our view
	[self.containerView.layer addSublayer:_shapeLayer];
	
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changeStrokeEnd:(id)sender
{
	CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 3.0;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    [_shapeLayer addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
    
    _shapeLayer.strokeEnd = 1.0;
}

- (IBAction)changeCorner:(id)sender
{
	CGRect rect = CGRectMake(70, 30, 100, 100);
	CGSize radii = CGSizeMake(20, 20);
	UIRectCorner corners = UIRectCornerTopRight | UIRectCornerBottomRight | UIRectCornerBottomLeft;
	//create path
	UIBezierPath *aPath = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:radii];
	CAShapeLayer *shapeLayer = [CAShapeLayer layer];
	shapeLayer.strokeColor = [UIColor redColor].CGColor;
	shapeLayer.fillColor = [UIColor clearColor].CGColor;
	shapeLayer.lineJoin = kCALineJoinRound;
	shapeLayer.lineCap = kCALineCapRound;
	shapeLayer.lineWidth = 5;
	shapeLayer.path = aPath.CGPath;
	[self.containerView2.layer addSublayer:shapeLayer];

}
@end
