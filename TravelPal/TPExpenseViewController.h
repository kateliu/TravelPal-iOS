//
//  TPExpenseViewController.h
//  TravelPal
//
//  Created by Xiao Xiao on 9/22/13.
//  Copyright (c) 2013 ok. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TPExpenseViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate> {
    IBOutlet UIPickerView *_pickerView;
    IBOutlet UILabel *_peopleLabel;
    IBOutlet UILabel *_payerLabel;
    IBOutlet UITextField *_descTextView;
    IBOutlet UITextField *_costTextView;
}

@property (nonatomic, strong) NSArray *names;

@property (nonatomic, retain) UIPickerView *pickerView;

@property (nonatomic, retain) NSString *eventId;

@property (nonatomic, strong) UILabel *peopleLabel;

@property (nonatomic, strong) UILabel *payerLabel;
@property (nonatomic, strong) UITextField *descTextView;
@property (nonatomic, strong) UITextField *costTextView;

-(IBAction)pressPayer:(id)sender;

-(IBAction)pressPeople:(id)sender;

-(IBAction)addExpense:(id)sender;

-(IBAction)dismissKeyboard:(id)sender;

@end
