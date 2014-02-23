//
//  MTOZoomInOutTransition.h
//
//  Created by mito on 2014/02/11.
//  Copyright (c) 2014年 mito. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTOZoomInOutTransition : NSObject
<UIViewControllerAnimatedTransitioning>
@property (assign) CGRect sourceRect;
@property (assign) CGRect targetRect;
@property (assign, getter = isZoomIn) BOOL zoomIn;
@end
