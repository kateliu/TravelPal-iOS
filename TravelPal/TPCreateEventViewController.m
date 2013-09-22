//
//  TPCreateEventViewController.m
//  TravelPal
//
//  Created by Xiao Xiao on 9/21/13.
//  Copyright (c) 2013 ok. All rights reserved.
//

#import "TPCreateEventViewController.h"
#import "TPUrl.h"
#import <CoreLocation/CoreLocation.h>
#import <CoreLocation/CLLocationManager.h>
#import "TPExpenseViewController.h"
#import "TPEventViewController.h"
#import "TPHttpRequest.h"

@interface TPCreateEventViewController ()

@end

@implementation TPCreateEventViewController

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
    
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    _locationManager.distanceFilter = kCLDistanceFilterNone;
    [_locationManager startUpdatingLocation];
    [_locationManager stopUpdatingLocation];
    
    CLLocation *location = [_locationManager location];
    float longitude = location.coordinate.longitude;
    float latitude = location.coordinate.latitude;
    
    NSString *post = [NSString stringWithFormat:@"description=%@&user=%@&longitude=%f&latitude=%f&travel=%@", _desc.text, @"Sean", longitude, latitude, _travelId];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[TPUrl createEventUrl:_travelId]]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Current-Type"];
    [request setHTTPBody:postData];
    NSURLConnection *conn = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    if (conn) {
        NSLog(@"Connection Successful");
    }
    else {
        NSLog(@"Connection could not be made");
    }
    self.doneButton.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)touchView:(id)sender
{
    [_desc resignFirstResponder];
}

-(IBAction)doneEvent:(id)sender
{
    NSString *post = [NSString stringWithFormat:@"description=%@", self.desc.text];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[TPUrl updateEventUrl:_eventId]]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Current-Type"];
    [request setHTTPBody:postData];
    NSURLConnection *conn = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    if (conn) {
        NSLog(@"Connection Successful");
    }
    else {
        NSLog(@"Connection could not be made");
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData*)data
{
    NSError *error = nil;
    NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    if ([jsonData objectForKey:@"eventID"]) {
        self.eventId = [jsonData objectForKey:@"eventID"];
    }
    else {
        UINavigationController *navController = self.navigationController;
        [navController popViewControllerAnimated:NO];
        TPEventViewController *controller = [[TPEventViewController alloc] initWithNibName:@"TPEventViewController" bundle:nil];
        TPHttpRequest *request = [[TPHttpRequest alloc] init];
        controller.event = [request getJsonFromUrl:[TPUrl getEventUrl:self.eventId]];
        [navController pushViewController:controller animated:YES];
    }
}

-(IBAction)addExpense:(id)sender
{
    if (self.eventId) {
        TPExpenseViewController *controller = [[TPExpenseViewController alloc] initWithNibName:@"TPExpenseViewController" bundle:nil];
        controller.eventId = self.eventId;
        
        [self.navigationController pushViewController:controller animated:YES];
    }
}


@end
