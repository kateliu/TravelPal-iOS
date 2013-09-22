//
//  TPSummaryViewController.h
//  TravelPal
//
//  Created by Xiao Xiao on 9/22/13.
//  Copyright (c) 2013 ok. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TPSummaryViewController : UIViewController {
    IBOutlet UITableView *_tableView;
    IBOutlet UILabel *_nameLabel;
    IBOutlet UITableView *_paymentTable;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UITableView *paymentTable;
@property (nonatomic, strong) NSString *travelId;


@end
