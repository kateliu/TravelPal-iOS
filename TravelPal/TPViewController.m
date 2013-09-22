//
//  TPViewController.m
//  TravelPal
//
//  Created by Xiao Xiao on 9/21/13.
//  Copyright (c) 2013 ok. All rights reserved.
//

#import "TPViewController.h"

#import "TPCurrentTravelViewController.h"
#import "TPHttpRequest.h"
#import "TPRecentTripViewController.h"
#import "TPUrl.h"


@interface TPViewController ()

@property (nonatomic, strong) TPHttpRequest *httpRequest;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *urlForTravelList;

@end

@implementation TPViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _httpRequest = [[TPHttpRequest alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Travel Pal";
    self.userId = @"Sean"; //TODO: get developer Id programmatically.
    NSString *eventsUrl = [TPUrl getOpenTravel:self.userId];
    TPHttpRequest *request = [[TPHttpRequest alloc] init];
    NSLog(@"%@", eventsUrl);
    NSDictionary* openEvent = [request getJsonFromUrl: eventsUrl];
    if (openEvent) {
        _currentTravelId = [openEvent objectForKey:@"id"];
        _startButton.titleLabel.text = @"Current Travel";
    }
    else {
        _startButton.titleLabel.text = @"Start Travel";        
    }
    self.urlForTravelList = [[TPUrl usersUrl] stringByAppendingString:self.userId];
    UIImage *bgImage = [UIImage imageNamed:@"LauchViewBackground.png"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:bgImage];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)enterTravel:(id)sender
{
    if (_currentTravelId) {
        TPCurrentTravelViewController *currentTravel = [[TPCurrentTravelViewController alloc] initWithNibName:@"TPCurrentTravelViewController" bundle:nil];
        currentTravel.travelId = @"-J42oLypRGPmwgwal4-P";
        [self.navigationController pushViewController:currentTravel animated:YES];
    }
    else {
        NSString *post = [NSString stringWithFormat:@"description=%@&user=%@", @"Trip to Arctica", @"Sean"];
        NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://travelpal.herokuapp.com/travels"]]];
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
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData*)data
{
    NSError *error = nil;
    NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];

    TPCurrentTravelViewController *currentTravel = [[TPCurrentTravelViewController alloc] initWithNibName:@"TPCurrentTravelViewController" bundle:nil];
    currentTravel.travelId = [jsonData objectForKey:@"id"];
    [self.navigationController pushViewController:currentTravel animated:YES];
}

- (IBAction)recentTravel:(id)sender
{
    TPRecentTripViewController *recentTripViewController = [[TPRecentTripViewController alloc] initWithNibName:@"TPRecentTripViewController" bundle:nil];
    recentTripViewController.travelList = [self.httpRequest getJsonFromUrl:self.urlForTravelList];
    NSLog(@"travel list: %@", recentTripViewController.travelList);
    [self.navigationController pushViewController:recentTripViewController animated:YES];
}

@end
