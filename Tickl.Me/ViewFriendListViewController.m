//
//  ViewFriendListViewController.m
//  Tickl.Me
//
//  Created by Prakash Joshi on 4/18/13.
//  Copyright (c) 2013 HongYing. All rights reserved.
//

#import "ViewFriendListViewController.h"
#import "AppDelegate.h"
#import "AddFriendViewController.h"
@interface ViewFriendListViewController ()

@end

@implementation ViewFriendListViewController

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

    self.title=@"My Friends";
    
    UIBarButtonItem *rightBarButton =[[UIBarButtonItem alloc] initWithTitle:@"Add Friends" style:UIBarButtonItemStyleDone target:self action:@selector(AddFriends:)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
     arrFriendList=[[NSMutableArray alloc]init];
    [arrFriendList addObject:@"Joshua Mauldin"];
    [arrFriendList addObject:@"Peter Imbres"];
    [arrFriendList addObject:@"Virgil Pana"];
    [arrFriendList addObject:@"Jon Cater"];
    [arrFriendList addObject:@"Smith"];
    //[tblMyFriends setEditing:YES animated:YES];
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor=[UIColor whiteColor];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrFriendList.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString *cellIdentifier = @"CellIdentifier";
    UITableViewCell	*cell = [tblMyFriends dequeueReusableCellWithIdentifier:cellIdentifier];
    
    cell=nil;
    
    if(cell==nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    

    cell.textLabel.text=[arrFriendList objectAtIndex:indexPath.row];
    cell.textLabel.font=[UIFont boldSystemFontOfSize:14];
    UIImage *img=[UIImage imageNamed:@"imgFriend.jpg"];
    cell.imageView.image=img;
   
   
    return cell;
}
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"Delete";
}
-(UITableViewCellEditingStyle)tableView:(UITableView*)tableView editingStyleForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return UITableViewCellEditingStyleDelete;
}
- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (void)tableView:(UITableView*)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (void)tableView:(UITableView*)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath   //this is called when we press delete button in table
{
    if(editingStyle==UITableViewCellEditingStyleDelete)
    {
        NSLog(@"------->%i",indexPath.row);
        [arrFriendList removeObjectAtIndex:indexPath.row];
        [tblMyFriends reloadData];
 
    }
}
-(IBAction)MyProfile:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)AddFriends:(id)sender
{
    AddFriendViewController *objAddFriend = [[AddFriendViewController alloc] initWithNibName:@"AddFriendViewController" bundle:nil];
    [self.navigationController pushViewController:objAddFriend animated:YES];
 
}

@end
