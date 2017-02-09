//
//  ViewController.m
//  Drawer
//
//  Created by 俊杰  廖 on 2017/2/9.
//  Copyright © 2017年 俊杰  廖. All rights reserved.
//

#import "LDrawerViewController.h"
#define kMainViewOriginX 0
#define kAnimateDuration 0.3
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
@interface LDrawerViewController ()
@end

@implementation LDrawerViewController {
    CGFloat _drawerWidth;
}

/**
 抽屉移动像素
 */
int transX = 0;

- (instancetype)initWithLefeViewController:(UIViewController *)leftViewController
                        mainViewController:(UIViewController *)mainViewController
                               drawerWidth:(CGFloat)drawerWidth {
    self = [super init];
    if (self) {
        if (_drawerWidth > kScreenWidth) {
            _drawerWidth = 200;
        }else {
            _drawerWidth = drawerWidth;
        }
        [self addChildViewController:leftViewController];
        [self addChildViewController:mainViewController];
        _leftVC = leftViewController;
        _mainVC = mainViewController;
    }
    return self;
}

- (void)loadView {
    [super loadView];
    [self.view addSubview:_leftVC.view];
    [self.view addSubview:_mainVC.view];
    _leftVC.view.frame = CGRectMake(kMainViewOriginX, 0, _drawerWidth, kScreenHeight);
    _mainVC.view.frame = self.view.bounds;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //侧滑手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAcion:)];
    [self.view addGestureRecognizer:pan];
    
    
}

- (void)panAcion:(UIPanGestureRecognizer *)pan {
    if (self.mainVC.view.frame.origin.x == _drawerWidth) {
        CGPoint point = [pan locationInView:self.view];
        if (CGRectContainsPoint(CGRectMake(0, 0, _drawerWidth, kScreenHeight), point)) {
            return;
        }
    }
    if (![pan.view isEqual:self.view]) {
        return;
    }
    if (pan.state == UIGestureRecognizerStateBegan || pan.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [pan translationInView:self.view];
        if (translation.x<0) {//左滑
            if (self.mainVC.view.frame.origin.x>=0) {
                transX += translation.x;
                if (transX<0) {
                    transX = kMainViewOriginX;
                }
                [self updateContrantsWithTransX:transX animation:YES];
            }
        }else {
            transX += translation.x;
            if (transX > _drawerWidth) {
                transX = _drawerWidth;
            }
            [self updateContrantsWithTransX:transX animation:YES];
        
        }
        // 重置滑动距离
        [pan setTranslation:CGPointZero inView:self.view];
    }
    if (pan.state == UIGestureRecognizerStateEnded) {
        if (transX <= _drawerWidth/2) {
            transX = kMainViewOriginX;
            [self updateContrantsWithTransX:transX animation:YES];
        }else {
            transX = _drawerWidth;
            [self updateContrantsWithTransX:transX animation:YES];
        }
    }
}


/**
 打开抽屉
 */
- (void)openDrawer {
    [self updateContrantsWithTransX:_drawerWidth animation:YES];
}


/**
 关闭抽屉
 */
- (void)closeDrawer {
    [self updateContrantsWithTransX:kMainViewOriginX animation:YES];

}

//侧滑
- (void)updateContrantsWithTransX:(CGFloat)tx animation:(BOOL)animation {
    transX = tx;
    if (animation) {
        //视图的动画效果
        [UIView animateWithDuration:kAnimateDuration animations:^{
            self.mainVC.view.frame = CGRectMake(transX, 0, kScreenWidth-transX, kScreenHeight);
            CGFloat scale = 1.0f * transX/_drawerWidth;
            self.leftVC.view.transform = CGAffineTransformMakeScale(scale, scale);
            
        } completion:^(BOOL finished) {
            if (finished) {
                if (transX == _drawerWidth) {
                    [self addCover];
                }else {
                    UIButton *btn = [self.mainVC.view viewWithTag:101];
                    [btn removeFromSuperview];
                    btn = nil;
                }
            }
        }];
    }else {
        //当animation = NO ;去除动画即可
        self.mainVC.view.frame = CGRectMake(transX, 0, kScreenWidth-transX, kScreenHeight);
        CGFloat scale = 1.0f * transX/_drawerWidth;
        self.leftVC.view.transform = CGAffineTransformMakeScale(scale, scale);
    }
}

//添加遮罩
- (void)addCover {
    if ([self.mainVC.view viewWithTag:101]) {
        return;
    }
    //这里写的是Button 也可以写其他的控件
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.tag = 101;
    [self.mainVC.view addSubview:button];
    [button setFrame:self.mainVC.view.bounds];
    [button addTarget:self action:@selector(backBtnTouch:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)backBtnTouch:(UIButton *)sender {
    if (self.mainVC.view.frame.origin.x >= _drawerWidth) {
        [self updateContrantsWithTransX:kMainViewOriginX animation:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
