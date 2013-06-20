//
//  ShareImageViewController.m
//  Tickl.Me
//
//  Created by Chandra Mohan on 23/04/13.
//  Copyright (c) 2013 HongYing. All rights reserved.
//

#import "ShareImageViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "FBDialog.h"
#import "FacebookManager.h"
#import <MessageUI/MFMailComposeViewController.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <social/Social.h>
@interface ShareImageViewController ()

@end

@implementation ShareImageViewController
@synthesize proSelectedImage;
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
    
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title=@"Photos";
    
    UIBarButtonItem *rightBarButton =[[UIBarButtonItem alloc] initWithTitle:@"Share" style:UIBarButtonItemStyleDone target:self action:@selector(ShareOption:)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    self.view.backgroundColor=[UIColor blackColor];
    UIImage *img=[UIImage imageNamed:self.proSelectedImage];
    UIImageView *shareImg=[[UIImageView alloc]init];
    
     shareImg.frame=CGRectMake(0, 10,img.size.width, img.size.height);
     shareImg.center = imgScroll.center;
     shareImg.clipsToBounds=YES;
    shareImg.contentMode = UIViewContentModeScaleAspectFit;
    [shareImg setImage:img];
    [imgScroll addSubview:shareImg];
    
    [imgScroll setContentSize:CGSizeMake(img.size.width+100, img.size.height+100)];
    imgScroll.layer.borderWidth=1.0;
    imgScroll.layer.borderColor=[UIColor whiteColor].CGColor;
    
    

}
-(void)ShareOption:(id)sender;
{
    UIActionSheet *action=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Share on Facebook",@"Share on Twitter",nil];
    action.actionSheetStyle=UIActionSheetStyleBlackTranslucent;
    [action showInView:self.view];
  }
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    
//    if (buttonIndex==0)
//    {
//        if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
//        {
//            
//            SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
//            
//            SLComposeViewControllerCompletionHandler myBlock = ^(SLComposeViewControllerResult result)
//            {
//                
//                NSString *output;
//                switch (result)
//                {
//                    case SLComposeViewControllerResultCancelled:
//                        output = @"Action Cancelled";
//                        
//                        //dismissViewControllerAnimated:YES completion:nil];
//                        break;
//                        
//                    case SLComposeViewControllerResultDone:
//                        output = @"Post Successfull";
//                        break;
//                    default:
//                        break;
//                }
//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Facebook Message" message:output delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//                [alert show];
//                
//                [controller dismissViewControllerAnimated:YES completion:Nil];
//            };
//            
//            controller.completionHandler =myBlock;
//            UIImage *imge=[UIImage imageNamed:self.proSelectedImage];
//            NSData *pngData = UIImagePNGRepresentation(imge);
//            UIImage *image=[UIImage imageWithData:pngData];
//          //  [controller setInitialText:textStory.text];
//            [controller addImage:image];
//            [controller setEditing:NO];
//            [self presentViewController:controller animated:YES completion:Nil];
//        }
//        else
//        {
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Status:" message:@"Your phone is not currently configured to Facebook! Please update iOS version." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//            
//            [alert show];
//        }
//    }
//  
//    else if(buttonIndex == 1)
//    {
//        NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
//        if([currSysVer isEqualToString:@"6.0"])
//        {
//        if([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
//            
//            SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
//            
//            SLComposeViewControllerCompletionHandler myBlock = ^(SLComposeViewControllerResult result)
//            {
//                NSLog(@"dfsdf");
//                NSString *output;
//                switch (result) {
//                    case SLComposeViewControllerResultCancelled:
//                        output = @"Action Cancelled";
//                        break;
//                        
//                    case SLComposeViewControllerResultDone:
//                        output = @"Post Successfull";
//                        break;
//                    default:
//                        break;
//                }
//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Twitter Message" message:output delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
//                [alert show];
//                
//                [controller dismissViewControllerAnimated:YES completion:Nil];
//            };
//            controller.completionHandler =myBlock;
//           
//            
//            UIImage *imge=[UIImage imageNamed:self.proSelectedImage];
//            NSData *pngData = UIImagePNGRepresentation(imge);
//            UIImage *image=[UIImage imageWithData:pngData];
//
//        //    [controller setInitialText:textStory.text];
//            [controller addImage:image];
//            [self presentViewController:controller animated:YES completion:Nil];
//        }
//        }
//        else
//        {
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Status:" message:@"Your phone is not currently configured to Twitter! Please update iOS version" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
//            
//            [alert show];
//            
//        }
//    
//
//    }
    if(buttonIndex==0)
	{
        //share with faceboook
      
//        NSArray *sysPaths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES );
//        NSString *docDirectory = [sysPaths objectAtIndex:0];
//        NSString *filePath = [NSString stringWithFormat:@"%@/%@.jpg", docDirectory,self.proSelectedImage];
//        
        
        UIImage *imge=[UIImage imageNamed:self.proSelectedImage];
        NSData *pngData = UIImagePNGRepresentation(imge);
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsPath = [paths objectAtIndex:0]; //Get the docs directory
        NSString *filePath = [documentsPath stringByAppendingPathComponent:@"UploadedImage.jpg"]; //Add the file name
       // [pngData writeToFile:filePath atomically:YES]; //Write the file
        
     
        
         NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager createFileAtPath:filePath contents:pngData attributes:nil];

        
        NSURL *url = [[NSURL alloc] initFileURLWithPath:filePath];
        NSString *filePath1 = [url path];
            filePath = [[NSBundle mainBundle] pathForResource:@"wildFlower" ofType:@"jpg"];
       NSLog(@"%@",filePath);
//        
        NSString *file= [url absoluteString];
        
        // The output string will have the file path only
        
        
        UIImage *image=[UIImage imageWithData:pngData];
        
        FacebookManager *myFacebook = [FacebookManager sharedInstance];
        [myFacebook setDelegate:self];
        NSString *kAppId=[FacebookManager sharedInstance].appID;
        NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       kAppId, @"app_id",
                                       file ,@"picture",
                                       nil];
     // [[[FacebookManager sharedInstance] facebook] dialog:@"feed" andParams:params andDelegate:self];
        
        [[FacebookManager sharedInstance] postMessage:@"From Mobile Event app" andCaption:@"" andImage:image];
    }
    if(buttonIndex==1)
	{
        //share with Twiter
    }

}

-(IBAction)myPhoto:(id)sender;
{
    [self.navigationController popViewControllerAnimated:YES];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
