//
//  MAViewController.m
//  MapApp
//
//  Created by Frazier Moore on 3/4/14.
//  Copyright (c) 2014 Frazier Moore. All rights reserved.
//

#import "MAViewController.h"
#import <MapKit/MapKit.h>
#import "Location.h"
#import <MobileCoreServices/MobileCoreServices.h>

#define METERS_PER_MILE 1609.344

@interface MAViewController ()

@property (strong, nonatomic) MKMapView *myMapView;

@property (strong, nonatomic) NSMutableArray *locationArray;

@end

@implementation MAViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if([CLLocationManager locationServicesEnabled] && [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorized)
    {
        self.locationArray = [NSMutableArray new];
        
        [self CurrentLocationIdentifier];
        [self addLocations];
        
        self.myMapView = [[MKMapView alloc] initWithFrame:self.view.frame];
        self.myMapView.delegate = self;
        [self.view addSubview:self.myMapView];
    }
    
    else
    {
        NSLog(@"You pressed the wrong damn button");
    }
}

- (IBAction)refreshMap:(id)sender {
    [locationManager startUpdatingLocation];
    
}

-(void)CurrentLocationIdentifier
{
    locationManager = [CLLocationManager new];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    currentLocation = [locations objectAtIndex:0];
    [locationManager stopUpdatingLocation];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init] ;
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error)
     {
         if (!(error))
         {
             CLPlacemark *placemark = [placemarks objectAtIndex:0];
             CLLocation *currLocation = [CLLocation new];
             currLocation = placemark.location;
             CLLocationCoordinate2D coordinates = currLocation.coordinate;
             
             MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(coordinates, 3 * METERS_PER_MILE, 3 * METERS_PER_MILE);
             
            [self.myMapView setRegion:viewRegion animated:YES];

            [self.myMapView addAnnotation:currentLocation];
         }
     }];
}

- (void) addLocations
{
    Location *location1 = [Location new];
    location1.ceo = @"Peter Hamilton";
    location1.name = @"HasOffers";
    location1.address = @"2220 Western Ave";
    
    CLLocationCoordinate2D tempCoordinate1;
    tempCoordinate1.longitude = 47.6124422;
    tempCoordinate1.latitude = -122.3464986;
    
    location1.coordinate = tempCoordinate1;
    
    [self.locationArray addObject:location1];
    
    [self.myMapView addAnnotation:location1];
    
    NSLog(@"Added to map");
}

- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    NSString *identifier = @"MyLocation";
    
    MKAnnotationView *annotationView = (MKAnnotationView *) [self.myMapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    annotationView.enabled = YES;
    annotationView.canShowCallout = YES;
        
    return annotationView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
