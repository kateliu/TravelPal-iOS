//
//  TPViewController.h
//  TravelPal
//
//  Created by Xiao Xiao on 9/21/13.
//  Copyright (c) 2013 ok. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TPViewController : UIViewController {
    IBOutlet UIButton *_startButton;
}

@property (nonatomic, strong) UIButton *startButton;
@property (nonatomic, strong) NSString *currentTravelId;

- (IBAction)enterTravel:(id)sender;

- (IBAction)recentTravel:(id)sender;



@end
