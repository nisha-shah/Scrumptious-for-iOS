//
//  AppDelegate.h
//  VolunteerApp
//
//  Created by Nisha Shah on 6/6/13.
//  Copyright (c) 2013 Nisha Shah. All rights reserved.
//

extern NSString *const SCSessionStateChangedNotification;


#import <UIKit/UIKit.h>
#import "VolunteerViewController.h"
#import "BrowseOpportunityTableViewController.h"
#import "UserSettingViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import "InterestsTableViewController.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
  NSString *selectedOpportunity;
    BOOL userLogInStatus;
    BOOL userFBLogInStatus;
    NSString* userFbEmail;
    
}
@property(strong,nonatomic)NSString *selectedOpportunity;
@property (nonatomic, assign) BOOL userLogInStatus;
@property (nonatomic, assign) BOOL userFBLogInStatus;
@property (nonatomic, retain)  NSString* userFbEmail;

@property (strong, nonatomic) UIWindow *window;
@property(strong,nonatomic)UINavigationController *navigationController;
@property(strong,nonatomic)UIViewController *mainViewController;
@property(strong,nonatomic)VolunteerViewController *volunteerVC;
@property(strong,nonatomic)BrowseOpportunityTableViewController *browseOpportunityVC;
@property(strong,nonatomic)UserSettingViewController *userSettingsVC;
@property(strong,nonatomic)InterestsTableViewController *interestTableVC;


- (void)openSession;

@end
