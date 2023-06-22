//
//  MPGeocoder.h
//  PlaceReminder
//
//  Created by Nathan Monzani on 13/06/23.
//

#import <Foundation/Foundation.h>
#import "MPLocation.h"
#import <CoreLocation/CoreLocation.h>
NS_ASSUME_NONNULL_BEGIN

@interface MPGeocoder : NSObject

+(void)reverse_on_location:(MPLocation*)location;
+(void)forward_on_location:(MPLocation*)location;

@end

NS_ASSUME_NONNULL_END
