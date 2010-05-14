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
- (void) shouldConfigureStatusBarItem;
- (void) startGeneratingSentences:(NSInteger)numberOfSentences;
- (void) stopGeneratingSentences;

@end










@implementation MWController

@synthesize busy, statusBarItem, statusBarItemMenu, queue;










+ (void) initialize {

	[NSValueTransformer setValueTransformer:[[MWTransformSentencesGenerated alloc] init] forName:@"MWTransformSentencesGenerated"];

}





- (void) applicationDidFinishLaunching:(NSNotification *)aNotification {

	[[NSUserDefaults standardUserDefaults] registerDefaults:[NSDictionary dictionaryWithObjectsAndKeys:
	
		NO, @"hasRecentlyGeneratedSentences",
		0, @"recentlyGeneratedSentences",
		
	nil]];
	
	self.queue = [[NSOperationQueue alloc] init];


	[self shouldMakeStatusBarItem];	
	[self shouldConfigureStatusBarItem];
	
	NSLog(@"now we have %@, %@", self.statusBarItem, [self.statusBarItem respondsToSelector:@selector(observeValueForKeyPath:ofObject:change:context:)] ? @"YES" : @"NO");
	
	[self addObserver:self.statusBarItem forKeyPath:@"busy" options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld) context:NULL];

	[self updateBusyStatus];	

}





- (void) awakeFromNib {



}











# pragma mark Status

- (void) updateBusyStatus {

	NSLog(@"Was asked whether app is busy.  queue is present? %@", 
	
		(self.queue == nil) ? @"NO" : @"YES"
		
	);

	if (!self.queue) self.busy = NO;
	
	NSLog(@"Queue is there, any operations?, %x, %@", 
	
		self.queue.operationCount, 
		(self.queue.operationCount > 0) ? @"SOME OPs" : @"NO OPS"
		
	);
	
	if (self.queue.operationCount > 0) self.busy = YES;
	
	self.busy = NO;

}










# pragma mark NSStatusItem

- (void) shouldMakeStatusBarItem {
	
	self.statusBarItem = [[NSStatusBar systemStatusBar] statusItemWithLength:[[NSStatusBar systemStatusBar] thickness]];

}

- (void) shouldConfigureStatusBarItem {

	[self.statusBarItem setMenu:self.statusBarItemMenu];
	[[self.statusBarItem menu] setDelegate:self.statusBarItem];
	
	[self.statusBarItem setTitle:@""];
	[self.statusBarItem setHighlightMode:YES];
	[self.statusBarItem setIcon:[NSImage imageNamed:@"MWStatusItemIcon.pdf"] withAlternateIcon:[NSImage imageNamed:@"MWStatusItemIconAlternate.pdf"] ];	

}










# pragma mark IBOutlets





- (IBAction) shouldCancelOperation:(id)sender {

	[self stopGeneratingSentences];

}





- (IBAction) shouldGenerateOneSentence:(id)sender {

	[self startGeneratingSentences:1];

}





- (IBAction) shouldGenerateAsManySentencesAsRecentlyDid:(id)sender {

	

}





- (IBAction) shouldGenerateManySentencesWithInput:(id)sender {


	//	Needs a prompt!


}





- (IBAction) shouldGenerateManySentencesWithMatrixValue:(id)sender{

	[self startGeneratingSentences:[[(NSMatrix *)sender selectedCell] tag]];
	
}





- (IBAction) shouldShowAbout:(id)sender {

	[[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:MOREWORD_PROJECT_SITE]];

}





- (IBAction) shouldTerminateApplication:(id)sender {

	[[NSApplication sharedApplication] terminate:self];

}










# pragma mark Processing

- (void) startGeneratingSentences:(NSInteger)numberOfSentences {

	NSLog(@"Generating %i sentence(s).", numberOfSentences);
		
	[self updateBusyStatus];
	
	[self.statusBarItem startAnimation];
	[[self.statusBarItem menu] cancelTracking];

//	self.busy = YES;
	
	[[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"hasRecentlyGeneratedSentences"];
	
	
	
	
	
	NSBlockOperation* __block blockOperation = [NSBlockOperation blockOperationWithBlock: ^{

		BOOL fetchFinished = NO;
		
		int retryCount = 0;
		int retryCap = 3;

		LFHTTPRequest *endpointWorker = [[[LFHTTPRequest alloc] init] autorelease];
            
		endpointWorker.shouldWaitUntilDone = YES;
		endpointWorker.delegate = self;
		endpointWorker.timeoutInterval = 5.0;
		
		while (!fetchFinished) {

			NSString *requestURLString = [NSString stringWithFormat:@"%@?n=%i", MORETEXT_ENDPOINT, numberOfSentences];
			
			NSLog(@"Firing request %@", requestURLString);
			
			[endpointWorker performMethod:LFHTTPRequestGETMethod onURL:[NSURL URLWithString:requestURLString] withData:nil];
			
			NSString *responseString = [NSString stringWithCString:[[endpointWorker receivedData] bytes] encoding:NSUTF8StringEncoding];
			
			NSLog(@"received data: %@", responseString);
			
			if (responseString != NULL) {
			
				fetchFinished = YES;
				
				break;
			
			}
			
			retryCount += 1; 
			
			if (retryCount >= retryCap) {
			
				[self cancel];
				return;
			
			}
		
		}
	
	}];
	
	[self.queue addOperation:blockOperation];
	
	[self updateBusyStatus];

}





- (void) stopGeneratingSentences {

	[self.statusBarItem stopAnimation];
	[self shouldConfigureStatusBarItem];
	
	[self updateBusyStatus];

}










# pragma mark Networking





- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {

	NSLog(@"from delegate.  the app’s status has just changed! %@, %@, %@, %@", keyPath, object, change, context);

	if ([super respondsToSelector:@selector(observeValueForKeyPath:ofObject:change:context:)])
	[super observeValueForKeyPath:keyPath ofObject:object change:change context:context];

}



@end




