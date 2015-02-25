//
//  ModalViewController.m
//  STKAnimationTransition
//
//  Created by kei on 2015/02/08.
//  Copyright (c) 2015年 kei. All rights reserved.
//

#import "ModalViewController.h"
#import "STKAnimtor.h"

@interface ModalViewController ()<UIViewControllerTransitioningDelegate>

@property (nonatomic)CGFloat radius;
@property (nonatomic, strong)UIButton *btn;

@end

@implementation ModalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.transitioningDelegate = self;
    // Do any additional setup after loading the view.
    
    _btn = [[UIButton alloc]initWithFrame:(CGRect){100,200,60,60}];
    _btn.layer.cornerRadius = CGRectGetWidth(_btn.frame)/2;
    _btn.layer.masksToBounds = NO;
    _btn.layer.shadowOpacity = 0.8;
    _btn.layer.shadowRadius = 4.0;
    _btn.layer.shadowColor = [UIColor blackColor].CGColor;
    _btn.layer.shadowOffset = CGSizeMake(0.0,1.0);
    [_btn addTarget:self action:@selector(tapped:) forControlEvents:UIControlEventTouchUpInside];
    _btn.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:_btn];
    
    
    
    
    _shape = [CAShapeLayer layer];
    CGFloat x = MAX(CGRectGetMidX(_btn.frame), self.view.frame.size.width - CGRectGetMidX(_btn.frame));
    CGFloat y = MAX(CGRectGetMidY(_btn.frame), self.view.frame.size.height - CGRectGetMidY(_btn.frame));
    _radius = sqrt(x*x + y*y);
    
    _shape.frame = (CGRect){CGRectGetMidX(_btn.frame) - self.radius,
        CGRectGetMidY(_btn.frame) - self.radius, self.radius * 2, self.radius * 2};
    self.shape.anchorPoint = CGPointMake(0.5, 0.5);
    self.shape.path = [UIBezierPath bezierPathWithOvalInRect:(CGRect){0, 0, self.radius * 2, self.radius * 2}].CGPath;
    
    self.shape.fillColor = [UIColor whiteColor].CGColor;
    self.shape.transform = CATransform3DMakeScale(0.0001, 0.0001, 0.0001);
    [self.view.layer insertSublayer:self.shape atIndex:0];
    
    
    
}



- (void)tapped:(UIButton *)sender{
    
  [self dismissViewControllerAnimated:YES completion:nil];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    STKAnimtor *animator = [[STKAnimtor alloc]initWithOriginButton:self.btn fromPoint:self.btn.center toPoint:self.originPoint];
    animator.isPresenting = NO;
    return animator;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    
    STKAnimtor *animator = [[STKAnimtor alloc]initWithOriginButton:self.btn fromPoint:self.btn.center toPoint:(CGPoint){self.btn.center.x ,self.btn.center.y +100}];
    animator.isPresenting = YES;
    return animator;
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
