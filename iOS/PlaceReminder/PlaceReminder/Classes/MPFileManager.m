//
//  MPFileManager.m
//  PlaceReminder
//
//  Created by Nathan Monzani on 13/06/23.
//

#import "MPFileManager.h"

@implementation MPFileManager

+(BOOL)file_exist:(NSString*)path{
    NSFileManager *file_manager = [NSFileManager defaultManager];
    if (![file_manager fileExistsAtPath:path]) {
        return NO;
    }
    return YES;
}

+(void)file_delete:(NSString*)path{
    NSFileManager *file_manager = [NSFileManager defaultManager];
    if ([self file_exist:path] == YES)
        [file_manager removeItemAtPath:path error:nil];
}

+(void)file_create:(NSString*)path with_content:(NSData *)data{
    NSFileManager *file_manager = [NSFileManager defaultManager];
    if ([self file_exist:path] == NO)
        [file_manager createFileAtPath:path contents:data attributes:nil];
}

+(void)read_file:(NSString *)path{
    if([self file_exist:path] == YES){
        NSString *file_content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:Nil];
        
        if (file_content) {
            NSLog(@"Contenuto del file:\n%@", file_content);
        }
    }
}

+(void)update_file:(NSString*)path with_content:(NSData *)data{
    if([self file_exist:path] == YES){
        NSString *json_string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        [json_string writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
    }else{
        [self file_create:path with_content:data];
    }
}

@end
