//
//  AboutViewController.h
//  VolunteerApp
//
//  Created by Nisha Shah on 6/17/13.
//  Copyright (c) 2013 Nisha Shah. All rights reserved.
//

#import <UIKit/UIKit.h>
@class VolunteerViewController;
@class BrowseOpportunityTableViewController;

@interface AboutViewController : UIViewController

@property(strong,nonatomic)VolunteerViewController *volunteerVC;
@property(strong,nonatomic)BrowseOpportunityTableViewController *browseOpportunityVC;

- (IBAction)btnProceedClicked:(id)sender;

@end
