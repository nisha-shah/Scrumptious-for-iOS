//
//  DetailOpportunityViewController.h
//  VolunteerApp
//
//  Created by Nisha Shah on 6/6/13.
//  Copyright (c) 2013 Nisha Shah. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DetailOpportunityViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextView *opportunityTextView;
@property (strong, nonatomic) IBOutlet UIButton *btnShareOnFacebook;
@property (strong, nonatomic) IBOutlet UIImageView *detailOpportunityImage;
- (IBAction)btnShareOnFacebookClicked:(id)sender;


@end
