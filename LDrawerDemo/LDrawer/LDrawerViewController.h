//
//  LDrawerViewController.h
//  Drawer
//
//  Created by 俊杰  廖 on 2017/2/9.
//  Copyright © 2017年 俊杰  廖. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LDrawerViewController : UIViewController

/**
 左控制器
 */
@property (nonatomic,strong) UIViewController *leftVC;

/**
 右控制器
 */
@property (nonatomic,strong) UIViewController *mainVC;

/**
 构造方法

 @param leftViewController 左控制器
 @param mainViewController 右控制器
 @param drawerWidth 抽屉的宽度 默认宽度为200 最小宽度为0即无抽屉效果 最大宽度不超过屏幕宽度
 */
- (instancetype)initWithLefeViewController:(UIViewController *)leftViewController
                        mainViewController:(UIViewController *)mainViewController
                               drawerWidth:(CGFloat)drawerWidth;


/**
 打开抽屉
 */
- (void)openDrawer;


/**
 关闭抽屉
 */
- (void)closeDrawer;
@end

