//
//  DetailsViewController.h
//  PlaceReminder
//
//  Created by Nathan Monzani on 14/06/23.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MPLocation.h"
#import "MPLocation+LocationPin.h"
#import "MPAllert.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailsViewController : UIViewController<MKMapViewDelegate>

@property (strong, nonatomic) MPLocation *location;

@end

NS_ASSUME_NONNULL_END
