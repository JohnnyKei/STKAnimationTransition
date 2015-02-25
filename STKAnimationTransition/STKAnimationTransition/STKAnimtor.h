//
//  STKAnimtor.h
//  STKAnimationTransition
//
//  Created by kei on 2015/02/08.
//  Copyright (c) 2015年 kei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface STKAnimtor : NSObject<UIViewControllerAnimatedTransitioning>

@property (nonatomic)NSTimeInterval animateDuration;
@property (nonatomic)BOOL isPresenting;

- (instancetype)initWithOriginButton:(UIButton *)button fromPoint:(CGPoint)from toPoint:(CGPoint)to;
@end
