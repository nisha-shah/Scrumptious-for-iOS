//
//  UserSettingViewController.m
//  VolunteerApp
//
//  Created by Nisha Shah on 6/19/13.
//  Copyright (c) 2013 Nisha Shah. All rights reserved.
//

#import "UserSettingViewController.h"
#import "AppDelegate.h"
#import "AboutViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <Parse/Parse.h>

@implementation UserSettingViewController
@synthesize facebookUserName,userProfilePicture;
@synthesize lblParseEmail;
@synthesize lblParseUserName;
@synthesize txtParseEmail,txtParseUserName;
@synthesize aboutViewController,interestTableVC;
@synthesize btnAboutApp,btnSetInterests;
@synthesize settingsImageView;

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
    [self.settingsImageView setImage:[UIImage imageNamed:@"settings3.jpg"]];
    
    [super viewDidLoad];
    //make a logout button
    self.navigationController.navigationBarHidden=NO;
    self.navigationController.navigationBar.tintColor=[UIColor blackColor];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                              initWithTitle:@"Logout"
                                              style:UIBarButtonItemStyleBordered
                                              target:self
                                              action:@selector(btnLogoutClicked:)];
    
    self.navigationItem.title=@" Settings ";
   
    
    AppDelegate *appDelegate1 = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(appDelegate1.userFBLogInStatus==1){
        self.txtParseUserName.hidden=YES;
        self.txtParseEmail.hidden=YES;
        
        self.lblParseUserName.hidden=YES;
        self.lblParseEmail.hidden=YES;
        
        //added for user Profile picture
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(sessionStateChanged:)
     name:SCSessionStateChangedNotification
     object:nil];
    }else if(appDelegate1.userLogInStatus==1){
        PFUser *user=[PFUser currentUser];
        self.facebookUserName.hidden=YES;
        self.userProfilePicture.hidden=YES;
        self.txtParseUserName.text=user.username;
        self.txtParseEmail.text=user.email;
        
    }
    [self styleButtons:self.btnSetInterests];
    [self styleButtons:self.btnAboutApp];
    
    // Do any additional setup after loading the view from its nib.
}


-(void)styleButtons:(UIButton*)btn{
    
   btn.layer.cornerRadius=15;
    btn.clipsToBounds=YES;
    [[btn layer] setBorderWidth:2.0f];
   // btn.backgroundColor=[UIColor blackColor];
    [[btn layer] setBorderColor:[UIColor blackColor].CGColor];
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
             //--    NSLog(@"User name i s %@",user.name);
                 NSString *emailAddress= [user objectForKey:@"email"];
             //--    NSLog(@"User email is %@",emailAddress);
               /*  NSArray *ar= user.allKeys;
                 for(NSString* i in ar){
                     NSLog(@"1");
                     NSLog(@"%@",i);
                 }
                   NSLog(@"User id is %@",user.id);*/
                 userProfilePicture.profileID=user.id;
                   AppDelegate *appDelegate1 = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                 appDelegate1.userFbEmail=emailAddress;
              
            }
         }];
    }
    
    
}

- (void)btnLogoutClicked:(id)sender {
     AppDelegate *appDelegate2 = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(appDelegate2.userFBLogInStatus==1){
    [FBSession.activeSession closeAndClearTokenInformation];
    }else {
        [PFUser logOut];
        appDelegate2.userLogInStatus=NO;
        
    }
    
   /* UIAlertView *message1 = [[UIAlertView alloc] initWithTitle:@"Logout"
                                                       message:@"You have successfully loggeg out ."
                                                      delegate:nil
                                             cancelButtonTitle:@"OK"
                                             otherButtonTitles:nil];
    [message1 show];
    */
    [self.navigationController popToRootViewControllerAnimated:YES ];
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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnSetInterests:(id)sender {
    interestTableVC=[[InterestsTableViewController alloc]initWithNibName:@"InterestsTableViewController" bundle:nil];
    [self.navigationController pushViewController:self.interestTableVC animated:YES];
    
}

- (IBAction)btnAboutApp:(id)sender {
    self.aboutViewController=[[AboutViewController alloc]initWithNibName:@"AboutViewController" bundle:nil];
    [self.navigationController pushViewController:self.aboutViewController animated:YES];
}


@end
