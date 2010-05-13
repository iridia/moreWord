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

@synthesize busy, statusBarItem, statusBarItemMenu;










+ (void) initialize {

	[NSValueTransformer setValueTransformer:[[MWTransformSentencesGenerated alloc] init] forName:@"MWTransformSentencesGenerated"];

}





- (void) applicationDidFinishLaunching:(NSNotification *)aNotification {

	

}





- (void) awakeFromNib {

	[[NSUserDefaults standardUserDefaults] registerDefaults:[NSDictionary dictionaryWithObjectsAndKeys:
	
		NO, @"hasRecentlyGeneratedSentences",
		0, @"recentlyGeneratedSentences",
		
	nil]];


	[self shouldMakeStatusBarItem];	
	[self shouldConfigureStatusBarItem];

	
	self.busy = NO;
	
//	self.hasRecentlyGeneratedSentences = NO;

}










# pragma mark NSStatusItem

- (void) shouldMakeStatusBarItem {
	
	self.statusBarItem = [[NSStatusBar systemStatusBar] statusItemWithLength:[[NSStatusBar systemStatusBar] thickness]];

}

- (void) shouldConfigureStatusBarItem {

	[self.statusBarItem setMenu:self.statusBarItemMenu];
	[self.statusBarItem setTitle:@""];
	[self.statusBarItem setHighlightMode:YES];
	[self.statusBarItem setIcon:[NSImage imageNamed:@"MWStatusItemIcon.pdf"] withAlternateIcon:[NSImage imageNamed:@"MWStatusItemIconAlternate.pdf"] ];	

}










# pragma mark IBOutlets





- (IBAction) shouldCancelOperation:(id)sender {

	[self stopGeneratingSentences];

}





- (IBAction) shouldGenerateOneSentence:(id)sender {

}





- (IBAction) shouldGenerateAsManySentencesAsRecentlyDid:(id)sender {

	

}





- (IBAction) shouldGenerateManySentencesWithInput:(id)sender {





}





- (IBAction) shouldGenerateManySentencesWithMatrixValue:(id)sender{

	[self startGeneratingSentences:[[(NSMatrix *)sender selectedCell] tag]];
	
	[self.statusBarItem startAnimation];
	[[self.statusBarItem menu] cancelTracking];

}





- (IBAction) shouldShowAbout:(id)sender {

	[[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:MOREWORD_PROJECT_SITE]];

}





- (IBAction) shouldTerminateApplication:(id)sender {

}










# pragma mark Processing

- (void) startGeneratingSentences:(NSInteger)numberOfSentences {

	NSLog(@"Generating %i sentences", numberOfSentences);
	
	self.busy = YES;
	
	[[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"hasRecentlyGeneratedSentences"];

}





- (void) stopGeneratingSentences {

	self.busy = NO;
	[self.statusBarItem stopAnimation];
	[self shouldConfigureStatusBarItem];

}










# pragma mark Networking










@end




