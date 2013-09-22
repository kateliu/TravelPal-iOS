//
//  TPEventViewController.h
//  TravelPal
//
//  Created by Xiao Xiao on 9/22/13.
//  Copyright (c) 2013 ok. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TPEventViewController : UIViewController {
    IBOutlet UILabel *_descLabel;
    IBOutlet UITableView *_tableView;
}

@property (nonatomic, retain) UILabel *descLabel;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSDictionary *event;
@property (nonatomic, strong) NSMutableArray *expenses;

@end
