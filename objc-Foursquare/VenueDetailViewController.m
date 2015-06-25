//
//  VenueDetailViewController.m
//  objc-Foursquare
//
//  Created by Gan Chau on 6/23/15.
//  Copyright (c) 2015 Zachary Drossman. All rights reserved.
//

#import "VenueDetailViewController.h"
#import "Location.h"

@interface VenueDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *venueIDLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UILabel *postalCodeLabel;
@property (weak, nonatomic) IBOutlet UILabel *crossStreetLabel;

@end

@implementation VenueDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.venueIDLabel.text = self.venue.venueId;
    NSLog(@"This is location: %@", self.venue.location);
    
    Location *location = self.venue.location;
    self.addressLabel.text = location.address;
    self.cityLabel.text = location.city;
    self.stateLabel.text = location.state;
    self.postalCodeLabel.text = location.postalCode;
    self.crossStreetLabel.text = location.crossStreet;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
