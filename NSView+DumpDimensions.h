//
//  NSView+DumpDimensions.h
//  moreWord
//
//  Created by Evadne Wu on 5/14/10.
//  Copyright 2010 Iridia Productions. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface NSView (DumpDimensions)

- (NSString *) dimensions;
- (void) logDimensions;

@end
