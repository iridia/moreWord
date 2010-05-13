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

	[self.statusBarItem setIcon:[NSImage imageNamed:@"MWStatusItemIcon.pdf"] withAlternateIcon:[NSImage imageNamed:@"MWStatusItemIconAlternate.pdf"] ];

}










# pragma mark NSStatusItem

- (void) shouldMakeStatusBarItem {
	
	self.statusBarItem = [[NSStatusBar systemStatusBar] statusItemWithLength:[[NSStatusBar systemStatusBar] thickness]];
	[self.statusBarItem setMenu:self.statusBarItemMenu];
	[self.statusBarItem setTitle:@""];
	[self.statusBarItem setHighlightMode:YES];

}










# pragma mark IBOutlets

- (IBAction) shouldGenerateOneSentence:(id)sender {

}





- (IBAction) shouldGenerateAsManySentencesAsRecentlyDid:(id)sender {

}





- (IBAction) shouldGenerateManySentencesWithInput:(id)sender {





}





- (IBAction) shouldGenerateManySentences:(id)sender {

}





- (IBAction) shouldGenerateManySentencesWithMatrixValue:(id)sender{

	[self startGeneratingSentences:[[(NSMatrix *)sender selectedCell] tag]];
	
	[self.statusBarItem startAnimation];
	[[self.statusBarItem menu] cancelTracking];

}


- (IBAction) shouldShowPreferences:(id)sender {

	[self.statusBarItem startAnimation];

}





- (IBAction) shouldShowAboutWindow:(id)sender {

}





- (IBAction) shouldTerminateApplication:(id)sender {

}










# pragma mark Processing

- (void) startGeneratingSentences:(NSInteger)numberOfSentences {

}





# pragma mark Networking










@end




