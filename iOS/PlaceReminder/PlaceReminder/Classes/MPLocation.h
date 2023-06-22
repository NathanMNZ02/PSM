//
//  Location.h
//  PlaceReminder
//
//  Created by Nathan Monzani on 10/06/23.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MPLocation : NSObject

@property CLLocation *coordinate_location;
@property NSString* address;
@property NSString *name;
@property NSString *descr;
@property NSDate *datetime;

-(instancetype)init_with_name:(NSString*)name and_description:(NSString*)descr address:(NSString*)address latitude:(NSNumber*)latitude longitude:(NSNumber*)longitude datetime:(NSDate*)datetime;

-(instancetype)init_with_name:(NSString*)name and_description:(NSString*)descr latitude:(NSNumber*)latitude longitude:(NSNumber*)longitude datetime:(NSDate*)datetime;

-(instancetype)init_with_name:(NSString*)name and_description:(NSString*)descr address:(NSString*)address datetime:(NSDate*)datetime;

-(NSDictionary*)convert_to_dictionary;

@end

NS_ASSUME_NONNULL_END
