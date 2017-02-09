//
//  LefteViewController.m
//  LDrawerDemo
//
//  Created by 俊杰  廖 on 2017/2/9.
//  Copyright © 2017年 俊杰  廖. All rights reserved.
//

#import "LefteViewController.h"
#import "MainViewController.h"
#import "LDrawerViewController.h"
#import "ViewController.h"
@interface LefteViewController ()

@end

@implementation LefteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
}
- (IBAction)presentNewViewController:(UIButton *)sender {
    MainViewController *main = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"MainViewController"];
    if ([[UIApplication sharedApplication].delegate.window.rootViewController isKindOfClass:[LDrawerViewController class]]) {
        LDrawerViewController *drawer = (LDrawerViewController *)[UIApplication sharedApplication].delegate.window.rootViewController;
        [self presentViewController:main animated:YES completion:^{
            [drawer closeDrawer];
            main.indexPage.hidden = YES;
            main.back.hidden = NO;
        }];
    }else {
        ViewController *vc = (ViewController *)[UIApplication sharedApplication].delegate.window.rootViewController;
        [self presentViewController:main animated:YES completion:^{
            [vc close];
            main.indexPage.hidden = YES;
            main.back.hidden = NO;

        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
