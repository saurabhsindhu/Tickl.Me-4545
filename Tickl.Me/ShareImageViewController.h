//
//  ShareImageViewController.h
//  Tickl.Me
//
//  Created by Chandra Mohan on 23/04/13.
//  Copyright (c) 2013 HongYing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FacebookManager.h"
#import <MessageUI/MFMailComposeViewController.h>
@interface ShareImageViewController : UIViewController<MFMailComposeViewControllerDelegate,UIActionSheetDelegate,FacebookManagerDelegate,FBDialogDelegate>
{
    IBOutlet UIScrollView *imgScroll;
    UIButton *btnShare;
    
}
-(IBAction)myPhoto:(id)sender;
-(void)ShareOption:(id)sender;
@property(nonatomic,retain)NSString *proSelectedImage;
@end
