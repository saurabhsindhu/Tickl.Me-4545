//
//  AppDelegate.h
//  Tickl.Me
//
//  Created by Mountain on 2/1/13.
//  Copyright (c) 2013 HongYing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewController;
@class DDMenuController;
@class MenuViewController;
@class MapView_ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    int currentMenuIndex;
    NSString *mFlashType;
    BOOL librarySelect;
    BOOL camera;
}
@property (strong, nonatomic) DDMenuController *menuController;

@property BOOL isHelp;
@property BOOL cmp;
@property int login;
@property BOOL isFirstRun;
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navi;
@property (strong, nonatomic) ViewController *viewController;
@property (nonatomic, retain) DDMenuController *vcMain;
@property (nonatomic, retain) MenuViewController *vcMenu;
@property (nonatomic, retain) MapView_ViewController *vcMap;     //vcSearch
//@property (nonatomic, retain) UINavigationController *vcMapNav; //vcSearchNav

@property (nonatomic, retain)  NSString *mFlashType;
@property (nonatomic, assign)  BOOL librarySelect;
@property (nonatomic, assign)  BOOL camera;


- (void)showMenu;
- (void)showViewAtMenuIndex:(int)index;
-(void)MyFriends;

- (void)gotoMainView;
+(UIImage*)compressImage:(UIImage*)sourceImage scaledToSize:(CGSize)newSize;

@end
