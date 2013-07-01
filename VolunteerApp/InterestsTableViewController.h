//
//  InterestsTableViewController.h
//  VolunteerApp
//
//  Created by Nisha Shah on 6/17/13.
//  Copyright (c) 2013 Nisha Shah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
@class BrowseOpportunityTableViewController;


@interface InterestsTableViewController : PFQueryTableViewController
{
    NSArray *userInterests;
    PFUser *currentUser;
    NSString* fbEmailId;
}
@property(retain,nonatomic)NSArray *userInterests;
@property(retain,nonatomic)PFUser *currentUser;
@property(retain,nonatomic)NSString* fbEmailId;
@property(strong,nonatomic)BrowseOpportunityTableViewController *browseOpportunityVC;

-(void)populateInterestsInTable :(NSMutableArray *)interestList;

@end
