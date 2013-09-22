//
//  TPCurrentTravelViewController.h
//  TravelPal
//
//  Created by Xiao Xiao on 9/21/13.
//  Copyright (c) 2013 ok. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TPCurrentTravelViewController : UIViewController {
    IBOutlet UITableView *_eventsTable;
    IBOutlet UILabel *_travelNameLabel;
}

@property (nonatomic, strong) NSString *travelId;
@property (nonatomic, strong) NSString *travelName;
@property (nonatomic, strong) NSArray *events;
@property (nonatomic, strong) UITableView *eventsTable;
@property (nonatomic, strong) UILabel *travelNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *endTripButton;

- (IBAction)endTravel:(id)sender;

- (IBAction)createEvent:(id)sender;

@end
