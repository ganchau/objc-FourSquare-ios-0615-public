//
//  Venue.m
//  objc-Foursquare
//
//  Created by Gan Chau on 6/23/15.
//  Copyright (c) 2015 Zachary Drossman. All rights reserved.
//

#import "Venue.h"

@implementation Venue

- (instancetype)init
{
    self = [self initWithName:@"" venueId:@"" location:[[Location alloc] init]];
    return self;
}

- (instancetype)initWithName:(NSString *)name
                     venueId:(NSString *)venueId
                    location:(Location *)location;
{
    self = [super init];
    
    if (self) {
        _name = name;
        _venueId = venueId;
        _location = location;
    }
    return self;
}

+ (NSArray *)venuesWithVenueDictionaries:(NSArray *)venues
{
    NSMutableArray *venueArray = [@[] mutableCopy];
    for (NSDictionary *venueDictionary in venues) {
        Venue *venue = [Venue venueWithVenueDictionary:venueDictionary];
        [venueArray addObject:venue];
    }
    return [venueArray copy];
}

+ (instancetype)venueWithVenueDictionary:(NSDictionary *)venueDictionary
{
    Venue *venue = [[Venue alloc] initWithName:venueDictionary[@"name"]
                                       venueId:venueDictionary[@"id"]
                                      location:[Location locationWithLocationDictionary:venueDictionary[@"location"]]];
    return venue;
}

@end
