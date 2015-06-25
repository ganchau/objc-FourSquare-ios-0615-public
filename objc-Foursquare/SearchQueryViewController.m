//
//  SearchQueryViewController.m
//  objc-Foursquare
//
//  Created by Gan Chau on 6/23/15.
//  Copyright (c) 2015 Zachary Drossman. All rights reserved.
//

#import "SearchQueryViewController.h"
#import <Foursquare-API-v2/Foursquare2.h>
#import "VenuesTableViewController.h"
#import "Venue.h"


@interface SearchQueryViewController ()
@property (weak, nonatomic) IBOutlet UITextField *searchQueryTextField;
@property (weak, nonatomic) IBOutlet UITextField *travelDistanceTextField;
@property (weak, nonatomic) IBOutlet UITextField *latitudeTextField;
@property (weak, nonatomic) IBOutlet UITextField *longitudeTextField;
@property (strong, nonatomic) NSArray *venuesObjects;

@end

@implementation SearchQueryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)searchButtonTapped:(id)sender
{
    NSString *searchQuery = self.searchQueryTextField.text;
    NSNumber *radius = @([self.travelDistanceTextField.text floatValue]);
    NSNumber *latitude = @([self.latitudeTextField.text floatValue]);
    NSNumber *longitude = @([self.longitudeTextField.text floatValue]);
    
    [Foursquare2 venueSearchNearByLatitude:latitude
                                 longitude:longitude
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

@end
