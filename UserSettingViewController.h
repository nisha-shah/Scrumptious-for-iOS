//
//  UserSettingViewController.h
//  VolunteerApp
//
//  Created by Nisha Shah on 6/19/13.
//  Copyright (c) 2013 Nisha Shah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "InterestsTableViewController.h"
@class AboutViewController;

@interface UserSettingViewController : UIViewController

@property(retain,nonatomic)PFQueryTableViewController * interestTableVC;
@property(strong,nonatomic)AboutViewController *aboutViewController;
@property (strong, nonatomic) IBOutlet FBProfilePictureView *userProfilePicture;
@property (strong, nonatomic) IBOutlet UILabel *facebookUserName;
@property (strong, nonatomic) IBOutlet UIButton *btnSetInterests;
@property (strong, nonatomic) IBOutlet UIImageView *settingsImageView;
@property (strong, nonatomic) IBOutlet UIButton *btnAboutApp;
@property (strong, nonatomic) IBOutlet UILabel *lblParseUserName;
@property (strong, nonatomic) IBOutlet UILabel *lblParseEmail;
@property (strong, nonatomic) IBOutlet UITextField *txtParseUserName;
@property (strong, nonatomic) IBOutlet UITextField *txtParseEmail;
//@property(retain,nonatomic)AppDelegate* appDelegate;

- (IBAction)btnSetInterests:(id)sender;
- (IBAction)btnAboutApp:(id)sender;
-(void)styleButtons:(UIButton*)btn;


@end
