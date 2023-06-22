//
//  MPJsonManager.m
//  PlaceReminder
//
//  Created by Nathan Monzani on 12/06/23.
//

#import "MPJsonManager.h"

@implementation MPJsonManager

//Builder
-(instancetype)init{
    if(self = [super init]){
        NSString *fileName = @"locations.json";
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        _json_path = [documentsDirectory stringByAppendingPathComponent:fileName];
    }
    return self;
}

//Public instance method
-(NSMutableArray*)deserialize{
    NSError *error;
    NSData *jsonData = [[NSString stringWithContentsOfFile:self.json_path encoding:NSUTF8StringEncoding error:&error] dataUsingEncoding:NSUTF8StringEncoding];

    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    if ([jsonObject isKindOfClass:[NSMutableArray class]]) {
        return jsonObject;
    }
    
    return nil;
}

-(void)serialize:(NSMutableArray*)locations{
    NSError *error;
    
    NSMutableArray *serializedArray = [[NSMutableArray alloc]init];

    for (MPLocation *location in locations) {
        NSDictionary *dict = [location convert_to_dictionary];
        [serializedArray addObject:dict];
    }
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:serializedArray options:NSJSONWritingPrettyPrinted error:&error];

    if (!jsonData) {
        NSLog(@"Errore nella conversione in JSON: %@", error.localizedDescription);
    } else {
        [MPFileManager update_file:self.json_path with_content:jsonData];
    }
}

@end
