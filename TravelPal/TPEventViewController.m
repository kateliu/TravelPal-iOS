//
//  TPEventViewController.m
//  TravelPal
//
//  Created by Xiao Xiao on 9/22/13.
//  Copyright (c) 2013 ok. All rights reserved.
//

#import "TPEventViewController.h"

@interface TPEventViewController ()

@property (nonatomic, strong) NSString *eventDescription;
@property int iconId;

@end

@implementation TPEventViewController

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
    self.title = @"Event Detail";
    _expenses = [[NSMutableArray alloc] init];
    self.eventDescription = [_event objectForKey:@"description"];
    for (NSString *key in [[_event objectForKey:@"expenses"] allKeys]) {
        [_expenses addObject:[[_event objectForKey:@"expenses"] objectForKey:key]];
    }
    self.iconId = 0;
    // Do any additional setup after loading the view from its nib.
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
    return [_expenses count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [[_expenses objectAtIndex:indexPath.row] objectForKey:@"description"];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"$ %@", [[_expenses objectAtIndex:indexPath.row] objectForKey:@"cost"]];
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"icon%d.png", self.iconId]];
    self.iconId = (self.iconId + 1)%4;
    return cell;
}

-(IBAction)splitMoney:(id)sender
{
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"Expenses for %@", self.eventDescription];
}

@end
