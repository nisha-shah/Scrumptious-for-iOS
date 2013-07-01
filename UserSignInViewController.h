//
//  UserSignInViewController.h
//  VolunteerApp
//
//  Created by Nisha Shah on 6/11/13.
//  Copyright (c) 2013 Nisha Shah. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "InterestsTableViewController.h"
#import "BrowseOpportunityTableViewController.h"

@interface UserSignInViewController : UIViewController <UITextFieldDelegate>

@property(strong,nonatomic)InterestsTableViewController * interestTableVC;
@property(strong,nonatomic)BrowseOpportunityTableViewController * browseTableVC;
@property (strong, nonatomic) IBOutlet UITextField *txtUserName;
@property (strong, nonatomic) IBOutlet UITextField *txtPassword;
@property (strong, nonatomic) IBOutlet UITextField *txtEmail;
@property (strong, nonatomic) IBOutlet UILabel *lblUserName;
@property (strong, nonatomic) IBOutlet UILabel *lblPassword;
@property (strong, nonatomic) IBOutlet UIButton *btnForSignUp;
@property (strong, nonatomic) IBOutlet UILabel *lblNewUser;
@property (strong, nonatomic) IBOutlet UILabel *lblEmail;
@property (strong, nonatomic) IBOutlet UIButton *btnSignIn;
@property (strong, nonatomic) IBOutlet UILabel *lblmainLable;
@property (strong, nonatomic) IBOutlet UIButton *btnRegister;
@property (strong, nonatomic) IBOutlet UIImageView *keyImageView;

- (IBAction)btnForSignUpClicked:(id)sender;
- (IBAction)btnRegisterClicked:(id)sender;
- (IBAction)btnSignInClicked:(id)sender;

@end
