//
//  MyProfile_ViewController.m
//  Tickl.Me
//
//  Created by Mountain on 2/4/13.
//  Copyright (c) 2013 HongYing. All rights reserved.
//

#import "MyProfile_ViewController.h"
#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>
#import "ViewFriendListViewController.h"
#import "DDMenuController.h"
#import "PhotoGalleryViewController.h"
@interface MyProfile_ViewController ()

@end

@implementation MyProfile_ViewController
@synthesize strNameFriend,flagMovingFromFriendsScreen;
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
    
    localCaptions = [[NSArray alloc] initWithObjects:@"Lava", @"Hawaii", @"Audi", @"Happy New Year!",@"Frosty Web",nil];
    localImages = [[NSArray alloc] initWithObjects: @"lava.jpeg", @"hawaii.jpeg", @"audi.jpg",nil];
    
    networkCaptions = [[NSArray alloc] initWithObjects:@"Happy New Year!",@"Frosty Web",nil];
     networkImages = [[NSArray alloc] initWithObjects:@"http://www.event-source.com//esimages//P_0011694_H1.JPG", @"http://www.event-source.com//esimages//P_0570769_H1.JPG",nil];


    // Do any additional setup after loading the view from its nib.
    
    if(flagMovingFromFriendsScreen)
    {
        self.title=self.strNameFriend;
        lblUserName.text=self.strNameFriend;
    }
    else
    {
    self.title=@"My Profile";
    }

    UIButton *customMenuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    customMenuBtn.frame = CGRectMake(10, 7.5, 30, 30);
    [customMenuBtn addTarget:self action:@selector(clickMenu) forControlEvents:UIControlEventTouchUpInside];
    [customMenuBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [customMenuBtn setImage:[UIImage imageNamed:@"menu.png"] forState:UIControlStateNormal];
    
    UIBarButtonItem *leftBarButton =[[UIBarButtonItem alloc] initWithCustomView:customMenuBtn];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    
    bgViewCheckins.layer.borderWidth=1.0;
    bgViewCheckins.layer.cornerRadius=5.0;
     bgViewCheckins.layer.borderColor=[UIColor lightGrayColor].CGColor;
    
   
    bgViewFriends.layer.borderWidth=1.0;
    bgViewFriends.layer.cornerRadius=5.0;
    bgViewFriends.layer.borderColor=[UIColor lightGrayColor].CGColor;
    
    bgviewPhotos.layer.borderWidth=1.0;
    bgviewPhotos.layer.cornerRadius=5.0;
    bgviewPhotos.layer.borderColor=[UIColor lightGrayColor].CGColor;
}

#pragma mark - FGalleryViewControllerDelegate Methods


- (int)numberOfPhotosForPhotoGallery:(FGalleryViewController *)gallery
{
    int num;
    if( gallery == localGallery ) {
        num = [localImages count];
    }
    else if( gallery == networkGallery ) {
        num = [networkImages count];
    }
	return num;
}


- (FGalleryPhotoSourceType)photoGallery:(FGalleryViewController *)gallery sourceTypeForPhotoAtIndex:(NSUInteger)index
{
	if( gallery == localGallery ) {
		return FGalleryPhotoSourceTypeLocal;
	}
	else return FGalleryPhotoSourceTypeNetwork;
}


- (NSString*)photoGallery:(FGalleryViewController *)gallery captionForPhotoAtIndex:(NSUInteger)index
{
    NSString *caption;
    if( gallery == localGallery ) {
        caption = [localCaptions objectAtIndex:index];
    }
    else if( gallery == networkGallery ) {
        caption = [networkCaptions objectAtIndex:index];
    }
	return caption;
}


- (NSString*)photoGallery:(FGalleryViewController*)gallery filePathForPhotoSize:(FGalleryPhotoSize)size atIndex:(NSUInteger)index {
    return [localImages objectAtIndex:index];
}

- (NSString*)photoGallery:(FGalleryViewController *)gallery urlForPhotoSize:(FGalleryPhotoSize)size atIndex:(NSUInteger)index {
    return [networkImages objectAtIndex:index];
}

- (void)handleTrashButtonTouch:(id)sender {
    // here we could remove images from our local array storage and tell the gallery to remove that image
    // ex:
    //[localGallery removeImageAtIndex:[localGallery currentIndex]];
}


- (void)handleEditCaptionButtonTouch:(id)sender {
    // here we could implement some code to change the caption for a stored image
}


-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor=[UIColor whiteColor];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   return 60;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString *cellIdentifier = @"CellIdentifier";
    UITableViewCell	*cell = [tblMyProfile dequeueReusableCellWithIdentifier:cellIdentifier];
    
    cell=nil;
    
        if(cell==nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        }
    cell.textLabel.text=@"Coldplay at The Wiltern";
    cell.textLabel.font=[UIFont boldSystemFontOfSize:14];
    cell.imageView.image=[UIImage imageNamed:@"event.png"];
    cell.detailTextLabel.text=@"i'm going";
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)clickMyFriends:(id)sender;
{
    ViewFriendListViewController *objFriendList = [[ViewFriendListViewController alloc] initWithNibName:@"ViewFriendListViewController" bundle:nil];
    [self.navigationController  pushViewController:objFriendList animated:YES];
    
}



#pragma mark -----Select  Profile Pic-------
-(IBAction)SelectProfilePic:(id)sender;
{
    UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take New Photo", @"Upload New Photo",nil];
    [action showInView:self.view];
    
}
-(IBAction)clickMyPhotos:(id)sender;
{
    
//    PhotoGalleryViewController *objMyPhotos = [[PhotoGalleryViewController alloc] init];
//    [self.navigationController pushViewController:objMyPhotos animated:YES];

   	networkGallery = [[FGalleryViewController alloc] initWithPhotoSource:self];
    [self.navigationController pushViewController:networkGallery animated:YES];
    
    
    
}
- (void)clickMenu
{
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [app showMenu];
}


#pragma UIActionsheet Delegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIImagePickerController *imgPicker = [[UIImagePickerController alloc] init];
    imgPicker.delegate = self;
    imgPicker.allowsEditing = YES;
    
    if(buttonIndex==0) // camera
    {
        if ([UIImagePickerController isSourceTypeAvailable:
             UIImagePickerControllerSourceTypeCamera])
        {
            imgPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:imgPicker animated:YES completion:nil];
        }
    }
    
    if(buttonIndex==1)  //Library
    {
        imgPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imgPicker animated:YES completion:nil];
        
    }
    
    
    
}
#pragma UIImagePickerController Deleagate

- (void)imagePickerController:(UIImagePickerController *)picker1 didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker1 dismissViewControllerAnimated:YES completion:nil];
    UIImage *img = [info objectForKey:UIImagePickerControllerEditedImage];
    [btnProfilePic setImage:[AppDelegate compressImage:img scaledToSize:CGSizeMake(btnProfilePic.frame.size.width, btnProfilePic.frame.size.height)] forState:UIControlStateNormal];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker1
{
    [picker1 dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidUnload {
    lblUserName = nil;
    [super viewDidUnload];
}
@end
