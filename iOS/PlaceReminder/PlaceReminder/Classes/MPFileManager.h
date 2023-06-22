//
//  MPFileManager.h
//  PlaceReminder
//
//  Created by Nathan Monzani on 13/06/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MPFileManager : NSObject

+(BOOL)file_exist:(NSString*)path;
+(void)file_delete:(NSString*)path;
+(void)file_create:(NSString*)path with_content:(NSData*)data;
+(void)read_file:(NSString*)path;
+(void)update_file:(NSString*)path with_content:(NSData*)data;

@end

NS_ASSUME_NONNULL_END
