//
//  ViewController.m
//  LDrawerDemo
//
//  Created by 俊杰  廖 on 2017/2/9.
//  Copyright © 2017年 俊杰  廖. All rights reserved.
//

#import "ViewController.h"
#import "LDrawerViewController.h"
#import "LefteViewController.h"
#import "MainViewController.h"
#import "AppDelegate.h"
@interface ViewController ()
@property (nonatomic,strong) LDrawerViewController *drawer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
    
//    [self setRootViewController];
    [self addToViewController];
}

- (void)getDrawerViewController {
    LefteViewController *leftVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"LefteViewController"];
    MainViewController *mainVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"MainViewController"];
    _drawer = [[LDrawerViewController alloc] initWithLefeViewController:leftVC mainViewController:mainVC drawerWidth:200];
}
/**
 作为根视图
 */
- (void)setRootViewController {
    [self getDrawerViewController];
    [UIApplication sharedApplication].delegate.window.rootViewController = _drawer;
}

/**
 添加到视图控制器
 */
- (void)addToViewController {
    [self getDrawerViewController];
    [self addChildViewController:_drawer];
    [self.view addSubview:_drawer.view];
    _drawer.view.frame = self.view.bounds;
}

- (void)close {
    [_drawer closeDrawer];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
