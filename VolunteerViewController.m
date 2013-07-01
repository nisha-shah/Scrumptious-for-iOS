//
//  VolunteerViewController.m
//  VolunteerApp
//
//  Created by Nisha Shah on 6/6/13.
//  Copyright (c) 2013 Nisha Shah. All rights reserved.
//

#import "VolunteerViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "AboutViewController.h"
#import "AppDelegate.h"

@implementation VolunteerViewController
@synthesize btnLoginWithFacebook,btnSignIn,btnBrowseOpportunities;
@synthesize browseViewController;
@synthesize userSignInVC;

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
    [super viewDidLoad];
        
    self.navigationController.navigationBarHidden=YES;
//   [self styleButtons:self.btnBrowseOpportunities];
    [self styleButtons:self.btnLoginWithFacebook];
    [self styleButtons:self.btnSignIn];
    

}

-(void)styleButtons:(UIButton*)btn{

    btn.layer.cornerRadius=15;
    btn.clipsToBounds=YES;
    [[btn layer] setBorderWidth:2.0f];
   [[btn layer] setBorderColor:[UIColor blackColor].CGColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden=YES;

}

- (IBAction)buttonSignInClicked:(id)sender {
    
   //- NSLog(@"In Sign In Button");
    userSignInVC=[[UserSignInViewController alloc]initWithNibName:@"UserSignInViewController" bundle:nil];
    [self.navigationController pushViewController:userSignInVC animated:YES];
}

- (IBAction)buttonLoginWithFacebookClicked:(id)sender {
    
  //  NSLog(@"In FB Login");
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    [appDelegate openSession];
}

- (IBAction)buttonBrowseOpportunitiesClicked:(id)sender {
  
    browseViewController=[[BrowseOpportunityTableViewController alloc]initWithNibName:@"BrowseOpportunityTableViewController" bundle:nil];
    [self.navigationController pushViewController:browseViewController animated:YES];

}


@end
