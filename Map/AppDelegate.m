//
//  AppDelegate.m
//  GCD
//
//  Created by GG on 16/2/28.
//  Copyright © 2016年 GG. All rights reserved.
//

#import "AppDelegate.h"


#import "MapViewViewController.h"
#import "AnnotationViewController.h"

@interface AppDelegate ()
{
    UIViewController *VC;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    VC = [[UIViewController alloc]init];
    
    VC.view.backgroundColor = [UIColor whiteColor];
    
    VC.title = @"Map";
    
    self.window.rootViewController = [[UINavigationController alloc]initWithRootViewController:VC];
    
    UIButton *button0 = [UIButton buttonWithType:UIButtonTypeCustom];
    
    button0.frame = CGRectMake(100, 200, 0,0);
    
    [button0 setTitle:@"地图展示" forState:UIControlStateNormal];
    
    [button0 sizeToFit];
    
    [VC.view addSubview:button0];
    
    [button0 addTarget:self action:@selector(clickBtn0) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    
    button1.frame = CGRectMake(100, 300, 0,0);
    
    [button1 setTitle:@"大头针以及自定义大头针" forState:UIControlStateNormal];
    
    [button1 sizeToFit];
    
    [VC.view addSubview:button1];
    
    [button1 addTarget:self action:@selector(clickBtn1) forControlEvents:UIControlEventTouchUpInside];
    

    
    [button0 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
   
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)clickBtn0{
    
    [VC.navigationController pushViewController:[MapViewViewController new] animated:YES];
    
}

- (void)clickBtn1{
    
    [VC.navigationController pushViewController:[AnnotationViewController new] animated:YES];
}




- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
