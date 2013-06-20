
//
//  AppDelegate.m
//  Tickl.Me
//
//  Created by Mountain on 2/1/13.
//  Copyright (c) 2013 HongYing. All rights reserved.
//

#import "AppDelegate.h"
#import "MapView_ViewController.h"
#import "ViewController.h"
#import "DDMenuController.h"
#import "MenuViewController.h"
#import "FindEvents_ViewController.h"
#import "MyProfile_ViewController.h"
#import "MyEvents_ViewController.h"
#import "Filters_ViewController.h"
#import "Blog_ViewController.h"
#import "Help_ViewController.h"
#import "SettingViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "MyFriends_ViewController.h"
#import "FriendRequestAndEvetnInVitaiaionViewController.h"

@implementation AppDelegate
@synthesize menuController = _menuController;
@synthesize mFlashType,librarySelect,camera;
#pragma mark -
#pragma mark Menu Methods

- (void)showMenu
{
    [self.vcMain showLeftController:YES];
}

- (void)showViewAtMenuIndex:(int)index
{
     
    currentMenuIndex = index;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.cmp = NO;
    self.isHelp = NO;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.login = [[defaults objectForKey:@"Login"] integerValue];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    self.vcMap = [[MapView_ViewController alloc] initWithNibName:@"MapView_ViewController" bundle:nil];
    
    if (self.login == 0) {
        self.navi = [[UINavigationController alloc] initWithRootViewController:self.viewController];

        self.isFirstRun = YES;
//        self.cmp = NO;
  }
    else {
        self.isFirstRun = NO;
//        self.cmp = YES;
        self.navi = [[UINavigationController alloc] initWithRootViewController:self.vcMap] ;
    }

    //[self.navi setNavigationBarHidden:YES];
    
    self.vcMain = [[DDMenuController alloc] initWithRootViewController:self.navi];
    _menuController=self.vcMain;
    
      self.vcMenu = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
    self.vcMain.leftViewController = self.vcMenu;
    
    self.window.rootViewController = self.vcMain;
  
    [self.window makeKeyAndVisible];
    currentMenuIndex = 0;
    
    return YES;
}
#pragma Methods for compressssss the image
+(UIImage*)compressImage:(UIImage*)sourceImage scaledToSize:(CGSize)newSize
{
	// Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
	
    // Tell the old image to draw in this new context, with the desired
    // new size
    [sourceImage drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
	
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
	
    // End the context
    UIGraphicsEndImageContext();
	
    // Return the new image.
    return newImage;
	
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//- (void)gotoMainView
//{
//    self.window.rootViewController = self.vcMain;
//    CATransition *transition = [[[CATransition alloc] init] autorelease];
//    [transition setDuration:0.4];
//    [transition setType:kCATransitionFade];
//    [self.window.layer addAnimation:transition forKey:@"transition"];
//}

@end
