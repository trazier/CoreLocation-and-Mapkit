//
//  Location.h
//  MapApp
//
//  Created by Frazier Moore on 3/4/14.
//  Copyright (c) 2014 Frazier Moore. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface Location : NSObject <MKAnnotation>

@property (strong,nonatomic) NSString *ceo;
@property (strong,nonatomic) NSString *name;
@property (strong,nonatomic) NSString *address;

@property (nonatomic) CLLocationCoordinate2D coordinate;

@end
