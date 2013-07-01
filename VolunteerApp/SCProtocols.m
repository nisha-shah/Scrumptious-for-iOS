//
//  SCProtocols.m
//  VolunteerApp
//
//  Created by Nisha Shah on 6/18/13.
//  Copyright (c) 2013 Nisha Shah. All rights reserved.
//

#import "SCProtocols.h"

#import <Foundation/Foundation.h>
#import <FacebookSDK/FacebookSDK.h>

@protocol SCOGMeal<FBGraphObject>

@property (retain, nonatomic) NSString *id;
@property (retain, nonatomic) NSString *url;

@end

@protocol SCOGEatMealAction<FBOpenGraphAction>

@property (retain, nonatomic) id<SCOGMeal> meal;

@end

