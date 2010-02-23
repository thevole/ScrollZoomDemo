//
//  ScrollZoomViewController.m
//  ScrollZoom
//
//  Created by Martin Volerich on 2/19/10.
//  Copyright Bill Bear Technologies 2010. All rights reserved.
//

#import "ScrollZoomViewController.h"

@implementation ScrollZoomViewController

@synthesize scroller;
@synthesize mainImageView;
@synthesize containedImageViews;

#pragma mark Initializers and teardown

- (id)init {
	if (self = [super init]) {
		
	}
	return self;
}

- (void)dealloc {
	[mainImageView release];
	[scroller release];
	[containedImageViews release];
    [super dealloc];
}

#pragma mark -
#pragma mark View setup

- (void)loadPhotosIntoScrollView:(UIScrollView *)scrollView {
	CGRect rect = scrollView.bounds;
	UIImageView *anImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"photo.png"]];
	anImageView.frame = rect;
	anImageView.contentMode = UIViewContentModeScaleAspectFit;
	anImageView.backgroundColor = [UIColor redColor];
	[scrollView addSubview:anImageView];
	
	
	self.mainImageView = anImageView;
	[anImageView release];
	
	
	
	rect.origin.x += rect.size.width;
	anImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"photo2.png"]];
	anImageView.frame = rect;
	anImageView.contentMode = UIViewContentModeScaleAspectFit;
	anImageView.backgroundColor = [UIColor blueColor];
	[scrollView addSubview:anImageView];
	[anImageView release];
	
	scrollView.pagingEnabled = YES;
	scrollView.contentSize = CGSizeMake(rect.size.width * 2.0f, rect.size.height);
	
}

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	
	CGRect rect = [[UIScreen mainScreen] applicationFrame];
	
	UIView *contentView = [[UIView alloc] initWithFrame:rect];
	contentView.backgroundColor = [UIColor darkGrayColor];
	self.view = contentView;
	[contentView release];
	
	rect = contentView.bounds;
	
	UIScrollView *aScrollView = [[UIScrollView alloc]
								 initWithFrame:rect];
	self.scroller = aScrollView;
	self.scroller.backgroundColor = [UIColor greenColor];
	self.scroller.contentMode = UIViewContentModeCenter;
	self.scroller.autoresizesSubviews = YES;
	self.scroller.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight; 
	[aScrollView release];
	[contentView addSubview:self.scroller];
	
	[self loadPhotosIntoScrollView:self.scroller];
	
	
	// set up scrolling and zoom
	self.scroller.maximumZoomScale = 3.0f;
	self.scroller.minimumZoomScale = 1.0f;
	self.scroller.delegate = self;

}


- (void)viewDidLoad {
	[super viewDidLoad];
	mainImageView.image = [UIImage imageNamed:@"photo.png"];
	isZooming = NO;
	
}

#pragma mark -
#pragma mark Zoom management

- (UIView *)currentView {
	CGPoint pt = self.scroller.contentOffset;
	CGFloat width = self.scroller.bounds.size.width;
	NSInteger imageIndex = pt.x / width;
	NSLog(@"Working with image %d", imageIndex);
	return self.mainImageView;
}

- (void)startZoom {
	// Find view that is being touched
	
	UIView *currentView = [self currentView];
	
	NSMutableArray *subviewList = [NSMutableArray array];
	for (UIView *childView in self.scroller.subviews) {
		if ([childView isKindOfClass:[UIImageView class]]) {
			[subviewList addObject:childView];
			if (childView != currentView)
				[childView removeFromSuperview];
		}
	}
	self.containedImageViews = subviewList;
	self.scroller.contentSize = scroller.bounds.size;
	self.scroller.pagingEnabled = NO;

}

- (void)stopZoom {
	UIView *currentView = self.mainImageView;
	for (UIView *childView in containedImageViews) {
		if (childView != currentView) {
			[self.scroller addSubview:childView];
		}
	}
	CGFloat width = self.scroller.bounds.size.width;
	CGFloat height = self.scroller.bounds.size.height;
	CGSize contentSize = CGSizeMake(width * [self.containedImageViews count], height);
	self.scroller.contentSize = contentSize;
	self.scroller.pagingEnabled = YES;
	self.containedImageViews = nil;
}

#pragma mark -
#pragma mark UIScrollViewDelegate methods

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
	if (!isZooming) {
		isZooming = YES;
		NSLog(@"Starting zoom");
		[self startZoom];
	}
	
	return self.mainImageView;
}

// iPhone 3.2 only
- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view {
	NSLog(@"Beginning zoom");
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale
{
	if (1.0f == scale) {
		NSLog(@"Reset scrollview to normal view");
		isZooming = NO;
		[self stopZoom];
	}
}



- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}




@end