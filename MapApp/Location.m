//
//  Location.m
//  MapApp
//
//  Created by Frazier Moore on 3/4/14.
//  Copyright (c) 2014 Frazier Moore. All rights reserved.
//

#import "Location.h"
#import <AddressBook/AddressBook.h>

@implementation Location

- (NSString *) title
{
    return self.name;
}

- (NSString *) subtitle
{
    return self.address;
}

- (CLLocationCoordinate2D) coordinate
{
    return _coordinate;
}

- (MKMapItem *) mapItem
{
    NSDictionary *addressDict = @{(NSString *)kABPersonAddressStreetKey: _address};
    MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:self.coordinate addressDictionary:addressDict];
    MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
    
    mapItem.name = self.title;
    
    return mapItem;
}

@end