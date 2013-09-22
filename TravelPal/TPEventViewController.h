//
//  TPEventViewController.h
//  TravelPal
//
//  Created by Xiao Xiao on 9/22/13.
//  Copyright (c) 2013 ok. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TPEventViewController : UIViewController {
    IBOutlet UITableView *_tableView;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSDictionary *event;
@property (nonatomic, strong) NSMutableArray *expenses;

-(IBAction)splitMoney:(id)sender;

@end
