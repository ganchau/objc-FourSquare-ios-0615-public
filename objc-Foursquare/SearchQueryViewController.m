//
//  SearchQueryViewController.m
//  objc-Foursquare
//
//  Created by Gan Chau on 6/23/15.
//  Copyright (c) 2015 Zachary Drossman. All rights reserved.
//

#import "SearchQueryViewController.h"
#import <Foursquare-API-v2/Foursquare2.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import "VenuesTableViewController.h"
#import "Venue.h"
#import <CoreLocation/CoreLocation.h>

@interface SearchQueryViewController () <CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *searchQueryTextField;
@property (weak, nonatomic) IBOutlet UITextField *travelDistanceTextField;
//@property (weak, nonatomic) IBOutlet UITextField *latitudeTextField;
//@property (weak, nonatomic) IBOutlet UITextField *longitudeTextField;
@property (strong, nonatomic) NSArray *venuesObjects;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;

@end

@implementation SearchQueryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // CGFloat width = self.view.frame.size.width;
    self.searchButton.layer.cornerRadius = 10;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

- (IBAction)searchButtonTapped:(id)sender
{
    self.locationManager = [[CLLocationManager alloc] init];
    
    self.locationManager.delegate = self;
    if(IS_OS_8_OR_LATER){
        NSUInteger code = [CLLocationManager authorizationStatus];
        if (code == kCLAuthorizationStatusNotDetermined && ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)] || [self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])) {
            // choose one request according to your business.
            if([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationAlwaysUsageDescription"]){
                [self.locationManager requestAlwaysAuthorization];
            } else if([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationWhenInUseUsageDescription"]) {
                [self.locationManager  requestWhenInUseAuthorization];
            } else {
                NSLog(@"Info.plist does not contain NSLocationAlwaysUsageDescription or NSLocationWhenInUseUsageDescription");
            }
        }
    }
    [self.locationManager startUpdatingLocation];

#define METERS_IN_MILES 1609.34
    
    NSString *searchQuery = self.searchQueryTextField.text;
    NSNumber *radius = @([self.travelDistanceTextField.text floatValue] * METERS_IN_MILES);
    //NSNumber *latitude = @([self.latitudeTextField.text floatValue]);
    //NSNumber *longitude = @([self.longitudeTextField.text floatValue]);
    [SVProgressHUD show];
    [Foursquare2 venueSearchNearByLatitude:@(self.locationManager.location.coordinate.latitude)
                                 longitude:@(self.locationManager.location.coordinate.longitude)
                                     query:searchQuery
                                     limit:@100 // We'll allow 100 results
                                    intent:intentBrowse
                                    radius:radius
                                categoryId:nil
                                  callback:^(BOOL success, id result) {
                                      NSLog(@"%@", result); // This log message prints a dictionary of data returned from the API
                                      NSArray *venuesDictionaries = result[@"response"][@"venues"];
                                      self.venuesObjects = [Venue venuesWithVenueDictionaries:venuesDictionaries];
                                      [self performSegueWithIdentifier:@"displaySearchSegue" sender:sender];
                                      [SVProgressHUD dismiss];
                                  }];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    VenuesTableViewController *venuesTableViewDestinationVC = segue.destinationViewController;
    venuesTableViewDestinationVC.venues = self.venuesObjects;
    venuesTableViewDestinationVC.navigationItem.title = self.searchQueryTextField.text;
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

//- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
//{
//    NSLog(@"didUpdateToLocation: %@", newLocation);
//    CLLocation *currentLocation = newLocation;
//    
//    if (currentLocation != nil) {
//        NSString *lat = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
//        NSString *lng = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
//    }
//}

@end
