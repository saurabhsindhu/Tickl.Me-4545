//
//  RequsetsViewController.m
//  Tickl.Me
//
//  Created by Saurabh Sindhu on 5/24/13.
//  Copyright (c) 2013 HongYing. All rights reserved.
//

#import "RequsetsViewController.h"

@interface RequsetsViewController ()

@end

@implementation RequsetsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.title = @"Requests";
    }
    return self;
}

#pragma mark UITableView

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell =nil;// [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
  //  cell.selectionStyle = UITableViewCellSelectionStyleNone;
  //  cell.textLabel.text = [arrSubCategories objectAtIndex:indexPath.row];
    
    if (indexPath.section==0) {
        
        cell.textLabel.text = [arrayList objectAtIndex:indexPath.row];
    }
    
    if (indexPath.section==1) {
        
        cell.textLabel.text = [arrayList objectAtIndex:indexPath.row];
        
    }

    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
   
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    NSString *sectionHeader = nil;
    
    switch ( section )
    {
            
        case 0:
            
        {
               sectionHeader =[NSString stringWithFormat:@"Friends Request"] ;
                
                break;
        }
            
        case 1:
            
        {
            
            sectionHeader = [NSString stringWithFormat:@"Event Invitation"];
            
            break;
        }
            
 
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 6;

}


- (void)viewDidLoad
{
    [super viewDidLoad];
    arrayList = [[NSMutableArray alloc]init];
    arrayList2 = [[NSMutableArray alloc]init];
    
    [arrayList addObject:[NSString stringWithFormat:@"Peter"]];
    [arrayList addObject:[NSString stringWithFormat:@"John"]];
    [arrayList addObject:[NSString stringWithFormat:@"Steve"]];
    [arrayList2 addObject:[NSString stringWithFormat:@"ColdPlay by Vigil1"]];
    [arrayList2 addObject:[NSString stringWithFormat:@"ColdPlay by Vigil2"]];
    [arrayList2 addObject:[NSString stringWithFormat:@"ColdPlay by Vigil3"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
