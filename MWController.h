//
//  MWController.h
//  moreWord
//
//  Created by Evadne Wu on 5/13/10.
//  Copyright 2010 Iridia Productions. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NSStatusItem+Iconology.h"


@interface MWController : NSObject <NSApplicationDelegate> {


	NSStatusItem *statusBarItem;
	IBOutlet NSMenu *statusBarItemMenu;




}





@property (retain) NSStatusItem *statusBarItem;
@property (retain) NSMenu *statusBarItemMenu;





- (IBAction) shouldGenerateOneSentence:(id)sender;
- (IBAction) shouldGenerateAsManySentencesAsRecentlyDid:(id)sender;
- (IBAction) shouldGenerateManySentencesWithInput:(id)sender;
- (IBAction) shouldGenerateManySentencesWithMatrixValue:(id)sender;

- (IBAction) shouldShowPreferences:(id)sender;
- (IBAction) shouldShowAboutWindow:(id)sender;
- (IBAction) shouldTerminateApplication:(id)sender;





@end




