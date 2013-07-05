//
//  Help_ViewController.m
//  Tickl.Me
//
//  Created by Mountain on 2/8/13.
//  Copyright (c) 2013 HongYing. All rights reserved.
//

#import "Help_ViewController.h"
#import "AppDelegate.h"
#import "FAQ_ViewController.h"
#import "MapView_ViewController.h"

@interface Help_ViewController ()

@end

@implementation Help_ViewController

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
    [super viewDidLoad];
    
    self.title=@"Help";
    
    UIButton *customMenuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    customMenuBtn.frame = CGRectMake(10, 7.5, 30, 30);
    [customMenuBtn addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
    [customMenuBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [customMenuBtn setImage:[UIImage imageNamed:@"menu.png"] forState:UIControlStateNormal];
    
    UIBarButtonItem *leftBarButton =[[UIBarButtonItem alloc] initWithCustomView:customMenuBtn];
    self.navigationItem.leftBarButtonItem = leftBarButton;

    questions = [[NSArray alloc] initWithObjects:@"Send Feedback",@"View FAQ", nil];
    abouttheapp = [[NSArray alloc] initWithObjects:@"Terms of Service",@"Privacy Policy", @"Credits & Acknowledgements", nil];
}

//- (void)viewWillAppear:(BOOL)animated
//{
//
//    MapView_ViewController *map = [[MapView_ViewController alloc] init];
//    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    if (app.isHelp) {
//        app.navi = [[UINavigationController alloc] initWithRootViewController:app.vcMap] ;
////        app.window.rootViewController = app.navi;
//        [app.navi setNavigationBarHidden:YES];
//        app.vcMain = [[DDMenuController alloc] initWithRootViewController:app.navi];
//        app.vcMain.leftViewController = app.vcMenu;
//    }
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)clickBack {
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [app showMenu];
}

#pragma mark - Table view delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    }
    else if (section == 1) {
        return 3;
    }

    return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"Questions & Feedback";
    }
    else if (section == 1) {
        return @"About The App";
    }
    return @"";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = nil;// = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
        if (indexPath.section == 0) {
            cell.textLabel.text = [questions objectAtIndex:indexPath.row];
            if (indexPath.row == 1) {
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
        }
        else if (indexPath.section == 1) {
            cell.textLabel.text = [abouttheapp objectAtIndex:indexPath.row];
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {               //Send Feedback
            
        }
        else {                                  //View FAQ
            FAQ_ViewController *fav = [[FAQ_ViewController alloc] initWithNibName:@"FAQ_ViewController" bundle:nil];
            [self.navigationController pushViewController:fav animated:YES];

        }
    }
    else {
        if (indexPath.row == 0) {               //Terms of Service
            
        }
        else if (indexPath.row == 1) {          //Privacy Policy
    
        }
        else {                                  //Credits & Acknowledgements
            
        }
    }
}

@end
