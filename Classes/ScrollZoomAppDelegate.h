//
//  ScrollZoomAppDelegate.h
//  ScrollZoom
//
//  Created by Martin Volerich on 2/19/10.
//  Copyright Bill Bear Technologies 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ScrollZoomViewController;

@interface ScrollZoomAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    ScrollZoomViewController *viewController;
}

@end

