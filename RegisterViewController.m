//
//  RegisterViewController.m
//  VolunteerApp
//
//  Created by Nisha Shah on 6/6/13.
//  Copyright (c) 2013 Nisha Shah. All rights reserved.
//

#import "RegisterViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "DetailOpportunityViewController.h"

@implementation RegisterViewController
@synthesize btnCancel,btnSignIn,btnLoginWithFacebook;
@synthesize detailOpportunityVC;

@synthesize userSignInVC;

@synthesize interestsTableVC;

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
    self.navigationController.navigationBarHidden=NO;
    self.navigationItem.title=@"Register";
    self.navigationController.navigationBar.tintColor=[UIColor blackColor];
    [self styleButtons:self.btnCancel];
    [self styleButtons:self.btnLoginWithFacebook];
    [self styleButtons:self.btnSignIn];
    // Do any additional setup after loading the view from its nib.
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

- (IBAction)buttonSignInClicked:(id)sender {
  //--  self.interestsVC=[[InterestsViewController alloc]initWithNibName:@"InterestsViewController" bundle:nil];
    
    
    self.userSignInVC=[[UserSignInViewController alloc]initWithNibName:@"UserSignInViewController" bundle:nil];

  //  [self.navigationController pushViewController:self.interestsVC animated:YES];
      [self.navigationController pushViewController:self.userSignInVC animated:YES];
    
}


- (IBAction)buttonLoginWithFacebookClicked:(id)sender {
}

- (IBAction)buttonCancelClicked:(id)sender {
   self.detailOpportunityVC=[[DetailOpportunityViewController alloc]initWithNibName:@"DetailOpportunityViewController" bundle:nil];
    [self.navigationController pushViewController:self.detailOpportunityVC animated:YES];
    
}
@end
