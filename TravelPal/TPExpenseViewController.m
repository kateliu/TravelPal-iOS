//
//  TPExpenseViewController.m
//  TravelPal
//
//  Created by Xiao Xiao on 9/22/13.
//  Copyright (c) 2013 ok. All rights reserved.
//

#import "TPExpenseViewController.h"
#import "TPUrl.h"

@interface TPExpenseViewController ()

@end

@implementation TPExpenseViewController

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
    _names = @[@"Kate", @"Clyde", @"Lydian", @"Owen", @"Dan", @"Sean"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
{
    return [_names count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [_names objectAtIndex:row];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 37)];
    label.text = [_names objectAtIndex:row];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:16];
    return label;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
}

-(IBAction)pressPayer:(id)sender
{
    [_costTextView resignFirstResponder];
    [_descTextView resignFirstResponder];

    if (_pickerView.hidden == NO) {
        self.payerLabel.text = [_names objectAtIndex:[_pickerView selectedRowInComponent:0]];
        self.peopleLabel.text = [_names objectAtIndex:[_pickerView selectedRowInComponent:0]];
        _pickerView.hidden = YES;
    }
    else {
        _pickerView.hidden = NO;
    }
}

-(IBAction)pressPeople:(id)sender
{
    [_costTextView resignFirstResponder];
    [_descTextView resignFirstResponder];

    if (_pickerView.hidden == NO) {
        self.peopleLabel.text = [NSString stringWithFormat:@"%@,%@", self.peopleLabel.text, [_names objectAtIndex:[_pickerView selectedRowInComponent:0]]];
        _pickerView.hidden = YES;
    }
    else {
        _pickerView.hidden = NO;
    }
}

-(IBAction)addExpense:(id)sender
{
    NSString *post = [NSString stringWithFormat:@"description=%@&paidBy=%@&cost=%@&people=%@", _descTextView.text, _payerLabel.text, _costTextView.text, _peopleLabel.text];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[TPUrl addExpenseUrl:_eventId]]];
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

-(IBAction)dismissKeyboard:(id)sender
{
    [_costTextView resignFirstResponder];
    [_descTextView resignFirstResponder];
}

@end
