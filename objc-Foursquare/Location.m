//
//  Location.m
//  objc-Foursquare
//
//  Created by Gan Chau on 6/23/15.
//  Copyright (c) 2015 Zachary Drossman. All rights reserved.
//

#import "Location.h"

@implementation Location

- (instancetype)init
{
    self = [self initWithlat:@0
                         lng:@0
                     address:@""
                        city:@""
                       state:@""
                  postalCode:@""
                     country:@""
                 crossStreet:@""];
    return self;
}

- (instancetype)initWithlat:(NSNumber *)lat
                        lng:(NSNumber *)lng
                    address:(NSString *)address
                       city:(NSString *)city
                      state:(NSString *)state
                 postalCode:(NSString *)postalCode
                    country:(NSString *)country
                crossStreet:(NSString *)crossStreet
{
    self = [super init];
    
    if (self) {
        _lat = lat;
        _lng = lng;
        _address = address;
        _city = city;
        _state = state;
        _postalCode = postalCode;
        _country = country;
        _crossStreet = crossStreet;
    }
    return self;
}

+ (NSArray *)locationsWithLocations:(NSArray *)locations
{
//    NSMutableArray *locationArray = [@[] mutableCopy];
//    
//    for (Location *location in locations) {
//        [locationArray addObject:location];
//    }
//    return [locationArray copy];
    
    NSMutableArray *locationArray = [@[] mutableCopy];
    for (NSDictionary *locationDictionary in locations) {
        Location *location = [Location locationWithLocationDictionary:locationDictionary];
        [locationArray addObject:location];
    }
    return [locationArray copy];
}

+ (instancetype)locationWithLocationDictionary:(NSDictionary *)locationDictionary
{
    Location *location = [[Location alloc] initWithlat:locationDictionary[@"lat"]
                                                   lng:locationDictionary[@"lng"]
                                               address:locationDictionary[@"address"]
                                                  city:locationDictionary[@"city"]
                                                 state:locationDictionary[@"state"]
                                            postalCode:locationDictionary[@"postalCode"]
                                               country:locationDictionary[@"country"]
                                           crossStreet:locationDictionary[@"crossStreet"]];
    
    return location;
}

@end
