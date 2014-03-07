//
//  MAViewController.h
//  MapApp
//
//  Created by Frazier Moore on 3/4/14.
//  Copyright (c) 2014 Frazier Moore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MAViewController : UIViewController <MKMapViewDelegate,CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
    CLLocation *currentLocation;
}
@end
