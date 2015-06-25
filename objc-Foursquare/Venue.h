//
//  Venue.h
//  objc-Foursquare
//
//  Created by Gan Chau on 6/23/15.
//  Copyright (c) 2015 Zachary Drossman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Location.h"

@interface Venue : NSObject

@property (nonatomic,strong)NSString *name;
@property (nonatomic,strong)NSString *venueId;
@property (nonatomic,strong)Location *location;

- (instancetype)initWithName:(NSString *)name
                     venueId:(NSString *)venueId
                    location:(Location *)location;

// These Methods are not Required, but are convenience methods that make your life much easier.   Essentially, they allow you to pass in a dictionary or array of dictionaries and return a Venue or array of Venues.
 
+ (NSArray *)venuesWithVenueDictionaries:(NSArray *)venues; // takes an Array of venue dictionaries and returns an array of Venue objects
+ (instancetype)venueWithVenueDictionary:(NSDictionary *)venueDictionary;  // takes a dictionary and returns a venue.

@end
