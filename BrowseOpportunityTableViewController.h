//
//  BrowseOpportunityTableViewController.h
//  VolunteerApp
//
//  Created by Nisha Shah on 6/6/13.
//  Copyright (c) 2013 Nisha Shah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailOpportunityViewController.h"
#import "UserSettingViewController.h"
#import  <Parse/Parse.h>
@class UserSettingViewController;

@interface BrowseOpportunityTableViewController : /*UITableViewController*/ PFQueryTableViewController 
{
    DetailOpportunityViewController * detailOpportunityVC;
    PFObject* selected_opportunity;
    NSMutableArray *intList;
    PFQuery *displayOpportunityQuery;

}
@property(strong,nonatomic)DetailOpportunityViewController * detailOpportunityVC;
@property(strong,nonatomic)UserSettingViewController * userSettingVC;
@property(nonatomic, readwrite, retain) PFObject *selected_opportunity;
@property(nonatomic, readwrite, retain)NSMutableArray *intList;;
@property(nonatomic, readwrite, retain)PFQuery *displayOpportunityQuery;


@end
