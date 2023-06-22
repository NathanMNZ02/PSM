//
//  DetailsViewController.m
//  PlaceReminder
//
//  Created by Nathan Monzani on 14/06/23.
//

#import "DetailsViewController.h"

@interface DetailsViewController ()

@property (weak, nonatomic) IBOutlet MKMapView *mapkit_location;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.location.name;
    
    MKCoordinateRegion map_region;
    map_region.center = self.location.coordinate_location.coordinate;
    map_region.span.latitudeDelta = 0.1;
    map_region.span.longitudeDelta = 0.1;
    self.mapkit_location.delegate = self;
    self.mapkit_location.showsUserLocation = YES;
    [self.mapkit_location setRegion:map_region animated:YES];
    [self.mapkit_location addAnnotation:self.location];
}

-(MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    NSLog(@"Chiamato");
    static NSString *annotation_id = @"MapAnnotationView"; //ID
    MKAnnotationView *annotation_view = [mapView dequeueReusableAnnotationViewWithIdentifier:annotation_id]; //Creazione vista annotazione
    
    if(!annotation_view){
        annotation_view = [[MKMarkerAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annotation_id];
        
        annotation_view.canShowCallout = YES;
    }
    
    annotation_view.annotation = annotation;
    annotation_view.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeInfoDark];
    
    return annotation_view;
}

-(void) mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
    NSString *allert_text = [NSString stringWithFormat:@"Description = %@\nAddress = %@\nLatitude = %f\nLongitude = %f", self.location.descr, self.location.address, self.location.coordinate_location.coordinate.latitude, self.location.coordinate_location.coordinate.longitude];

    if([control isEqual:view.rightCalloutAccessoryView]){
        [MPAllert createWithText:allert_text withTitle:@"Location details" onViewController:self];
    }
}
@end
