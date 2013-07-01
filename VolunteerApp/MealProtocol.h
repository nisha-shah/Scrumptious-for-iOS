//
//  MealProtocol.h
//  VolunteerApp
//
//  Created by Nisha Shah on 6/27/13.
//  Copyright (c) 2013 Nisha Shah. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FacebookSDK/FacebookSDK.h>

//@protocol MealProtocol <NSObject>
@protocol OGMeal<FBGraphObject>

@property (retain, nonatomic) NSString  *id;
@property (retain, nonatomic) NSString  *url;

@end

// Wraps an Open Graph object (of type "scrumps:eat") with a relationship to a meal,
// as well as properties inherited from FBOpenGraphAction such as "place" and "tags".
@protocol SCOGMealAction<FBOpenGraphAction>

@property (retain, nonatomic) id<OGMeal>   eat;

@end

