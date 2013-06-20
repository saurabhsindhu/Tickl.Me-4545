//
//  Notification_ViewController.m
//  Tickl.Me
//
//  Created by Mountain on 2/1/13.
//  Copyright (c) 2013 HongYing. All rights reserved.
//

#import "Notification_ViewController.h"
#import "MapView_ViewController.h"
#import "AppDelegate.h"
#import "DDMenuController.h"

@interface Notification_ViewController ()

@end

@implementation Notification_ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    NSLog(@"====>>> %@",self.navigationController.viewControllers);
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title=@"Favorites";
    
    UIBarButtonItem *rightBarButton =[[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStyleDone target:self action:@selector(clickNext:)];
    self.navigationItem.rightBarButtonItem = rightBarButton;

    pushStrs = [[NSArray alloc] initWithObjects:@"Push Notifications",@"Within", nil];
    emailStrs = [[NSArray alloc] initWithObjects:@"New Events",@"Favorite Artists Nearby",@"Friend Requests", nil];
    socialStrs = [[NSArray alloc] initWithObjects:@"Facebook",@"Twitter",@"Foursquare", nil];
}

#pragma mark - Table view delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    }
    else if (section == 1) {
        return 3;
    }
//    else if (section == 2) {
//        return 3;
//    }
//    else
//        return 1;
    return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"Push Notifications";
    }
    else if (section == 1) {
        return @"Email Notifications";
    }
    
    return nil;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = nil;// = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    
    
    
    if (indexPath.section == 0) {
        cell.textLabel.text = [pushStrs objectAtIndex:indexPath.row];
        if (indexPath.row == 0) {
            UISwitch *pushSwitch = [[UISwitch alloc] init];
            [pushSwitch addTarget:self action:@selector(clickPushNotifications) forControlEvents:UIControlEventTouchUpInside];
            [pushSwitch setFrame:CGRectMake(215, 8, 79, 27)];
            [cell.contentView addSubview:pushSwitch];
        }
    }
    else if (indexPath.section == 1) {
        cell.textLabel.text = [emailStrs objectAtIndex:indexPath.row];
        UISwitch *options = [[UISwitch alloc] init];
        if (indexPath.row == 0) {
            [options addTarget:self action:@selector(clickNewEvents) forControlEvents:UIControlEventTouchUpInside];
        }
        else if (indexPath.row == 1) {
            [options addTarget:self action:@selector(clickFavoriteArtistsNearby) forControlEvents:UIControlEventTouchUpInside];
        }
        else {
            [options addTarget:self action:@selector(clickFriendRequests) forControlEvents:UIControlEventTouchUpInside];
        }
        [options setFrame:CGRectMake(215, 8, 79, 27)];
        [cell.contentView addSubview:options];
    }
    else if (indexPath.section == 2) {
        cell.textLabel.text = [socialStrs objectAtIndex:indexPath.row];
    }
    else {
        cell.textLabel.text = @"Copy Link to Calendar";
        [cell setBackgroundColor:[UIColor clearColor]];
    }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Button Events

- (void)clickBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)clickSkip:(id)sender
{
    MapView_ViewController *map = [[MapView_ViewController alloc] init];
    [self.navigationController pushViewController:map animated:YES];
}

- (void)clickNext:(id)sender
{
//    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    app.cmp = YES;
//    
//    app.vcMain = [[DDMenuController alloc] initWithRootViewController:app.navi];
//    //app.vcMain.leftViewController = app.vcMenu;
//    app.window.rootViewController = app.navi;
    
    MapView_ViewController *map = [[MapView_ViewController alloc] init];
    [self.navigationController pushViewController:map animated:YES];

//    [appDelegate gotoMainView];
}

#pragma mark - Switch Buttons

- (void)clickPushNotifications
{
    
}

- (void)clickNewEvents
{
    
}

- (void)clickFavoriteArtistsNearby
{
    
}

- (void)clickFriendRequests
{
    
}


@end
