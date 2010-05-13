//
//  MWController.m
//  moreWord
//
//  Created by Evadne Wu on 5/13/10.
//  Copyright 2010 Iridia Productions. All rights reserved.
//

#import "MWController.h"





@interface MWController (Private)

- (void) shouldMakeStatusBarItem;

@end










@implementation MWController

@synthesize statusBarItem, statusBarItemMenu;










- (void) applicationDidFinishLaunching:(NSNotification *)aNotification {

	

}





- (void) awakeFromNib {

	[self shouldMakeStatusBarItem];

	[[NSGraphicsContext currentContext] setImageInterpolation:NSImageInterpolationHigh];
	[[NSGraphicsContext currentContext] setShouldAntialias:YES];

	[self.statusBarItem setIcon:[NSImage imageNamed:@"MWStatusItemIcon.pdf"]];

}










# pragma mark NSStatusItem

- (void) shouldMakeStatusBarItem {
	
	self.statusBarItem = [[NSStatusBar systemStatusBar] statusItemWithLength:[[NSStatusBar systemStatusBar] thickness]];
	[self.statusBarItem setMenu:self.statusBarItemMenu];
	[self.statusBarItem setTitle:@""];
	[self.statusBarItem setHighlightMode:YES];

}





@end





