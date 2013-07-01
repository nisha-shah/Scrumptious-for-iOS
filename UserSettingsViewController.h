//
//  UserSettingsViewController.h
//  VolunteerApp
//
//  Created by Nisha Shah on 6/19/13.
//  Copyright (c) 2013 Nisha Shah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface UserSettingsViewController : UIViewController

@property (strong, nonatomic) IBOutlet FBProfilePictureView *userProfilePic;

@property (strong, nonatomic) IBOutlet UILabel *facebookUserName;

@end
