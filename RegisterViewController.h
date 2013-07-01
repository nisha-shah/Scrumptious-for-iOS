//
//  RegisterViewController.h
//  VolunteerApp
//
//  Created by Nisha Shah on 6/6/13.
//  Copyright (c) 2013 Nisha Shah. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DetailOpportunityViewController;
#import "UserSignInViewController.h"

#import "InterestsTableViewController.h"

@interface RegisterViewController : UIViewController

@property (strong,nonatomic) DetailOpportunityViewController * detailOpportunityVC;
@property (strong,nonatomic) InterestsTableViewController * interestsTableVC;


@property (strong,nonatomic) UserSignInViewController * userSignInVC;
@property (strong, nonatomic) IBOutlet UIButton *btnSignIn;
@property (strong, nonatomic) IBOutlet UIButton *btnLoginWithFacebook;
@property (strong, nonatomic) IBOutlet UIButton *btnCancel;




- (IBAction)buttonSignInClicked:(id)sender;
- (IBAction)buttonLoginWithFacebookClicked:(id)sender;
- (IBAction)buttonCancelClicked:(id)sender;


@end
