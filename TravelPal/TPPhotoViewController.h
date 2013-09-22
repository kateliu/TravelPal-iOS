//
//  TPPhotoViewController.h
//  TravelPal
//
//  Created by Xiao Xiao on 9/21/13.
//  Copyright (c) 2013 ok. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TPPhotoViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) NSString *eventId;

- (IBAction)takePhoto:(id)sender;

- (IBAction)selectPhoto:(UIButton *)sender;

- (IBAction)sendPhoto:(UIButton *)sender;

@end
