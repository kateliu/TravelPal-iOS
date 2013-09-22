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

}

@property (nonatomic, retain) UILabel *descLabel;

@property (nonatomic, strong) NSDictionary *event;


@end
