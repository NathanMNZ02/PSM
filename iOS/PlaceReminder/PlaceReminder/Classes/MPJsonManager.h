//
//  MPJsonManager.h
//  PlaceReminder
//
//  Created by Nathan Monzani on 12/06/23.
//

#import <Foundation/Foundation.h>
#import "MPLocations.h"
#import "MPFileManager.h"


NS_ASSUME_NONNULL_BEGIN

@interface MPJsonManager : NSObject

-(instancetype)init;

@property NSString *json_path;

-(NSMutableArray*)deserialize;

-(void)serialize:(NSMutableArray*)locations;

@end

NS_ASSUME_NONNULL_END
