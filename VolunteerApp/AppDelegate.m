//
//  AppDelegate.m
//  VolunteerApp
//
//  Created by Nisha Shah on 6/6/13.
//  Copyright (c) 2013 Nisha Shah. All rights reserved.
//

NSString *const SCSessionStateChangedNotification =
@"com.facebook.Scrumptious:SCSessionStateChangedNotification";



#import "AppDelegate.h"
#import "VolunteerViewController.h"
#import <Parse/Parse.h>


@implementation AppDelegate
@synthesize navigationController,mainViewController;
@synthesize selectedOpportunity;
@synthesize userLogInStatus;
@synthesize volunteerVC;
@synthesize browseOpportunityVC;
@synthesize userFBLogInStatus;
@synthesize userSettingsVC;
@synthesize interestTableVC;
@synthesize userFbEmail;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //added for profile picture
    [FBProfilePictureView class];

    //Parse keys
    [Parse setApplicationId:@"M9HDjHaW7ygJrNHr0qy5taUmJXLphqlv1xmFwgEF"
                  clientKey:@"c1FNBR2CyvKYHwY79wuAeqaD0caouRvGD4EawSMb"];
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    // Setting the "Volunteer View Controller" as the root view controller.
    self.mainViewController = [[VolunteerViewController alloc]initWithNibName:@"VolunteerViewController" bundle:nil];
    self.navigationController = [[UINavigationController alloc]initWithRootViewController:self.mainViewController];
    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];
    return YES;
}

-(void)openSession
{
    // set permissions for accessing the user basic info,emailId
    [FBSession openActiveSessionWithReadPermissions:@[@"basic_info", @"email"]
                                       allowLoginUI:YES
                                  completionHandler:
     ^(FBSession *session,
       FBSessionState state, NSError *error) {
         [self sessionStateChanged:session state:state error:error];
     }];
    
    
    
   }

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return [FBSession.activeSession handleOpenURL:url];
}


- (void)sessionStateChanged:(FBSession *)session
                      state:(FBSessionState) state
                      error:(NSError *)error
{
    switch (state) {
        case FBSessionStateOpen: 
        {
            /* Display the page you want to display after user logged in . */
            userFBLogInStatus=YES;
                   self.userSettingsVC=[[UserSettingViewController alloc]init];
            [self.navigationController pushViewController:self.userSettingsVC animated:YES];
                    }
            break;
        case FBSessionStateClosed:
        case FBSessionStateClosedLoginFailed:
            //put the page u want to display on failed login
            [self.navigationController popToRootViewControllerAnimated:NO];
            self.userFBLogInStatus=NO;
            [FBSession.activeSession closeAndClearTokenInformation];
            break;
            
        default: NSLog(@"Default");break;
            
    }
    
    //added for  ProfilePicture
    [[NSNotificationCenter defaultCenter]
     postNotificationName:SCSessionStateChangedNotification
     object:session];
    
        if (error) {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Error"
                                  message:error.localizedDescription
                                  delegate:nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }    
}



@end
