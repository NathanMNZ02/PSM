//
//  LocationsTableViewController.m
//  PlaceReminder
//
//  Created by Nathan Monzani on 12/06/23.
//

#import "LocationsTableViewController.h"

@interface LocationsTableViewController ()

@property MPLocations *locations;
@property BOOL eliminator;

@end

@implementation LocationsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MPJsonManager *json_manager = [[MPJsonManager alloc]init];
    self.locations = [[MPLocations alloc]init];
    
    if([MPFileManager file_exist:json_manager.json_path] == YES){
        self.locations = [[MPLocations alloc] initWithLocations:[json_manager deserialize]];
    }
    
    if([MPFileManager file_exist:json_manager.json_path] == NO || [self.locations size] == 0){
        [MPAllert createWithText:@"No locations entered yet" withTitle:@"Place Reminder"  onViewController:self];
    }
    
    [self.locations sorted_for_time_creation];
    self.eliminator = NO;
}

- (void)showViewController:(UIViewController *)vc sender:(nullable id)sender {
    if(self.eliminator == NO){
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        [self.locations removeAtIndex:indexPath.row];
        MPJsonManager *json_manger = [[MPJsonManager alloc]init];
        [json_manger serialize:self.locations.locations];
        [self.tableView reloadData];
        
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqual:@"cell-location_details"]){
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        DetailsViewController *dcv = (DetailsViewController*)segue.destinationViewController;
        dcv.location = [self.locations get_at_index:(int)indexPath.row];
    }
}

- (IBAction)active_eliminator:(UIButton *)sender {
    if(self.eliminator){
        self.eliminator = NO;
        sender.tintColor = [UIColor lightGrayColor];
    }else{
        self.eliminator = YES;
        [MPAllert createWithText:@"Click on the cells to delete them" withTitle:@"PlaceReminder" onViewController:self];
        sender.tintColor = [UIColor linkColor];
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.locations size];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"locations_cell" forIndexPath:indexPath];
        
    MPLocation *location = [self.locations get_at_index:(int)indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", location.name];
    [cell.accessoryView addSubview:[UIButton systemButtonWithImage:[UIImage systemImageNamed:@"trash"] target:Nil action:nil]];
    return cell;
}

@end
