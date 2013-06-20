//
//  Filters_ViewController.m
//  Tickl.Me
//
//  Created by Mountain on 2/1/13.
//  Copyright (c) 2013 HongYing. All rights reserved.
//

#import "Filters_ViewController.h"
#import "Favorites_ViewController.h"
#import "EventCategories_ViewController.h"
#import "MapView_ViewController.h"
#import "AppDelegate.h"
#import "EventSubCategoriesViewController.h"
#import "VultureCategory.h"

@interface Filters_ViewController ()
{
    BOOL *boo;
}
@end

@implementation Filters_ViewController

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
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    [app.navi setNavigationBarHidden:NO];
//if(boo)
//{
//    NSMutableArray *arr=[[NSMutableArray alloc]initWithArray:self.navigationController.viewControllers];
//    NSLog(@"%@",arr);
//    for (int i=arr.count-1; i>=0; i--) {
//        [arr removeObjectAtIndex:i];
//    }
//    self.navigationController.viewControllers=arr;
//    [arr release];
//    NSLog(@"%@",self.navigationController.viewControllers);
//
//    boo=NO;
//}
}
- (void)viewDidLoad
{
    [super viewDidLoad];
   
    self.title=@"Filters";
    
    thumbImage = [[NSMutableArray alloc]initWithObjects:@"people-like-me.png",@"vultures.png",@"event-category.png", nil];
    
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
   
    UIButton *customMenuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    customMenuBtn.frame = CGRectMake(10, 7.5, 30, 30);
    [customMenuBtn addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
    [customMenuBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [customMenuBtn setImage:[UIImage imageNamed:@"nav_menu_icon.png"] forState:UIControlStateNormal];
 UIBarButtonItem *leftBarButton =[[UIBarButtonItem alloc] initWithCustomView:customMenuBtn];
    self.navigationItem.leftBarButtonItem = leftBarButton;

    if(app.isFirstRun)
    {
    UIBarButtonItem *rightBarButton =[[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStyleDone target:self action:@selector(clickNext:)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
     
       
        assistanceView.hidden=NO;
        btnSkip.hidden=NO;
        tableViewFilters.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-40);
    }
    else
    {
        assistanceView.hidden=YES;
        btnSkip.hidden=YES;
        tableViewFilters.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        

    }
    stringArray = [[NSArray alloc] initWithObjects:@"People Like Me",@"Vultures",@"Event Categories", nil];
}

- (void)clickNext:(id)sender
{
      Favorites_ViewController *fav = [[Favorites_ViewController alloc] init];
    [self.navigationController pushViewController:fav animated:YES];
}

- (IBAction)clickSkip:(id)sender
{
  
    MapView_ViewController *map = [[MapView_ViewController alloc] initWithNibName:@"MapView_ViewController" bundle:nil];
    [self.navigationController pushViewController:map animated:YES];
}

- (IBAction)clickOK:(id)sender
{
    self.welcomeView.hidden = YES;
}

- (void)clickBack {
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [app showMenu];
}


#pragma mark - UITableView Delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
    
//    UIImageView *imgEvent=[[UIImageView alloc]initWithFrame:CGRectMake(10, 8, 45, 45)];
//    imgEvent.image=[self displayImage:[thumbImage objectAtIndex:indexPath.row]];
//    [cell addSubview:imgEvent];
    
    cell.imageView.image = [UIImage imageNamed:[thumbImage objectAtIndex:indexPath.row]];
    
    cell.textLabel.text = [stringArray objectAtIndex:indexPath.row];
    
    return cell;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
        
        EventSubCategoriesViewController *eventSub=[[EventSubCategoriesViewController alloc]initWithNibName:@"EventSubCategoriesViewController" bundle:nil];
        eventSub.strMainCategoryName=@"People Like Me";
        [self.navigationController pushViewController:eventSub animated:YES];

    }
    else if (indexPath.row == 1){
        VultureCategory *eventSub=[[VultureCategory alloc]initWithNibName:@"VultureCategory" bundle:nil];
        [self.navigationController pushViewController:eventSub animated:YES];
  
    }
    else if (indexPath.row == 2){
        EventCategories_ViewController *event =  [[EventCategories_ViewController alloc] initWithNibName:@"EventCategories_ViewController" bundle:nil];
        [self.navigationController pushViewController:event animated:YES];
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)viewDidUnload {
    assistanceView = nil;
    btnSkip = nil;
    tableViewFilters = nil;
    [super viewDidUnload];
}
@end
