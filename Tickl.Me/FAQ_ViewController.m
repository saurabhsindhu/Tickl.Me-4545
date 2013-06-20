//
//  FAQ_ViewController.m
//  Tickl.Me
//
//  Created by Mountain on 2/22/13.
//  Copyright (c) 2013 HongYing. All rights reserved.
//

#import "FAQ_ViewController.h"
#import "AppDelegate.h"
#import "FaqDetailsViewController.h"
@interface FAQ_ViewController ()

@end

@implementation FAQ_ViewController

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
    self.title=@"FAQ";
    strArray = [[NSArray alloc] initWithObjects:@"How do I reset my password?",@"How is my data used?",@"What are Vultures?", nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = nil;// = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.text = [strArray objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FaqDetailsViewController *faqDetails=[[FaqDetailsViewController alloc]initWithNibName:@"FaqDetailsViewController" bundle:nil];
    [[self navigationController]pushViewController:faqDetails animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)clickFAQ:(id)sender {
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    app.isHelp = YES;
    [self.navigationController popViewControllerAnimated:YES];
}
@end
