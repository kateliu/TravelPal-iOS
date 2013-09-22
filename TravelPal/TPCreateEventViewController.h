//
//  TPCreateEventViewController.h
//  TravelPal
//
//  Created by Xiao Xiao on 9/21/13.
//  Copyright (c) 2013 ok. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TPCreateEventViewController : UIViewController {
    IBOutlet UITextField *_desc;
    IBOutlet UITextField *_expense;
    IBOutlet UITextView *_textView;
}

@property (nonatomic, strong) NSString *travelId;
@property (nonatomic, strong) UITextField *desc;
@property (nonatomic, strong) UITextField *expense;
@property (nonatomic, strong) UITextView *textView;

-(IBAction)touchView:(id)sender;

-(IBAction)createEvent:(id)sender;

@end
