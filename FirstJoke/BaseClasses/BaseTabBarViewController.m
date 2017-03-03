//
//  BaseTabBarViewController.m
//  LOLKit
//
//  Created by 刘伟强 on 16/8/18.
//  Copyright © 2016年 刘伟强. All rights reserved.
//

#import "BaseTabBarViewController.h"
#import "BaseNavigationViewController.h"
#import "LQMacro.h"

#import "FJFreeJokeViewController.h"
#import "FJAboutViewController.h"
@interface BaseTabBarViewController ()
@property(nonatomic,strong)NSMutableArray * btnArr;
@property(nonatomic,strong)UIImageView * bearbarImageView;
@end

@implementation BaseTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.btnArr = [[NSMutableArray alloc]init];
    [self addViewController];
    [self systemTabbar];
//    [self customTab1];
    
   
    // Do any additional setup after loading the view.
}

//装载视图 -
- (void)addViewController
{
    
    FJFreeJokeViewController * vc1 = [[FJFreeJokeViewController alloc]init];
    vc1.title = @"精选";
    vc1.type = @"精选";
    BaseNavigationViewController * nvc1 = [[BaseNavigationViewController alloc]initWithRootViewController:vc1];
    
//    FJChargeJokeViewController * vc2 = [[FJChargeJokeViewController alloc]init];
//    vc2.title = @"精选";
//    BaseNavigationViewController * nvc2 = [[BaseNavigationViewController alloc]initWithRootViewController:vc2];
    
    FJFreeJokeViewController * vc3 = [[FJFreeJokeViewController alloc]init];
    vc3.title = @"随便看看";
    vc3.type = @"随便看看";
    BaseNavigationViewController * nvc3 = [[BaseNavigationViewController alloc]initWithRootViewController:vc3];
    
    FJAboutViewController * vc4 = [[FJAboutViewController alloc]init];
    vc4.title = @"关于我们";
    BaseNavigationViewController * nvc4 = [[BaseNavigationViewController alloc]initWithRootViewController:vc4];
    
//    self.viewControllers = @[nvc1,nvc2,nvc3,nvc4];
    self.viewControllers = @[nvc1,nvc3,nvc4];
    
}

- (void)systemTabbar{
    
    self.tabBar.tintColor = AppColor;
    
//    NSArray * itemImageArr = @[@"Free",@"精选",@"suibian",@"AboutUS"];
    NSArray * itemImageArr = @[@"精选",@"suibian",@"AboutUS"];
    for (int i = 0; i < itemImageArr.count; i++) {
        UITabBarItem * item = self.tabBar.items[i];
        item.image = [UIImage imageNamed:itemImageArr[i]];
    }
    self.selectedIndex = 1;
}

#pragma mark 转屏方法重写

- (BOOL)shouldAutorotate{
    return self.selectedViewController.shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return [self.selectedViewController supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return [self.selectedViewController preferredInterfaceOrientationForPresentation];
}



@end
