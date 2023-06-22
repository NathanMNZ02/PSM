//
//  MPLocation+LocationPin.m
//  PlaceReminder
//
//  Created by Nathan Monzani on 14/06/23.
//

#import "MPLocation+LocationPin.h"

@interface MPLocation (LocationPin)<MKAnnotation>

@end

@implementation MPLocation (LocationPin)
-(CLLocationCoordinate2D)coordinate{
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = self.coordinate_location.coordinate.latitude;
    coordinate.longitude = self.coordinate_location.coordinate.longitude;
    return coordinate;
}

-(NSString *)title{
    NSString* displayName;
    displayName = self.name;
    return displayName;
}

@end
