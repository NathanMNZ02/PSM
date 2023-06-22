//
//  MPLocations.h
//  PlaceReminder
//
//  Created by Nathan Monzani on 11/06/23.
//

#import <Foundation/Foundation.h>
#import "MPLocation.h"

NS_ASSUME_NONNULL_BEGIN

@interface MPLocations : NSObject

//Builder
-(instancetype)init;
-(instancetype)initWithLocations:(NSMutableArray*)locations;

//Attributes
@property NSMutableArray *locations;

//Methods
-(NSUInteger)size;
-(void)sorted_for_time_creation;
-(BOOL)find_name:(NSString*)name;
-(void)add_location:(MPLocation*)location;
-(void)remove:(MPLocation*)location;
- (void)removeAtIndex:(NSUInteger)index;
-(MPLocation*)get_at_index:(int)index;
-(void)printf;

@end

NS_ASSUME_NONNULL_END
