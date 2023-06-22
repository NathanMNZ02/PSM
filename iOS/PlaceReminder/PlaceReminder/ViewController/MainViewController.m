//
//  ViewController.m
//  PlaceReminder
//
//  Created by Nathan Monzani on 10/06/23.
//

#import "MainViewController.h"

@interface MainViewController()

@property (strong, nonatomic) MPLocations *location_list;
@property (strong, nonatomic) CLLocationManager *location_manager;
@property (strong, nonatomic) UNUserNotificationCenter *notification_center;

- (void)sendLocalNotification:(NSString*)position;
-(NSMutableArray*)get_all_regions;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Place reminder";
    
    MPJsonManager *json_manager = [[MPJsonManager alloc]init];
    if([MPFileManager file_exist:json_manager.json_path]){
         self.location_list = [[MPLocations alloc] initWithLocations:[json_manager deserialize]];
    }
    
    self.notification_center = [UNUserNotificationCenter currentNotificationCenter];
    [self.notification_center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert | UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionProvidesAppNotificationSettings) completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (!granted) {
            [MPAllert createWithText:@"Attention, by not allowing the app to send you local notifications you are denying it the possibility of notifying you when you enter a region of your interest" withTitle:@"PlaceReminder" onViewController:self];
        }
    }];
    
    self.location_manager = [[CLLocationManager alloc] init];
    self.location_manager.delegate = self;
    self.location_manager.allowsBackgroundLocationUpdates = YES;
    self.location_manager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [self.location_manager requestAlwaysAuthorization];
    
    if(self.location_manager.authorizationStatus == kCLAuthorizationStatusAuthorizedAlways){
        for (CLCircularRegion* region in [self get_all_regions]) {
            [self.location_manager startMonitoringForRegion:region];
        }
    }else{
        [MPAllert createWithText:@"Attention your application does not have the necessary permissions to access your position, so you will not allow it to notify you when you enter a position of your interest" withTitle:@"PlaceReminder" onViewController:self];
    }
}

//Private methods
- (void)sendLocalNotification:(NSString*)position {
    self.notification_center = [UNUserNotificationCenter currentNotificationCenter];
    self.notification_center.delegate = self;

    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = @"MyCurrency";
    NSString *body_text = [NSString stringWithFormat:@"You have entered the zone of %@", position];
    content.body = body_text;
    content.sound = [UNNotificationSound defaultSound];
    
    NSString *identifier = @"NTLocation";
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:identifier content:content trigger:nil];
    
    [self.notification_center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        if(!error) {
            NSLog(@"Add notification");
        }
    }];
}

-(NSMutableArray*)get_all_regions{
    NSMutableArray *regions = [[NSMutableArray alloc]init];
    for (MPLocation* location in self.location_list.locations) {
        CLCircularRegion* region =[[CLCircularRegion alloc] initWithCenter:location.coordinate_location.coordinate radius:1 identifier:location.name];
        region.notifyOnEntry=YES;
        region.notifyOnExit=YES;
        [regions addObject:region];
    }
    
    return regions;
}

//Actions
- (IBAction)trash:(id)sender {
    [MPAllert createWithText:@"Are you sure that do you want to delete saved locations?" withTitle:@"PlaceReminder" andAction:^(void){
        MPJsonManager *json_manager = [[MPJsonManager alloc] init];
        [MPFileManager file_delete:json_manager.json_path];
    } onViewController:self];
}

//Delegate CLLocation
-(void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region{
    [self sendLocalNotification:region.identifier];
}

-(void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region{
    NSLog(@"Start monitoring %@", region.identifier);
}

-(void)locationManager:(CLLocationManager *)manager monitoringDidFailForRegion:(CLRegion *)region withError:(NSError *)error{
    NSLog(@"Monitoring failed for region %@", region.identifier);
}

//Delegate UNNotification
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler{
    
    completionHandler(UNNotificationPresentationOptionList | UNNotificationPresentationOptionBanner | UNNotificationPresentationOptionSound);
}


@end
