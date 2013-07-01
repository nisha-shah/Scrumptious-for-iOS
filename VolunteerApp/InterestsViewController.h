//
//  InterestsViewController.h
//  VolunteerApp
//
//  Created by Nisha Shah on 6/10/13.
//  Copyright (c) 2013 Nisha Shah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface InterestsViewController :  UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *interestsList;

@end
