//
//  TPRecentTripViewController.m
//  TravelPal
//
//  Created by Xiao Xiao on 9/21/13.
//  Copyright (c) 2013 ok. All rights reserved.
//

#import "TPRecentTripViewController.h"

#import "TPAnnotation.h"
#import "TPHttpRequest.h"
#import "TPMapViewController.h"
#import "TPUrl.h"

@interface TPRecentTripViewController ()

@property (nonatomic, strong) TPHttpRequest *httpRequest;

@end

@implementation TPRecentTripViewController

- (id)initWithNibName:(NSString *)nibName bundle:(NSBundle *)bundle
{
    self = [super initWithNibName:nibName bundle:bundle];
    if (self) {
        _httpRequest = [[TPHttpRequest alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
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
    return [_travelList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [[_travelList objectAtIndex:indexPath.row] objectForKey:@"description"];
    cell.accessoryType = UITableViewCellAccessoryDetailButton;
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"My Travel History";
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (NSArray *)annotationsFromEventIds:(NSArray *)eventIds
{
    int count = [eventIds count];
    NSMutableArray *annotations = [NSMutableArray arrayWithCapacity:count];
    for (NSString *eventId in eventIds) {
        NSString *eventUrl = [[TPUrl eventsUrl] stringByAppendingString:eventId];
        NSDictionary *eventInfo = [self.httpRequest getJsonFromUrl:eventUrl];
        [annotations addObject:[TPAnnotation annotationForEvent:eventInfo]];
    }
    return annotations;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TPMapViewController *mapViewController = [[TPMapViewController alloc] initWithNibName:@"TPMapViewController" bundle:nil];
    int rowId = [indexPath row];
    mapViewController.travelId = [self.travelList[rowId] objectForKey:@"id"];
    mapViewController.eventIds = [self.travelList[rowId] objectForKey:@"events"];
    mapViewController.annotations = [self annotationsFromEventIds:mapViewController.eventIds];
    [self.navigationController pushViewController:mapViewController animated:YES];
}

@end
