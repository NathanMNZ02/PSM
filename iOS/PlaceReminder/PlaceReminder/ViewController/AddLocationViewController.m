//
//  AddLocationViewController.m
//  PlaceReminder
//
//  Created by Nathan Monzani on 12/06/23.
//

#import "AddLocationViewController.h"

@interface AddLocationViewController ()<UITextFieldDelegate>
//Attributes
@property (nonatomic, strong) MPLocations *locations;

//Outlet
@property (nonatomic, weak) IBOutlet UITextField *text_name;
@property (weak, nonatomic) IBOutlet UITextField *text_latitude;
@property (weak, nonatomic) IBOutlet UITextField *text_longitude;
@property (weak, nonatomic) IBOutlet UITextField *text_address;
@property (weak, nonatomic) IBOutlet UITextField *text_description;
@property (weak, nonatomic) IBOutlet UISwitch *switch_advanced;
@property (weak, nonatomic) IBOutlet UIView *view_street;
@property (weak, nonatomic) IBOutlet UILabel *support_label;

@end

@implementation AddLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.switch_advanced.on = NO;
    self.locations = [[MPLocations alloc] init];
    self.text_name.delegate = self;
    self.text_description.delegate = self;
    self.text_latitude.delegate = self;
    self.text_longitude.delegate = self;
    self.text_address.delegate = self;

    
    MPJsonManager *json_manager = [[MPJsonManager alloc] init];
    if([MPFileManager file_exist:json_manager.json_path] == YES)
    {
        self.locations = [[MPLocations alloc] initWithLocations:[json_manager deserialize]];
    }
}

-(void)viewDidAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(Get_Notification_Geocoder:)
                                                 name:@"Geocode_finished"
                                               object:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                  name:@"Geocode_finished"
                                                object:nil];
    
    if([self.locations size] > 0){
        MPJsonManager *json_manager = [[MPJsonManager alloc]init];
        [self.locations printf];
        [json_manager serialize:self.locations.locations];
    }
}

-(void)Get_Notification_Geocoder:(NSNotification*)notification{
    if([notification.name isEqual:@"Geocode_finished"]){
        if([notification.userInfo[@"success"] isEqual:@1]){
            [self.locations add_location:notification.userInfo[@"location"]];
            [MPAllert createWithText:@"Element added" withTitle:@"PlaceReminder" onViewController:self];
        }else{
            [MPAllert createWithText:@"Make sure the address or coordinate you entered are correct" withTitle:@"PlaceReminder" onViewController:self];
        }
    }
}

//Actions
- (IBAction)switch_change:(UISwitch *)sender {
    if(sender.on == YES){
        self.view_street.hidden = YES;
    }else{
        self.view_street.hidden = NO;
    }
}

- (IBAction)save_location:(UIButton *)sender {
    if([self.text_name.text isEqual:@""]){
        [MPAllert createWithText:@"It is mandatory to enter the name of the location" withTitle:@"Place Reminder" onViewController:self];
        return;
    }
    
    if([self.locations find_name:self.text_name.text] == YES){
        [MPAllert createWithText:@"Name already exist" withTitle:@"Place Reminder" onViewController:self];
        return;
    }
    
    if(self.switch_advanced.on == YES){
        if([self.text_latitude.text isEqual:@""]){
            [MPAllert createWithText:@"It is mandatory to enter the latitude of the location" withTitle:@"Place Reminder" onViewController:self];
            return;
        }
    
        if([self.text_longitude.text isEqual:@""]){
            [MPAllert createWithText:@"It is mandatory to enter the longitude of the location" withTitle:@"Place Reminder" onViewController:self];
            return;
        }
        
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        formatter.numberStyle = NSNumberFormatterDecimalStyle;
        NSNumber *latitude = [formatter numberFromString:self.text_latitude.text];
        NSNumber *longitude = [formatter numberFromString:self.text_longitude.text];
        MPLocation *location = [[MPLocation alloc] init_with_name:self.text_name.text and_description:self.text_description.text latitude:latitude longitude:longitude datetime:[NSDate date]];

        [MPGeocoder reverse_on_location:location];
    }else{
        if([self.text_address.text isEqual:@""]){
            [MPAllert createWithText:@"It is mandatory to enter the address of the location" withTitle:@"Place Reminder" onViewController:self];
            return;
        }
        
        MPLocation *location = [[MPLocation alloc] init_with_name:self.text_name.text and_description:self.text_description.text address:self.text_address.text datetime:[NSDate date]];
        
        [MPGeocoder forward_on_location:location];
    }
}

//Delegate text field
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:YES];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if([textField isEqual:self.text_address] || [textField isEqual:self.text_latitude] || [textField isEqual:self.text_longitude]){
        NSString *current_txt = textField.text;
        NSString *new_txt = [current_txt stringByReplacingCharactersInRange:range withString:string];
        self.support_label.text = new_txt;
    }
    
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if([textField isEqual:self.text_address] || [textField isEqual:self.text_latitude] || [textField isEqual:self.text_longitude]){
        self.support_label.hidden = NO;
        self.support_label.text = @"";
    }
    return YES;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if([textField isEqual:self.text_address] || [textField isEqual:self.text_latitude] || [textField isEqual:self.text_longitude]){
        self.support_label.hidden = YES;
    }
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    if([textField isEqual:self.text_address] || [textField isEqual:self.text_latitude] || [textField isEqual:self.text_longitude]){
        self.support_label.text = textField.text;
    }
    return YES;
}
@end
