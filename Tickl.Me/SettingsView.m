//
//  SettingsView.m
//  Foursquare2-iOS
//
//  Created by Saurabh Sindhu on 5/29/13.
//
//

#import "SettingsView.h"
#import "Foursquare2.h"

@interface SettingsView ()

@end

@implementation SettingsView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    self.title = @"Settings";
    [super viewDidLoad];
    [self prepareViewForUser];
    
}


-(void)prepareViewForUser{
    [Foursquare2  getDetailForUser:@"self"
                          callback:^(BOOL success, id result){
                              if (success) {
                                  self.name.text =
                                  [NSString stringWithFormat:@"%@ %@",
                                   [result valueForKeyPath:@"response.user.firstName"],
                                   [result valueForKeyPath:@"response.user.lastName"]];
                              }
                          }];
}
- (IBAction)logout:(id)sender {
    [Foursquare2 removeAccessToken];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
