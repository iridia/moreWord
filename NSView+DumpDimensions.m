//
//  NSView+DumpDimensions.m
//  moreWord
//
//  Created by Evadne Wu on 5/14/10.
//  Copyright 2010 Iridia Productions. All rights reserved.
//

#import "NSView+DumpDimensions.h"


@implementation NSView (DumpDimensions)

- (NSString *) dimensions {

	return [NSString stringWithFormat:@"%@ — %f by %f, at (%f, %f) | bounds %f by %f, at (%f, %f)", 
	
		[self description],
		
		[self frame].size.width,
		[self frame].size.height,
		[self frame].origin.x,
		[self frame].origin.y,
		
		[self bounds].size.width,
		[self bounds].size.height,
		[self bounds].origin.x,
		[self bounds].origin.y
		
	];

}





- (void) logDimensions {

	NSLog(@"%@", [self dimensions]);

}





@end




