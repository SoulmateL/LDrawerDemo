# LDrawerDemo
一个简单的抽屉效果，只需传入leftViewController和mainViewController且能自定义抽屉宽度

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

下面是侧滑代码

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
