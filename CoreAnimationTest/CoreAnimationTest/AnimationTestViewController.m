//
//  AnimationTestViewController.m
//  CoreAnimationTest
//
//  Created by willie_wei on 14-4-9.
//  Copyright (c) 2014年 willie_wei. All rights reserved.
//

#import "AnimationTestViewController.h"
#import "ImplicitAnimationsViewController.h"
#import "BasicAnimationtViewController.h"
#import "KeyframeAnimationViewController.h"
#import "TransitionAnimationsViewController.h"
#import "ChangingBehaviorViewController.h"
#import "HitTestingViewController.h"
#import "CAShapeLayerViewController.h"
#import "CATextLayerViewController.h"

@interface AnimationTestViewController ()

@property (nonatomic, strong) NSArray *arrType;

@end

@implementation AnimationTestViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
		self.title = @"CoreAnimation Test";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	_arrType = @[@"Implicit Animations",@"Basic Animationts",@"Keyframe Animations", @"Transition Animations", @"Changing a Layer’s Default Behavior",@"HitTesting",@"CAShapeLayer",@"CATextLayer"];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arrType.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
	}
	[cell.textLabel setText:[_arrType objectAtIndex:indexPath.row]];
    // Configure the cell...
    
    return cell;
}

#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller.
	switch (indexPath.row) {
		case 0:
		{
			ImplicitAnimationsViewController *detailViewController = [[ImplicitAnimationsViewController alloc] initWithNibName:@"ImplicitAnimationsViewController" bundle:nil];
			[self.navigationController pushViewController:detailViewController animated:YES];
		}
			break;
		case 1:
		{
			BasicAnimationtViewController *detailViewController = [[BasicAnimationtViewController alloc] initWithNibName:@"BasicAnimationtViewController" bundle:nil];
			[self.navigationController pushViewController:detailViewController animated:YES];
		}
			break;
		case 2:
		{
			KeyframeAnimationViewController *detailViewController = [[KeyframeAnimationViewController alloc] init];
			[self.navigationController pushViewController:detailViewController animated:YES];
		}
			break;
		case 3:
		{
			TransitionAnimationsViewController *detailViewController = [[TransitionAnimationsViewController alloc] init];
			[self.navigationController pushViewController:detailViewController animated:YES];
		}
			break;
		case 4:
		{
			ChangingBehaviorViewController *detailViewController = [[ChangingBehaviorViewController alloc] init];
			[self.navigationController pushViewController:detailViewController animated:YES];
		}
			break;
		case 5:
		{
			HitTestingViewController *detailViewController = [[HitTestingViewController alloc] init];
			[self.navigationController pushViewController:detailViewController animated:YES];
		}
			break;
		case 6:
		{
			CAShapeLayerViewController *detailViewController = [[CAShapeLayerViewController alloc] init];
			[self.navigationController pushViewController:detailViewController animated:YES];
		}
			break;
		case 7:
		{
			CATextLayerViewController *detailViewController = [[CATextLayerViewController alloc] init];
			[self.navigationController pushViewController:detailViewController animated:YES];
		}
			break;
		default:
			break;
	}
}

@end
