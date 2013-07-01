//
//  AboutViewController.m
//  VolunteerApp
//
//  Created by Nisha Shah on 6/17/13.
//  Copyright (c) 2013 Nisha Shah. All rights reserved.
//

#import "AboutViewController.h"
#import "VolunteerViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController
@synthesize volunteerVC;
@synthesize browseOpportunityVC;

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
    self.navigationItem.title=@" About ";

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnProceedClicked:(id)sender {
   // self.volunteerVC=[[VolunteerViewController alloc]initWithNibName:@"VolunteerViewController" bundle:nil];
    self.browseOpportunityVC=[[BrowseOpportunityTableViewController alloc]initWithNibName:@"BrowseOpportunityTableViewController" bundle:nil];
    [self.navigationController pushViewController:self.browseOpportunityVC animated:YES];
}
@end
