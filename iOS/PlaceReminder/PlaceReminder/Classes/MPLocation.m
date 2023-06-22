//
//  Location.m
//  PlaceReminder
//
//  Created by Nathan Monzani on 10/06/23.
//

#import "MPLocation.h"

@implementation MPLocation

-(instancetype)init_with_name:(NSString*)name and_description:(NSString*)descr address:(NSString*)address latitude:(NSNumber*)latitude longitude:(NSNumber*)longitude datetime:(NSDate*)datetime{
    if(self = [super init]){
        _address = address;
        _coordinate_location = [[CLLocation alloc]initWithLatitude:[latitude doubleValue] longitude:[longitude doubleValue]];
        _name = name;
        _descr = descr;
        _datetime = datetime;
    }
    return self;
}

-(instancetype)init_with_name:(NSString*)name and_description:(NSString*)descr latitude:(NSNumber*)latitude longitude:(NSNumber*)longitude datetime:(NSDate*)datetime{
    if(self = [super init]){
        _coordinate_location = [[CLLocation alloc]initWithLatitude:[latitude doubleValue] longitude:[longitude doubleValue]];
        _name = name;
        _descr = descr;
        _datetime = NSDate.now;
    }
    return self;
}

-(instancetype)init_with_name:(NSString*)name and_description:(NSString*)descr address:(NSString*)address datetime:(NSDate*)datetime{
    if(self = [super init]){
        _address = address;
        _name = name;
        _descr = descr;
        _datetime = NSDate.now;
    }
    return self;
}

-(NSDictionary*)convert_to_dictionary{
    NSDateFormatter *date_formatter = [[NSDateFormatter alloc] init];
    [date_formatter setDateFormat:@"HH:mm dd/MM/yyyy"];
    NSString *date_string = [date_formatter stringFromDate:self.datetime];
    
    NSDictionary *location = @{
        @"name": self.name,
        @"description": self.descr,
        @"address": self.address,
        @"latitude": @(self.coordinate_location.coordinate.latitude),
        @"longitude": @(self.coordinate_location.coordinate.longitude),
        @"datetime": date_string
    };
    
    return location;
}

@end
