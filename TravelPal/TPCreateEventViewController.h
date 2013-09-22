//
//  TPCreateEventViewController.h
//  TravelPal
//
//  Created by Xiao Xiao on 9/21/13.
//  Copyright (c) 2013 ok. All rights reserved.
//

#import <UIKit/UIKit.h>

@class  CLLocationManager;

@interface TPCreateEventViewController : UIViewController {
    IBOutlet UITextField *_desc;
    IBOutlet UITextView *_textView;
    
}

@property (nonatomic, strong) NSString *travelId;
@property (nonatomic, strong) NSString *eventId;
@property (nonatomic, strong) UITextField *desc;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;

-(IBAction)touchView:(id)sender;

-(IBAction)doneEvent:(id)sender;

-(IBAction)addExpense:(id)sender;

@end
