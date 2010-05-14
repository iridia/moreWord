//
//  MWController.h
//  moreWord
//
//  Created by Evadne Wu on 5/13/10.
//  Copyright 2010 Iridia Productions. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "JSON/SBJSON.h"
#import "JSON/NSObject+SBJSON.h"
#import "JSON/NSString+SBJSON.h"

#import "LFWebAPIKit.h"
#import "LFHTTPRequest.h"

#import "MWStatusItem.h"
#import "NSStatusItem+Iconology.h"
#import "MWConfiguration.h"
#import "MWTransformSentencesGenerated.h"





@interface MWController : NSObject <NSApplicationDelegate> {

	NSStatusItem *statusBarItem;
	IBOutlet NSMenu *statusBarItemMenu;

	NSOperationQueue *queue;

	BOOL busy;
	
}





@property (retain) NSStatusItem *statusBarItem;
@property (retain) NSMenu *statusBarItemMenu;

@property (retain) NSOperationQueue *queue;

@property (assign) BOOL busy;





- (IBAction) shouldGenerateOneSentence:(id)sender;
- (IBAction) shouldGenerateAsManySentencesAsRecentlyDid:(id)sender;
- (IBAction) shouldGenerateManySentencesWithInput:(id)sender;
- (IBAction) shouldGenerateManySentencesWithMatrixValue:(id)sender;

- (IBAction) shouldCancelOperation:(id)sender;

- (IBAction) shouldShowAbout:(id)sender;
- (IBAction) shouldTerminateApplication:(id)sender;





@end




