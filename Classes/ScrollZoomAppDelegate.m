//
//  ScrollZoomAppDelegate.m
//  ScrollZoom
//
//  Created by Martin Volerich on 2/19/10.
//  Copyright Bill Bear Technologies 2010. All rights reserved.
//

#import "ScrollZoomAppDelegate.h"
#import "ScrollZoomViewController.h"

@implementation ScrollZoomAppDelegate


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
	window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	viewController = [[ScrollZoomViewController alloc] init];
	
    // Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
