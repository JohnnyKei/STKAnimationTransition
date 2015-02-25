//
//  STKAnimtor.m
//  STKAnimationTransition
//
//  Created by kei on 2015/02/08.
//  Copyright (c) 2015年 kei. All rights reserved.
//

#import "STKAnimtor.h"
#import "ModalViewController.h"
#import "ViewController.h"

@interface STKAnimtor ()

@property (nonatomic)CGPoint fromPoint;
@property (nonatomic)CGPoint toPoint;
@property (nonatomic, strong) UIButton *originButton;

@end


@implementation STKAnimtor

- (instancetype)init{
    self = [super init];
    if (self) {
        self.animateDuration = 1.0;
        
        
    }
    return self;
}


- (instancetype)initWithAnimateDuration:(CGFloat)duration{
    self = [super init];
    if (self) {
        self.animateDuration = duration;
    }
    return self;
}

- (instancetype)initWithOriginButton:(UIButton *)button fromPoint:(CGPoint)from toPoint:(CGPoint)to{
    self = [self init];
    if (self) {
        _originButton = button;
        _fromPoint = from;
        _toPoint = to;
    }
    return self;
}


- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return self.animateDuration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    if (self.isPresenting) {
        [self excutePresentAnimation:transitionContext];
    }else{
        [self excuteDuismissAnimation:transitionContext];
    }
    
}


- (void)excutePresentAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIView* containerView = [transitionContext containerView];
    
    ModalViewController* toVC= (ModalViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    
    
    UIViewController* fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    
    
    [containerView insertSubview:toVC.view belowSubview:fromVC.view];
    
    fromVC.view.alpha =0;
    
    [CATransaction begin];
    [CATransaction setCompletionBlock:^{
        [transitionContext completeTransition:YES];
    }];
    
    [toVC.shape removeAnimationForKey:@"scaleDown"];

    
    CABasicAnimation *scaleAnimation = [self animateWithKeyPath:@"transform.scale" fromVale:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.0001, 0.0001, 0.0001)] toValue:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)] duration:0.3];
    
    
    
    [toVC.shape addAnimation:scaleAnimation forKey:@"scaleUp"];
    
  
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.originButton.layer.backgroundColor = [UIColor redColor].CGColor;
        self.originButton.center = self.toPoint;

    } completion:^(BOOL finished) {
        
    }];

    
    [CATransaction commit];
    
    
    
}


- (void)excuteDuismissAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{

    UIView* containerView = [transitionContext containerView];
    
    UIViewController* toVC= [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    ModalViewController * fromVC = (ModalViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    [containerView insertSubview:toVC.view belowSubview:fromVC.view];
 
    
    
    [CATransaction begin];
    [CATransaction setCompletionBlock:^{
        [transitionContext completeTransition:YES];
    }];
    
    [fromVC.shape removeAnimationForKey:@"scaleUp"];
    
    CABasicAnimation *scaleAnimation = [self animateWithKeyPath:@"transform.scale" fromVale:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)] toValue:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.0001, 0.0001, 0.0001)] duration:0.5];
    [fromVC.shape addAnimation:scaleAnimation forKey:@"scaleDown"];
    

    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.originButton.layer.backgroundColor = [UIColor whiteColor].CGColor;
        self.originButton.center = self.toPoint;
    } completion:^(BOOL finished) {
        
    }];
    
    [CATransaction commit];
    
    toVC.view.alpha  =1.0;
    
}


- (CABasicAnimation *)animateWithKeyPath:(NSString *)keyPath fromVale:(id)from toValue:(id)to duration:(NSTimeInterval)duration{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:keyPath];
    animation.fromValue = from;
    animation.toValue = to;
    animation.repeatCount = 1;
    animation.duration = duration;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    
    return animation;
}



@end
