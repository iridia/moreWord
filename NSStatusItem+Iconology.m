//
//  NSStatusItem+Iconology.m
//  moreWord
//
//  Created by Evadne Wu on 5/13/10.
//  Copyright 2010 Iridia Productions. All rights reserved.
//

#import "NSStatusItem+Iconology.h"


@implementation NSStatusItem (Iconology)





- (void) setImage:(NSImage *)image withSize:(NSSize)aSize {

	NSImage *statusBarItemIcon = [image copy];

	[statusBarItemIcon setSize:aSize];
	
	[self setImage:statusBarItemIcon];

}





- (NSImage *) icon {

	return [self image];

}





- (void) setIcon:(NSImage *)image {

	NSLog(@"setting icon, with image: %@", image);

	[self setImage:image withSize:NSMakeSize([[NSStatusBar systemStatusBar] thickness], [[NSStatusBar systemStatusBar] thickness])];

}





@end




