//
//  InterestsTableViewController.m
//  VolunteerApp
//
//  Created by Nisha Shah on 6/17/13.
//  Copyright (c) 2013 Nisha Shah. All rights reserved.
//

#import "InterestsTableViewController.h"
#import <Parse/Parse.h>
#import "AppDelegate.h"

@implementation InterestsTableViewController
@synthesize userInterests;
@synthesize currentUser;
@synthesize fbEmailId;
@synthesize browseOpportunityVC;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
      
    }
    
   
    return self;
}

- (void)viewDidLoad
{
    NSString *emailForUser;
    self.navigationItem.title=@"Pick Interests";
    //multiple selection
    self.tableView.allowsMultipleSelection = YES;
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.parseClassName=@"Interests";
    self.textKey = @"interest_name";
    [super viewDidLoad];
    
    //Done button on top right navigation bar
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(collectInterests)];
    self.navigationItem.rightBarButtonItem=anotherButton;
    
    //if user is logged in through facebook , get his fb email .If logged in thoough parse, get his PFUser email.
   self.currentUser = [PFUser currentUser];
    if (appDelegate.userFBLogInStatus==0)
    {
        NSString* uEmail= [[PFUser currentUser] objectForKey:@"email"];
        emailForUser=uEmail;
    }else if(appDelegate.userFBLogInStatus==1)
    {
        self.fbEmailId=appDelegate.userFbEmail;
        emailForUser=self.fbEmailId;
     }
    PFQuery *query = [PFQuery queryWithClassName:@"User_Interests"];
    [query whereKey:@"user_email" equalTo:emailForUser];
    [query findObjectsInBackgroundWithTarget:self
                                    selector:@selector(findCallback:error:)];
    

    

}


- (void)findCallback:(NSArray *)results error:(NSError *)error {
    if (!error) {
        self.userInterests=results;
       /* for (PFObject *object in self.userInterests) {
            NSLog(@"%@",[object objectForKey:@"interest_name"]);
        }*/
    } else {
        NSLog(@"Error: %@ %@", error, [error userInfo]);
    }

}



- (PFQuery *)queryForTable {
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    // If no objects are loaded in memory, we look to the cache
    // first to fill the table and then subsequently do a query
    // against the network.
    if ([self.objects count] == 0) {
        query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    }
    [query orderByAscending:@"interest_id"];
    return query;
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
                        object:(PFObject *)object {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell to show todo item with a priority at the bottom
    cell.textLabel.text = [object objectForKey:@"interest_name"];
    
    
    for (PFObject *object in self.userInterests) {
        NSString *a=[object objectForKey:@"interest_name"];
        if([a isEqualToString:cell.textLabel.text]){
          //--  NSLog(@"contains");
            cell.accessoryType=UITableViewCellAccessoryCheckmark;
        }
    }    
    
    return cell;
}

//to checkmark row data 
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
}

//to uncheck row data 
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
}


-(void)collectInterests{
 //-   NSLog(@"IN collect interests");
    NSMutableArray *array=[[NSMutableArray alloc]init];
    
    //collect the checkmarked objects 
    for(int i=0; i<[self.objects count];i++){
         NSIndexPath *path = [NSIndexPath indexPathForRow:i inSection:0];
         UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:path];
        if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
          //  [array appendFormat:@"%@",cell.textLabel.text];
            [array addObject:cell.textLabel.text];
        }
      }
    
     //displaying the checkmarked objs
  //--   NSLog(@"Total number of selected rows are %d",[array count]);
   /* for(NSString* ob in array){
       // NSLog(@"ele is %@",ob);
    }*/
[self populateInterestsInTable:array];

    
}

-(void)populateInterestsInTable :(NSMutableArray *)interestList{
  //  NSLog(@"In populate interests in table");
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
   
    //delete the existing records for the current email logged in .
    PFQuery *deleteQuery=[PFQuery queryWithClassName:@"User_Interests"];
 
    //if parse user, query email from PFUser table ,else get email from appDel variable
    if(self.currentUser){
        //for parse logged in user
    [deleteQuery whereKey:@"user_email" equalTo:self.currentUser.email];
    }else{
     //for fb logged in user
        [deleteQuery whereKey:@"user_email" equalTo:self.fbEmailId];
    }
    
    
    //execute the delete query 
    [deleteQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            //results found
            for (PFObject *object in objects) {
                [object deleteInBackground];
            }
           //insert the new records in table 
            for(NSString* ob in interestList)
           {
              PFObject *insertInterestQuery = [PFObject objectWithClassName:@"User_Interests"];
              [insertInterestQuery setObject:ob forKey:@"interest_name"];
               if(appDelegate.userFBLogInStatus==0){
                   //for parse signed in user
                  [insertInterestQuery setObject:self.currentUser.email forKey:@"user_email"];
               }else{
                   //for fb signed in user
                   [insertInterestQuery setObject:self.fbEmailId forKey:@"user_email"];
                  }
              [insertInterestQuery saveInBackground];
           }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    self.browseOpportunityVC=[[BrowseOpportunityTableViewController alloc]initWithNibName:@"BrowseOpportunityTableViewController" bundle:nil];
    [self.navigationController pushViewController:self.browseOpportunityVC animated:YES];
    
    
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



//Parse

- (void)objectsDidLoad:(NSError *)error {
    [super objectsDidLoad:error];
    
    // This method is called every time objects are loaded from Parse via the PFQuery
}

- (void)objectsWillLoad {
    [super objectsWillLoad];
    
    // This method is called before a PFQuery is fired to get more objects
}

-(void)viewWillAppear:(BOOL)animated{
    [self viewDidLoad];
}

@end
