//
//  MWController.m
//  moreWord
//
//  Created by Evadne Wu on 5/13/10.
//  Copyright 2010 Iridia Productions. All rights reserved.
//

#import "MWController.h"





@interface MWController (Private)

- (void) updateBusyStatus;
- (void) shouldMakeStatusBarItem;
- (void) shouldConfigureStatusBarItem;
- (void) startGeneratingSentences:(NSInteger)numberOfSentences;
- (void) stopGeneratingSentences;

@end




















@implementation MWController

@synthesize busy, statusBarItem, statusBarItemMenu, queue;










- (void) applicationDidFinishLaunching: (NSNotification *)aNotification {

	[[NSUserDefaults standardUserDefaults] registerDefaults:[NSDictionary dictionaryWithObjectsAndKeys:
	
		NO, @"hasRecentlyGeneratedSentences",
		0, @"recentlyGeneratedSentences",
		
	nil]];
	
	self.queue = [[NSOperationQueue alloc] init];

	[self shouldMakeStatusBarItem];	
	[self shouldConfigureStatusBarItem];
		
	[self updateBusyStatus];

}





- (void) awakeFromNib {}










# pragma mark Status

- (void) updateBusyStatus {

	if (!self.queue) {
	
		self.busy = NO;
		return;
	
	}
	
	self.busy = ([self.queue.operations count] > 0);
	
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




















# pragma mark IBOutlets & Generation Helper Methods





- (IBAction) shouldCancelOperation:(id)sender {

	[self stopGeneratingSentences];

}





- (IBAction) shouldGenerateOneSentence:(id)sender {

	[self startGeneratingSentences:1];

}





- (IBAction) shouldGenerateAsManySentencesAsRecentlyDid:(id)sender {

	[self startGeneratingSentences:[[NSUserDefaults standardUserDefaults] integerForKey:@"recentlyGeneratedSentences"]];

}





- (IBAction) shouldGenerateManySentencesWithInput:(id)sender {

	//	FIXME: Needs a prompt.

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

	[self.statusBarItem startAnimation];
	[[self.statusBarItem menu] cancelTracking];
	
	[self.queue addOperationWithBlock: ^ {
	
		int retryCount = 0;
		int retryCap = 3;
		
		LFHTTPRequest *endpointWorker = [[[LFHTTPRequest alloc] init] autorelease];
            
		endpointWorker.shouldWaitUntilDone = YES;
		endpointWorker.delegate = self;
		endpointWorker.timeoutInterval = 5.0;
		
		NSString *responseString;
		
		do {

			NSString *requestURLString = [NSString stringWithFormat:@"%@?n=%i&corpus=laihe", MORETEXT_ENDPOINT, numberOfSentences];
			
			[endpointWorker performMethod:LFHTTPRequestGETMethod onURL:[NSURL URLWithString:requestURLString] withData:nil];
			
			responseString = [[NSString alloc] initWithData:[endpointWorker receivedData] encoding:NSUTF8StringEncoding];
			
			retryCount += 1; if (retryCount >= retryCap) return;
		
		} while (responseString.length == 0);
				
		[self performSelectorOnMainThread:@selector(hadGeneratedSentences:) withObject:[[responseString JSONValue] objectForKey:@"sentences"] waitUntilDone:NO];
	
	}];	
	
	[self updateBusyStatus];
	
//	[[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"hasRecentlyGeneratedSentences"];
	
}





- (void) hadGeneratedSentences:(NSArray *)sentences {

	NSMutableString *finalString = [[NSMutableString alloc] initWithString:@""];
	
	for (NSString *sentenceContext in sentences)
	[finalString appendString:sentenceContext];
	
	NSPasteboard *pasteBoard = [NSPasteboard generalPasteboard];
	[pasteBoard declareTypes:[NSArray arrayWithObjects:NSStringPboardType, nil] owner:nil];
	[pasteBoard setString:finalString forType:NSStringPboardType];
	
	NSBeep();
	
	
	[self.statusBarItem stopAnimation];
	[self shouldConfigureStatusBarItem];
	
	[self updateBusyStatus];

}





- (void) stopGeneratingSentences {

	[self.queue cancelAllOperations];

	[self.statusBarItem stopAnimation];
	[self shouldConfigureStatusBarItem];
	
	[self updateBusyStatus];

}










@end




