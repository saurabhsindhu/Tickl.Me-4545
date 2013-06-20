//
//  PhotoGalleryViewController.m
//  Tickl.Me
//
//  Created by Prakash Joshi on 4/18/13.
//  Copyright (c) 2013 HongYing. All rights reserved.
//

#import "PhotoGalleryViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "ShareImageViewController.h"
@interface PhotoGalleryViewController ()

@end

@implementation PhotoGalleryViewController

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
    self.title=@"My Photos";
    
     arrAllPhoto=[[NSMutableArray alloc]init];
    for(int i=0;i<20;i++)
    {
        [arrAllPhoto addObject:@"rsz_162097.png"];
    }
    int x = 6;
    int y = 0;
    for(UIView *subview in [scrollMyPhoto subviews]) {
        [subview removeFromSuperview];
    }
    int h=100;
    for (int i = 0;i<arrAllPhoto.count; i++)
    {
        if(x>260)
        {
            y=y+95;
            h=h+95;
            x=6;
        }
        UIView *bgview=[[UIView alloc]initWithFrame:CGRectMake(x,y+5,95,90)];
        bgview.backgroundColor=[UIColor whiteColor];
        bgview.layer.cornerRadius=3.0;
        bgview.layer.borderWidth=1.0;
        bgview.layer.borderColor=[UIColor lightGrayColor].CGColor;
        [scrollMyPhoto addSubview:bgview];
        
        
        UIButton *btnMyPhoto=[UIButton buttonWithType:UIButtonTypeCustom];
        btnMyPhoto.backgroundColor=[UIColor clearColor];
        [btnMyPhoto setImage:[UIImage imageNamed:[arrAllPhoto objectAtIndex:i]] forState:UIControlStateNormal];
        btnMyPhoto.tag=i;
        [btnMyPhoto addTarget:self action:@selector(selectPhoto:) forControlEvents:UIControlEventTouchUpInside];
        btnMyPhoto.frame=CGRectMake(5,2,86,86);
        [bgview addSubview:btnMyPhoto];
        
        x= x+105;

        scrollMyPhoto.contentSize = CGSizeMake(310, h);
        
    }
}
#pragma mark---------SelectImage----------

-(void)selectPhoto:(id)sender
{
    UIButton *selectImg=(UIButton*)sender;
    ShareImageViewController *objShareImage=[[ShareImageViewController alloc]init];
    NSLog(@"%@",[arrAllPhoto objectAtIndex:selectImg.tag]);
    objShareImage.proSelectedImage=[arrAllPhoto objectAtIndex:selectImg.tag];
    [self.navigationController pushViewController:objShareImage animated:YES];
    
    
    
}
-(void)MyPhoto:(id)sender;
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
