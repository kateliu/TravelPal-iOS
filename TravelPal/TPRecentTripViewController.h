//
//  TPRecentTripViewController.h
//  TravelPal
//
//  Created by Xiao Xiao on 9/21/13.
//  Copyright (c) 2013 ok. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TPRecentTripViewController : UITableViewController

@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSArray* travelList;

@end
