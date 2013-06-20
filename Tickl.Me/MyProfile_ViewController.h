//
//  MyProfile_ViewController.h
//  Tickl.Me
//
//  Created by Mountain on 2/4/13.
//  Copyright (c) 2013 HongYing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FGalleryViewController.h"

@interface MyProfile_ViewController : UIViewController <UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate,FGalleryViewControllerDelegate>
{
    
    IBOutlet UIButton *btnCheckIns;
    IBOutlet UIView *bgViewCheckins;
    IBOutlet UIView *bgViewFriends;
    IBOutlet UIView *bgviewPhotos;
    IBOutlet UIButton *btnProfilePic;
    IBOutlet UITableView *tblMyProfile;
    
    IBOutlet UILabel *lblUserName;
    
    //Gallery Items here
    
    NSArray *localCaptions;
    NSArray *localImages;
    NSArray *networkCaptions;
    NSArray *networkImages;
	FGalleryViewController *localGallery;
    FGalleryViewController *networkGallery;
    
    //moving from my friends screen
}
@property (retain, nonatomic) UIImagePickerController *imagePicker;


//moving from my friends screen
@property(nonatomic,assign) BOOL flagMovingFromFriendsScreen;
@property(nonatomic,retain) NSString *strNameFriend;
@property(nonatomic,retain) FGalleryViewController *networkGallery;

-(void)clickMenu;
-(IBAction)clickMyFriends:(id)sender;
-(IBAction)clickMyPhotos:(id)sender;
-(IBAction)SelectProfilePic:(id)sender;
@end
