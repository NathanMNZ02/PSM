//
//  MPAllert.m
//  PlaceReminder
//
//  Created by Nathan Monzani on 13/06/23.
//

#import "MPAllert.h"

@implementation MPAllert

+(void)createWithText:(NSString*)text withTitle:(NSString *)title onViewController:(UIViewController*)viewcontroller{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:text preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok_action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [viewcontroller dismissViewControllerAnimated:YES completion:nil];
    }];

    [alert addAction:ok_action];
    [viewcontroller presentViewController:alert animated:YES completion:nil];
}


+(void)createWithText:(NSString*)text withTitle:(NSString *)title andAction:(do_action)act onViewController:(UIViewController*)viewcontroller{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:text preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction *yesAction = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                act();
                [viewcontroller dismissViewControllerAnimated:YES completion:nil];
        }];

        UIAlertAction *noAction = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [viewcontroller dismissViewControllerAnimated:YES completion:nil];
        }];

        [alertController addAction:yesAction];
        [alertController addAction:noAction];
        [viewcontroller presentViewController:alertController animated:YES completion:nil];
}

@end
