//
//  InterestsViewController.m
//  VolunteerApp
//
//  Created by Nisha Shah on 6/10/13.
//  Copyright (c) 2013 Nisha Shah. All rights reserved.
//

#import "InterestsViewController.h"
#import <Parse/Parse.h>


@implementation InterestsViewController
@synthesize interestsList;

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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma table view for causes lists

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
   
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UIImageView * image;
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    switch (indexPath.row) {
        case 0:cell.textLabel.text=@"Children & Youth";
            break;
            
        case 1:cell.textLabel.text=@"Arts & Culture";
            break;
            
        case 2:cell.textLabel.text=@"Animals";
            break;
            
        case 3:cell.textLabel.text=@"MORE CAUSES";
            break;
            
        default:
            break;
    }
    
    
    // Configure the cell...
    
    return cell;
}

- (float) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}


@end
