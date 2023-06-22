//
//  MPGeocoder.m
//  PlaceReminder
//
//  Created by Nathan Monzani on 13/06/23.
//

#import "MPGeocoder.h"

@implementation MPGeocoder
+(void)reverse_on_location:(MPLocation *)location{
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    [geocoder reverseGeocodeLocation:location.coordinate_location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        NSNumber *success = @0;
        
        if (placemarks.count > 0) {
            CLPlacemark *placemark = placemarks.firstObject;
            NSString *address = [placemark name];
            NSString *city = [placemark locality];
            NSString *state = [placemark administrativeArea];
            NSString *country = [placemark country];
            
            location.address = [NSString stringWithFormat:@"%@, %@, %@, %@", address, city, state, country];
            success = @1;
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Geocode_finished" object:nil userInfo:@{@"success": success, @"location": location}];
    }];
}

+(void)forward_on_location:(MPLocation *)location{
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    [geocoder geocodeAddressString:location.address completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        NSNumber *success = @0;
        
        if (placemarks.count > 0) {
            CLPlacemark *placemark = placemarks.firstObject;
            location.coordinate_location = placemark.location;
            success = @1;
        }
            
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Geocode_finished" object:nil userInfo:@{@"success": success, @"location": location}];
    }];
}

@end
