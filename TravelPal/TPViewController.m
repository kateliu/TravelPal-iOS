//
//  TPViewController.m
//  TravelPal
//
//  Created by Xiao Xiao on 9/21/13.
//  Copyright (c) 2013 ok. All rights reserved.
//

#import "TPViewController.h"
#import "TPMapViewController.h"

#import <MapKit/MapKit.h>


#import "TPAnnotation.h"
#import "TPEvent.h"
#import "TPPhotoViewController.h"
#import "TPCurrentTravelViewController.h"
#import "TPRecentTripViewController.h"

@interface TPViewController ()

@property (nonatomic, strong) CLLocationManager *locationManager;

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

- (IBAction)enterTravel:(id)sender
{
    TPMapViewController *mapViewController = [[TPMapViewController alloc] initWithNibName:@"TPMapViewController" bundle:nil];
    NSMutableArray *annotations = [NSMutableArray arrayWithCapacity:10];
    for (int i=0; i<10; ++i) {
        NSMutableDictionary *event = [[NSMutableDictionary alloc] init];
        event[EVENT_TITLE] = [NSString stringWithFormat:@"title%d", i+1];
        event[EVENT_DESCRIPTION] = [NSString stringWithFormat:@"description%d", i+1];
        event[EVENT_LATITUDE] = [NSNumber numberWithDouble:(37.111+i)];
        event[EVENT_LONGITUDE] = [NSNumber numberWithDouble:(121.111+i)];
        [annotations addObject:[TPAnnotation annotationForEvent: event]];
    }

    mapViewController.annotations = annotations;
    [self.navigationController pushViewController:mapViewController animated:YES];
    TPCurrentTravelViewController *currentTravel = [[TPCurrentTravelViewController alloc] initWithNibName:@"TPCurrentTravelViewController" bundle:nil];
    [self.navigationController pushViewController:currentTravel animated:YES];
}

- (IBAction)recentTravel:(id)sender
{
    TPRecentTripViewController *recentTripViewController = [[TPRecentTripViewController alloc] initWithNibName:@"TPRecentTripViewController" bundle:nil];
    [self.navigationController pushViewController:recentTripViewController animated:YES];
}

@end
