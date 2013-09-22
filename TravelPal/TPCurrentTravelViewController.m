//
//  TPCurrentTravelViewController.m
//  TravelPal
//
//  Created by Xiao Xiao on 9/21/13.
//  Copyright (c) 2013 ok. All rights reserved.
//

#import "TPCurrentTravelViewController.h"
#import "TPUrl.h"
#import "TPHttpRequest.h"
#import "TPCreateEventViewController.h"

@interface TPCurrentTravelViewController ()

@end

@implementation TPCurrentTravelViewController

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
    self.title = @"My Travel";
}

- (void)viewWillAppear:(BOOL)animated
{
    NSString *eventsUrl = [TPUrl travelEventsUrl:_travelId];
    TPHttpRequest *request = [[TPHttpRequest alloc] init];
    _events = [request getJsonFromUrl: eventsUrl];
    [_eventsTable reloadData];
    [self loadEvents];
}


- (void)loadEvents
{
    for (NSString *eventId in _events) {
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:[TPUrl getEventUrl:eventId]]];
        [request setHTTPMethod:@"GET"];
        NSURLConnection *conn = [[NSURLConnection alloc]initWithRequest:request delegate:self];
        if (conn) {
            NSLog(@"Connection Successful");
        }
        else {
            NSLog(@"Connection could not be made");
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_events count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = @"Loading...";
    
    return cell;
}

- (IBAction)createEvent:(id)sender
{
    TPCreateEventViewController *createEventController = [[TPCreateEventViewController alloc] initWithNibName:@"TPCreateEventViewController" bundle:nil];
    createEventController.travelId = self.travelId;
    [self.navigationController pushViewController:createEventController animated:YES];

}

- (IBAction)endTravel:(id)sender
{
    NSString *post = @"";
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[TPUrl endTravelUrl:_travelId]]];
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
    if ([jsonData objectForKey:@"travel"]) {
        for (int i = 0; i < [_events count]; i++) {
            if ([[_events objectAtIndex:i] isEqualToString:[jsonData objectForKey:@"id"]]) {
                UITableViewCell *cell = [_eventsTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
                cell.textLabel.text = [jsonData objectForKey:@"description"];
                break;
            }
        }
    }
    else {
        UINavigationController *navController = self.navigationController;
        [navController popViewControllerAnimated:YES];
    }
}


@end
