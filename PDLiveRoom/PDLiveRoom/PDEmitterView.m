//
//  PDEmitterView.m
//  PDLiveRoom
//
//  Created by 彭懂 on 16/9/6.
//  Copyright © 2016年 彭懂. All rights reserved.
//

#import "PDEmitterView.h"

@interface PDEmitterView ()

@property (nonatomic, strong) NSMutableArray *keepArray;
@property (nonatomic, strong) NSMutableArray *deletArray;
@property (nonatomic, assign) NSInteger zanCount;

@end

@implementation PDEmitterView

// 采用tableview的回收机制
- (NSMutableArray *)keepArray
{
    if (!_keepArray) {
        _keepArray = [[NSMutableArray alloc] init];
    }
    return _keepArray;
}

- (NSMutableArray *)deletArray
{
    if (!_deletArray) {
        _deletArray = [[NSMutableArray alloc] init];
    }
    return _deletArray;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.zanCount = 0;
    }
    return self;
}

- (void)sendUpEmitter
{
    _zanCount ++;
    if (_zanCount == INT_MAX) {
        _zanCount = 0;
    }
    CALayer *shipLabyer = nil;
    if (self.deletArray.count > 0) {
        shipLabyer = [self.deletArray firstObject];
        [self.deletArray removeObject:shipLabyer];
    } else {
        shipLabyer = [CALayer layer];
        shipLabyer.contents = (__bridge id _Nullable)([UIImage imageNamed:[NSString stringWithFormat:@"cell%zd", arc4random() % 3 + 1]].CGImage);
        shipLabyer.contentsScale = [UIScreen mainScreen].scale;
        shipLabyer.frame = CGRectMake(self.bounds.size.width / 2.0, self.bounds.size.height, 40, 40);
        shipLabyer.transform = CATransform3DMakeRotation(M_PI_2, 0, 0, 1);
    }
    shipLabyer.opacity = 1.0;
    [self.layer addSublayer:shipLabyer];
    [self.keepArray addObject:shipLabyer];
    
    [self animationKeyFrameWithLayer:shipLabyer];
}

- (void)animationKeyFrameWithLayer:(CALayer *)layer
{
    NSInteger with = self.bounds.size.width;
    NSInteger height = self.bounds.size.height;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height)];
    [path addCurveToPoint:CGPointMake(arc4random() % with, 0) controlPoint1:CGPointMake((arc4random() % with) / 2.0, (arc4random() % height) / 2.0) controlPoint2:CGPointMake((with / 2.0) + (arc4random() % with) / 2.0, height / 2.0 + (arc4random() % height) / 2.0)];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.duration = 1.2 + (arc4random() % 9) / 10.0;
    animation.rotationMode = kCAAnimationRotateAuto;
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    animation.path = path.CGPath;
    animation.fillMode = kCAFillModeForwards;
    
    // 缩放
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSNumber numberWithFloat:1.1];
    scaleAnimation.toValue = [NSNumber numberWithFloat:0.7];
    scaleAnimation.duration = 1 + (arc4random() % 10) / 10.0;
    
    CABasicAnimation *alphaAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    alphaAnimation.fromValue = @(1.0);
    alphaAnimation.toValue = @(0);
    alphaAnimation.duration = animation.duration;
    alphaAnimation.fillMode = kCAFillModeForwards;
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.repeatCount = 1;
    animationGroup.removedOnCompletion = NO;
    animationGroup.duration = animation.duration;
    animationGroup.fillMode = kCAFillModeForwards;
    animationGroup.animations = @[animation, scaleAnimation, alphaAnimation];
    animationGroup.delegate = self;
    [layer addAnimation:animationGroup forKey:[NSString stringWithFormat:@"animation%zd", _zanCount]];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    CALayer *layer = [self.keepArray firstObject];
    [layer removeAllAnimations];
    [self.deletArray addObject:layer];
    [layer removeFromSuperlayer];
    [self.keepArray removeObject:layer];
}

@end
