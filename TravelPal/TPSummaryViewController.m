//
//  TPSummaryViewController.m
//  TravelPal
//
//  Created by Xiao Xiao on 9/22/13.
//  Copyright (c) 2013 ok. All rights reserved.
//

#import "TPSummaryViewController.h"
#import "TPHttpRequest.h"
#import "TPUrl.h"

@interface TPSummaryViewController ()

@property (nonatomic, strong) NSMutableDictionary *travel;
@property (nonatomic, strong) NSMutableArray *travelSummary;
@property (nonatomic, strong) NSMutableArray *travelPayment;


@end

@implementation TPSummaryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _travelSummary = [[NSMutableArray alloc] init];
        _travelPayment = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //NSLog(@"url: %@", [TPUrl travelSummaryUrl:@"a"]);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    TPHttpRequest *request = [[TPHttpRequest alloc] init];

    self.travel = [request getJsonFromUrl: [TPUrl travelInfoUrl:self.travelId]];

    NSLog(@"travel: %@", self.travel);

    NSDictionary *summary = [[request getJsonFromUrl: [TPUrl travelSummaryUrl:self.travelId]] objectForKey:@"summary"];
    self.travelPayment = [[request getJsonFromUrl: [TPUrl travelSummaryUrl:self.travelId]] objectForKey:@"payments"];

    for (NSString *key in [summary allKeys]) {
        NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithDictionary: [summary objectForKey:key]];
        [data setValue:key forKey:@"name"];
        [self.travelSummary addObject:data];
    }

    NSLog(@"travel summary: %@", self.travelSummary);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"section %d", section);
    if (section == 0) {
        return [self.travelSummary count];
    }
    else {
        return [self.travelPayment count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    if (indexPath.section == 0) {
        NSString *summary = [NSString stringWithFormat:@"%@: credit: $%d, debt: $%d", [[_travelSummary objectAtIndex:indexPath.row] objectForKey:@"name"], [[[_travelSummary objectAtIndex:indexPath.row] objectForKey:@"credit"] intValue], [[[_travelSummary objectAtIndex:indexPath.row] objectForKey:@"debt"] intValue]];
        cell.textLabel.text = summary;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"Summary: $%d", [[[_travelSummary objectAtIndex:indexPath.row] objectForKey:@"summary"] intValue]];
    }
    else {
        NSString *summary = [NSString stringWithFormat:@"%@ pay %@ %d", [[_travelPayment objectAtIndex:indexPath.row] objectForKey:@"from"], [[_travelPayment objectAtIndex:indexPath.row] objectForKey:@"to"], [[[_travelPayment objectAtIndex:indexPath.row] objectForKey:@"money"] intValue]];
        cell.textLabel.text = summary;
        cell.detailTextLabel.text = @"";
    }
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        NSString *description = [self.travel objectForKey:@"description"];
        return [NSString stringWithFormat:@"Travel Summary - %@", description];
    }
    else {
        NSString *description = [self.travel objectForKey:@"description"];
        return [NSString stringWithFormat:@"Travel Payment - %@", description];
    }
}

- (IBAction)makePayment:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
