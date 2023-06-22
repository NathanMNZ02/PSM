//
//  MPAllert.h
//  PlaceReminder
//
//  Created by Nathan Monzani on 13/06/23.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MPAllert : NSObject

typedef void (^do_action)(void);

+(void)createWithText:(NSString*)text withTitle:(NSString*)title onViewController:(UIViewController*)viewcontroller;

+(void)createWithText:(NSString*)text withTitle:(NSString *)title andAction:(do_action)act onViewController:(UIViewController*)viewcontroller;

@end

NS_ASSUME_NONNULL_END
