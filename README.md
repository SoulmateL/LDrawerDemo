# LDrawerDemo
一个简单的抽屉效果，只需传入leftViewController和mainViewController且能自定义抽屉宽度
 
    @interface LDrawerViewController : UIViewController
    @property (nonatomic,strong) UIViewController *leftVC;
    @property (nonatomic,strong) UIViewController *mainVC;

    - (instancetype)initWithLefeViewController:(UIViewController *)leftViewController
                        mainViewController:(UIViewController *)mainViewController
                               drawerWidth:(CGFloat)drawerWidth;
    - (void)openDrawer;
    - (void)closeDrawer;

# 下面是侧滑代码

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



   
