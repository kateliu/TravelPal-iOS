//
//  TPViewController.m
//  TravelPal
//
//  Created by Xiao Xiao on 9/21/13.
//  Copyright (c) 2013 ok. All rights reserved.
//

#import "TPViewController.h"
#import "TPPhotoViewController.h"
#import "TPRecentTripViewController.h"

@interface TPViewController ()

@end

@implementation TPViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)nextView:(id)sender
{
    TPPhotoViewController *photoViewController = [[TPPhotoViewController alloc] initWithNibName:@"TPPhotoViewController" bundle:nil];
    [self.navigationController pushViewController:photoViewController animated:YES];
}

- (IBAction)startTravel:(id)sender
{
    
}

- (IBAction)recentTravel:(id)sender
{
    TPRecentTripViewController *recentTripViewController = [[TPRecentTripViewController alloc] initWithNibName:@"TPRecentTripViewController" bundle:nil];
    [self.navigationController pushViewController:recentTripViewController animated:YES];
}

@end
