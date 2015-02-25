//
//  ViewController.m
//  STKAnimationTransition
//
//  Created by kei on 2015/02/08.
//  Copyright (c) 2015年 kei. All rights reserved.
//

#import "ViewController.h"
#import "ModalViewController.h"

@interface ViewController ()<UIViewControllerTransitioningDelegate>


@property (nonatomic, strong)UIButton *btn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.transitioningDelegate  = self;
    
    _btn = [[UIButton alloc]initWithFrame:(CGRect){100,200,60,60}];
    [_btn addTarget:self action:@selector(tapped:) forControlEvents:UIControlEventTouchUpInside];
    _btn.layer.cornerRadius = CGRectGetWidth(_btn.frame)/2;
    
    _btn.layer.masksToBounds = NO;
    _btn.layer.shadowOpacity = 0.8;
    _btn.layer.shadowRadius = 4.0;
    _btn.layer.shadowColor = [UIColor blackColor].CGColor;
    _btn.layer.shadowOffset = CGSizeMake(0.0,1.0);
    _btn.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:_btn];
    
    
}


- (void)tapped:(UIButton *)sender{
    ModalViewController *vc = [[ModalViewController alloc]init];
    vc.originPoint = _btn.center;
    [self presentViewController:vc animated:YES completion:nil];
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
