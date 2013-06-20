//
//  PhotoGalleryViewController.h
//  Tickl.Me
//
//  Created by Prakash Joshi on 4/18/13.
//  Copyright (c) 2013 HongYing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoGalleryViewController : UIViewController
{
    IBOutlet UIScrollView *scrollMyPhoto;
    NSMutableArray *arrAllPhoto;
}
-(void)MyPhoto:(id)sender;
@end
