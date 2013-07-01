//
//  UserSettingsViewController.m
//  VolunteerApp
//
//  Created by Nisha Shah on 6/19/13.
//  Copyright (c) 2013 Nisha Shah. All rights reserved.
//


#import "UserSettingsViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import "AppDelegate.h"

@implementation UserSettingsViewController
@synthesize facebookUserName;
@synthesize userProfilePic;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    //make a logour button
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                              initWithTitle:@"Logout"
                                              style:UIBarButtonItemStyleBordered
                                              target:self
                                              action:@selector(btnLogoutClicked:)];
    
    
    //added for user Profile picture
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(sessionStateChanged:)
     name:SCSessionStateChangedNotification
     object:nil];

    
}

//added for ProfilePicture
- (void)populateUserDetails
{
    if (FBSession.activeSession.isOpen) {
        
        [[FBRequest requestForMe] startWithCompletionHandler:
         ^(FBRequestConnection *connection,
           NSDictionary<FBGraphUser> *user,
           NSError *error) {
             if (!error) {
                 self.facebookUserName.text = user.name;
                 //  NSLog(@"User id is %@",user.id);
                 userProfilePic.profileID=user.id;
                 
                 
             }
         }];
    }
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (FBSession.activeSession.isOpen) {
        [self populateUserDetails];
    }
}

-(void)viewDidUnload{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)sessionStateChanged:(NSNotification*)notification {
    [self populateUserDetails];
}
//profile picture end

-(void)logoutButtonWasPressed:(id)sender {
    [FBSession.activeSession closeAndClearTokenInformation];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
