//
//  BrowseOpportunityTableViewController.m
//  VolunteerApp
//
//  Created by Nisha Shah on 6/6/13.
//  Copyright (c) 2013 Nisha Shah. All rights reserved.
//

#import "BrowseOpportunityTableViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"
#import <FacebookSDK/FacebookSDK.h>



@implementation BrowseOpportunityTableViewController
@synthesize detailOpportunityVC;
@synthesize selected_opportunity;
@synthesize intList;
@synthesize displayOpportunityQuery;
@synthesize userSettingVC;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
   
    self.parseClassName=@"Meal";
    self.textKey=@"meal_name";
    self.paginationEnabled = YES;
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=NO;
    self.navigationController.navigationBar.tintColor=[UIColor blackColor];
    self.navigationItem.title=@"Scrumptious";
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(openSettingsView:)];
    [anotherButton setImage:[UIImage imageNamed:@"gear.png"]];
    [anotherButton setTintColor:[UIColor blackColor]];
    self.navigationItem.rightBarButtonItem=anotherButton;
}



-(void)viewDidAppear:(BOOL)animated{
  
    [self loadObjects];
}
-(void)openSettingsView:(id)sender{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(appDelegate.userLogInStatus==0 && appDelegate.userFBLogInStatus==0)
    {
        UIAlertView *message1 = [[UIAlertView alloc] initWithTitle:@"Account Settings"
                                                           message:@"Please log in to view your account settings."
                                                          delegate:nil
                                                 cancelButtonTitle:@"OK"
                                                 otherButtonTitles:nil];
        message1.backgroundColor=[UIColor blackColor];
        
        [message1 show];
        return;
    }
    self.userSettingVC=[[UserSettingViewController alloc]initWithNibName:@"UserSettingViewController" bundle:nil];
    [self.navigationController pushViewController:self.userSettingVC animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Parse

- (void)objectsDidLoad:(NSError *)error {
    [super objectsDidLoad:error];
    
    // This method is called every time objects are loaded from Parse via the PFQuery
}

- (void)objectsWillLoad {
    [super objectsWillLoad];
    
    // This method is called before a PFQuery is fired to get more objects
}


// Override to customize what kind of query to perform on the class. The default is to query for
// all objects ordered by createdAt descending.

- (PFQuery *)queryForTable {
    //--  NSLog(@"Class name is %@",self.parseClassName);
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
 //display opportunities as per interests
    if(appDelegate.userLogInStatus==1 || appDelegate.userFBLogInStatus==1){
        NSString* uEmail= [[PFUser currentUser] objectForKey:@"email"];
        PFQuery *queryInterests = [PFQuery queryWithClassName:@"User_Interests"];
        
        if(appDelegate.userLogInStatus==1){
        [queryInterests whereKey:@"user_email" equalTo:uEmail];
        }else{
        [queryInterests whereKey:@"user_email" equalTo:appDelegate.userFbEmail];
        }
        
       NSArray *results= [queryInterests findObjects];
        self.intList=[[NSMutableArray alloc]init];
        for(PFObject *object in results) {
         //--   NSLog(@"Received Interest List  : %@",[object objectForKey:@"interest_name"]);
            [self.intList addObject:[object objectForKey:@"interest_name"]];
        }
        
        self.displayOpportunityQuery =[PFQuery queryWithClassName:self.parseClassName];
        
        if(!([self.intList count]==0)){
        [self.displayOpportunityQuery whereKey:@"meal_type" containedIn:self.intList];
            
        }
      
       }else{
      self.displayOpportunityQuery=[PFQuery queryWithClassName:self.parseClassName];
    }
   if ([self.objects count] == 0) {
        self.displayOpportunityQuery.cachePolicy = kPFCachePolicyCacheThenNetwork;
    }
    [self.displayOpportunityQuery orderByAscending:@"meal_id"];
    return self.displayOpportunityQuery;
    
   
}

//bifurcation start
- (void)findCallback:(NSArray *)results error:(NSError *)error {
    if (!error) {
        // The find succeeded.
             self.intList=[[NSMutableArray alloc]init];
        for (PFObject *object in results) {
            [self.intList addObject:[object objectForKey:@"interest_name"]];
           }
        self.displayOpportunityQuery =[PFQuery queryWithClassName:@"Meal"];
        [self.displayOpportunityQuery whereKey:@"meal_type" containedIn:self.intList];
        [self.displayOpportunityQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                // The find succeeded.
                NSLog(@"Successfully retrieved %d scores.!!!!!", objects.count);
            } else {
                // Log details of the failure
                NSLog(@"Error: %@ %@", error, [error userInfo]);
            }
        }];
        // NSLog(@"Total matching interests is %d",[retrieveOportunityQuery countObjects]);
    } else {
        // Log details of the failure
        NSLog(@"Error: %@ %@", error, [error userInfo]);
    }
    
    
}
//bifurcation end

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
                        object:(PFObject *)object {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    //to show the complete description
    cell.detailTextLabel.numberOfLines = 0;

    cell.accessoryType=UITableViewCellAccessoryDetailDisclosureButton;
    cell.textLabel.text = [object objectForKey:@"meal_name"];
    [cell.detailTextLabel setFont:[UIFont boldSystemFontOfSize:12]];
    cell.detailTextLabel.text = [object objectForKey:@"meal_description"];
    
    PFFile *theImage = [object objectForKey:@"meal_image"];
    
    NSData *imageData = [theImage getData];
    UIImage *image = [UIImage imageWithData:imageData];
    
    cell.imageView.image=image;
    return cell;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
   //  NSLog(@"in acccessory tap buton");
    NSString *sel;
    detailOpportunityVC=[[DetailOpportunityViewController alloc]initWithNibName:@"DetailOpportunityViewController" bundle:nil];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
      // [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    self.selected_opportunity = [self objectAtIndexPath:indexPath];
    sel=[self.selected_opportunity objectForKey:@"meal_name"];
     appDelegate.selectedOpportunity=sel;
    [self.navigationController pushViewController:detailOpportunityVC animated:YES];
    

}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}


@end
