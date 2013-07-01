//
//  DetailOpportunityViewController.m
//  VolunteerApp
//
//  Created by Nisha Shah on 6/6/13.
//  Copyright (c) 2013 Nisha Shah. All rights reserved.
//

#import "DetailOpportunityViewController.h"
#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>
#import <FacebookSDK/FacebookSDK.h>
#import "MealProtocol.h"


@interface DetailOpportunityViewController ()
@end

@implementation DetailOpportunityViewController
@synthesize opportunityTextView;
@synthesize btnShareOnFacebook;
@synthesize detailOpportunityImage;

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
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
  //  NSLog(@"APP DELEGATE VARIABLE %@",appDelegate.selectedOpportunity);
   
    PFQuery *query = [PFQuery queryWithClassName:@"Meal"];
    [query whereKey:@"meal_name" equalTo:appDelegate.selectedOpportunity];
    PFObject *result = [query getFirstObject];
    self.navigationItem.title=[result objectForKey:@"meal_name"];
    PFFile *theImage = [result objectForKey:@"meal_image"];
    
    NSData *imageData = [theImage getData];
    UIImage *image = [UIImage imageWithData:imageData];
    self.detailOpportunityImage.image=image;
    self.opportunityTextView.text=[result objectForKey:@"meal_description"];

    

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

- (IBAction)btnShareOnFacebookClicked:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    id<SCOGMealAction> action1= (id<SCOGMealAction>)[FBGraphObject graphObject];
    
    if([appDelegate.selectedOpportunity isEqualToString:@"Brussels Sprouts"]){
        action1[@"meal"]=@"154364254746841";
    }else if([appDelegate.selectedOpportunity isEqualToString:@"Cheese Burger"]){
        action1[@"meal"]=@"271758939630210";
    }else if([appDelegate.selectedOpportunity isEqualToString:@"Lamb"]){
        action1[@"meal"]=@"1383214021895331";
    }else if([appDelegate.selectedOpportunity isEqualToString:@"Fried Chicken"]){
        action1[@"meal"]=@"613949601957268";
    }else if([appDelegate.selectedOpportunity isEqualToString:@"Pork Belly"]){
        action1[@"meal"]=@"477859455632269";
    }else{
        action1[@"meal"]=@"195176823974223";
    }
    
    
    [FBDialogs presentShareDialogWithOpenGraphAction:action1
                                          actionType:@"nishaiosapp:eat"
                                 previewPropertyName:@"meal"
                                             handler:^(FBAppCall *call, NSDictionary *results, NSError *error) {
                                                 if(error) {
                                                     NSLog(@"Error: %@", error.description);
                                                     [[[UIAlertView alloc] initWithTitle:@"Result"
                                                                                 message:[NSString stringWithFormat:@"Error"]
                                                                                delegate:nil
                                                                       cancelButtonTitle:@"OK!"
                                                                       otherButtonTitles:nil]
                                                      show];
                                                     
                                                     
                                                 } else {
                                                  //   NSLog(@"Success!");
                                                     [[[UIAlertView alloc] initWithTitle:@"Result"
                                                                                 message:[NSString stringWithFormat:@"Posted Open Graph action successfully"]
                                                                                delegate:nil
                                                                       cancelButtonTitle:@"OK !"
                                                                       otherButtonTitles:nil]
                                                      show];
                                                     
                                                     
                                                 }
                                             }];
    
    
    
    
    
}
@end
