//
//  MyFriends_ViewController.m
//  Tickl.Me
//
//  Created by Mountain on 2/4/13.
//  Copyright (c) 2013 HongYing. All rights reserved.
//

#import "MyFriends_ViewController.h"
#import "AddFriendViewController.h"
#import "MyProfile_ViewController.h"
@interface MyFriends_ViewController ()

@end

@implementation MyFriends_ViewController

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
    
    self.title=@"My Friends";
    
    UIBarButtonItem *rightBarButton =[[UIBarButtonItem alloc] initWithTitle:@"Add Friends" style:UIBarButtonItemStyleDone target:self action:@selector(clickAddFriends:)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    UIButton *customMenuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    customMenuBtn.frame = CGRectMake(10, 7.5, 30, 30);
    [customMenuBtn addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
    [customMenuBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [customMenuBtn setImage:[UIImage imageNamed:@"nav_menu_icon.png"] forState:UIControlStateNormal];
    
    UIBarButtonItem *leftBarButton =[[UIBarButtonItem alloc] initWithCustomView:customMenuBtn];
    self.navigationItem.leftBarButtonItem = leftBarButton;

    arrFriendList=[[NSMutableArray alloc]init];
    [arrFriendList addObject:@"Joshua Mauldin"];
    [arrFriendList addObject:@"Peter Imbres"];
    [arrFriendList addObject:@"Virgil Pana"];
    [arrFriendList addObject:@"Jon Cater"];
    [arrFriendList addObject:@"Smith"];
    
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
    UITableViewCell	*cell = [tblAddFriend dequeueReusableCellWithIdentifier:cellIdentifier];
    
    cell=nil;
    
    if(cell==nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        
        UIImageView *imgFriend=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 40, 40)];
        imgFriend.image=[UIImage imageNamed:@"imgFriend.jpg"];
        [cell addSubview:imgFriend];
        
        UILabel *lblFriendName=[[UILabel alloc]initWithFrame:CGRectMake(70, 10, 200, 30)];
        lblFriendName.backgroundColor=[UIColor clearColor];
        lblFriendName.text=[NSString stringWithFormat:@"%@",[arrFriendList objectAtIndex:indexPath.row]];
        lblFriendName.font=[UIFont boldSystemFontOfSize:15];
        [cell addSubview:lblFriendName];
        
        UIButton *btnAddFriend=[UIButton buttonWithType:UIButtonTypeCustom];
        btnAddFriend.frame=CGRectMake(270, 5, 25, 25);
        [btnAddFriend setImage:[UIImage imageNamed:@"imgAddFriend.png"] forState:UIControlStateNormal];
       // [cell addSubview:btnAddFriend];
        
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyProfile_ViewController *myProfileObj=[[MyProfile_ViewController alloc]initWithNibName:@"MyProfile_ViewController" bundle:nil];
    myProfileObj.strNameFriend=[arrFriendList objectAtIndex:indexPath.row];
    myProfileObj.flagMovingFromFriendsScreen=YES;
    [self.navigationController pushViewController:myProfileObj animated:YES];
}

- (void)clickAddFriends:(id)sender {
       AddFriendViewController *addFrndVC=[[AddFriendViewController alloc]initWithNibName:@"AddFriendViewController" bundle:nil];
    [self.navigationController pushViewController:addFrndVC animated:YES];
}

- (void)clickBack {
        AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [app showMenu];
}
@end
