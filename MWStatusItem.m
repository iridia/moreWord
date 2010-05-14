//
//  MWStatusItem.m
//  moreWord
//
//  Created by Evadne Wu on 5/14/10.
//  Copyright 2010 Iridia Productions. All rights reserved.
//

#import "MWStatusItem.h"


@implementation MWStatusItem





# pragma Over

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {

	NSLog(@"the app’s status has just changed! %@, %@, %@, %@", keyPath, object, change, context);

	if ([super respondsToSelector:@selector(observeValueForKeyPath:ofObject:change:context:)])
	[super observeValueForKeyPath:keyPath ofObject:object change:change context:context];

}


@end
