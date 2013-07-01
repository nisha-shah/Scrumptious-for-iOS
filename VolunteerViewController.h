//
//  VolunteerViewController.h
//  VolunteerApp
//
//  Created by Nisha Shah on 6/6/13.
//  Copyright (c) 2013 Nisha Shah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BrowseOpportunityTableViewController.h"
#import "UserSignInViewController.h"

@interface VolunteerViewController : UIViewController
@property(strong,nonatomic)BrowseOpportunityTableViewController * browseViewController;
@property(strong,nonatomic)UserSignInViewController * userSignInVC;

@property (strong, nonatomic) IBOutlet UIButton *btnSignIn;
@property (strong, nonatomic) IBOutlet UIButton *btnLoginWithFacebook;
@property (strong, nonatomic) IBOutlet UIButton *btnBrowseOpportunities;

- (IBAction)buttonSignInClicked:(id)sender;
- (IBAction)buttonLoginWithFacebookClicked:(id)sender;
- (IBAction)buttonBrowseOpportunitiesClicked:(id)sender;

@end
