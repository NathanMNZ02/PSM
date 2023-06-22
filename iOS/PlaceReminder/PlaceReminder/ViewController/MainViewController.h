//
//  ViewController.h
//  PlaceReminder
//
//  Created by Nathan Monzani on 10/06/23.
//

#import <UIKit/UIKit.h>
#import "MPJsonManager.h"
#import "MPFileManager.h"
#import "MPAllert.h"
#import <CoreLocation/CoreLocation.h>
#import <UserNotifications/UserNotifications.h>

@interface MainViewController : UIViewController<CLLocationManagerDelegate, UNUserNotificationCenterDelegate>


@end

