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
    NSString *eventsUrl = [TPUrl travelEventsUrl:_travelId];
    NSLog(@"%@", eventsUrl);
    TPHttpRequest *request = [[TPHttpRequest alloc] init];
    NSArray *data = nil;
    _events = [[NSArray alloc] init];
    [request getFromURLArray:eventsUrl returningJson:&data];
    _events = data;
    NSLog(@"%@", _events);
    [_eventsTable reloadData];
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
    cell.textLabel.text = [[_events objectAtIndex:indexPath.row] objectForKey:@"Name"];
    
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
    UINavigationController *navController = self.navigationController;
    [navController popViewControllerAnimated:YES];
}


@end
