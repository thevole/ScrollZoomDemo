//
//  ScrollZoomViewController.h
//  ScrollZoom
//
//  Created by Martin Volerich on 2/19/10.
//  Copyright Bill Bear Technologies 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScrollZoomViewController : UIViewController <UIScrollViewDelegate> {
	UIScrollView *scroller;
	UIImageView *mainImageView;
	BOOL isZooming;
	NSArray *containedImageViews;
}

@property (nonatomic, retain) UIScrollView *scroller;
@property (nonatomic, retain) UIImageView *mainImageView;
@property (nonatomic, retain) NSArray *containedImageViews;

@end

