//
//  MPLocations.m
//  PlaceReminder
//
//  Created by Nathan Monzani on 11/06/23.
//

#import "MPLocations.h"
#import "MPLocation.h"

@implementation MPLocations

- (nonnull instancetype)init {
    if(self = [super init]){
        _locations = [[NSMutableArray alloc] init];
    }
    return self;
}

- (nonnull instancetype)initWithLocations:(NSMutableArray*)locations {
    if(self = [super init]){
        _locations = [[NSMutableArray alloc] init];
        for (NSDictionary *location in locations) {
            NSString *dateString = location[@"datetime"];
            NSDateFormatter *date_formatter = [[NSDateFormatter alloc] init];
            [date_formatter setDateFormat:@"HH:mm dd/MM/yyyy"];
            NSDate *date_from_string = [date_formatter dateFromString:dateString];
                                        
            [_locations addObject:[[MPLocation alloc] init_with_name:location[@"name"] and_description:location[@"description"] address:location[@"address"] latitude:location[@"latitude"] longitude:location[@"longitude"] datetime:date_from_string]];
        }
        
    }
    return self;
}

//Public methods
-(NSUInteger)size{
    return self.locations.count;
}

-(void)sorted_for_time_creation{
    self.locations = [[self.locations sortedArrayUsingComparator:^NSComparisonResult(MPLocation *loc1, MPLocation *loc2) {
        return [loc2.datetime compare:loc1.datetime];
    }] mutableCopy];
}

-(void)add_location:(MPLocation *)location{
    [self.locations addObject:location];
}

- (void)remove:(MPLocation*)location{
    if([self.locations containsObject:location] == YES){
        [self.locations removeObject:location];
    }
}

- (void)removeAtIndex:(NSUInteger)index{
    if([self.locations count] != 0){
        [self.locations removeObjectAtIndex:index];
    }
}

-(MPLocation*)get_at_index:(int)index{
    return [self.locations objectAtIndex:index];
}

-(BOOL)find_name:(NSString *)name{
    for (MPLocation *location in self.locations) {
        if(location.name == name){
            return YES;
        }
    }
    return NO;
}

-(void)printf{
    for (MPLocation *location in self.locations) {
        NSLog(@"Locations: %@, %@, %@, %f, %f", location.name, location.descr, location.address, location.coordinate_location.coordinate.latitude, location.coordinate_location.coordinate.longitude);
    }
}

@end
