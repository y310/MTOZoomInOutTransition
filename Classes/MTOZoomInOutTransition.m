//
//  MTOZoomInOutTransition.m
//
//  Created by mito on 2014/02/11.
//  Copyright (c) 2014年 mito. All rights reserved.
//

#import "MTOZoomInOutTransition.h"

@implementation MTOZoomInOutTransition

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.25;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    // Set anchorPoint
    {
        CGPoint anchorPoint = [self _anchorPointForRect:self.sourceRect inFrame:fromVC.view.frame];
        [self _setAnchorPoint:anchorPoint toView:fromVC.view];
        [self _setAnchorPoint:anchorPoint toView:toVC.view];
    }

    // Transparent target background color
    UIColor *originalColor = toVC.view.backgroundColor;
    toVC.view.backgroundColor = [UIColor clearColor];

    CGAffineTransform transform = [self _transformForSourceRect:self.sourceRect targetRect:self.targetRect];
    toVC.view.transform = CGAffineTransformInvert(transform);

    if (!self.isZoomIn) {
        toVC.view.alpha = 1;
    }

    [transitionContext.containerView insertSubview:toVC.view aboveSubview:fromVC.view];

    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         fromVC.view.transform = transform;
                         fromVC.view.alpha = 0;
                         toVC.view.transform = CGAffineTransformIdentity;
                         toVC.view.alpha = 1;
                     } completion:^(BOOL finished) {
                         fromVC.view.transform = CGAffineTransformIdentity;
                         toVC.view.backgroundColor = originalColor;
                         [transitionContext completeTransition:YES];
                     }];
}

- (CGAffineTransform)_transformForSourceRect:(CGRect)sourceRect targetRect:(CGRect)targetRect
{
    CGPoint sourceOrigin = sourceRect.origin;
    CGPoint targetOrigin = targetRect.origin;
    CGFloat scaleX = targetRect.size.width / sourceRect.size.width;
    CGFloat scaleY = targetRect.size.height / sourceRect.size.height;
    CGAffineTransform scaleTransform = CGAffineTransformMakeScale(scaleX, scaleY);
    CGAffineTransform translateTransform = CGAffineTransformMakeTranslation(targetOrigin.x - sourceOrigin.x,
                                                                            targetOrigin.y - sourceOrigin.y);
    CGAffineTransform transform = CGAffineTransformConcat(scaleTransform, translateTransform);
    return transform;
}

- (CGPoint)_anchorPointForRect:(CGRect)rect inFrame:(CGRect)frame
{
    CGPoint anchorPoint = CGPointMake(rect.origin.x / frame.size.width,
                                      rect.origin.y / frame.size.height);
    return anchorPoint;
}

- (void)_setAnchorPoint:(CGPoint)anchorPoint toView:(UIView *)view
{
    CGRect rect;
    rect = view.frame;
    view.layer.anchorPoint = anchorPoint;
    view.frame = rect;
}

@end
