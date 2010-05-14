//
//  MWTransformSentencesGenerated.m
//  moreWord
//
//  Created by Evadne Wu on 5/14/10.
//  Copyright 2010 Iridia Productions. All rights reserved.
//

#import "MWTransformSentencesGenerated.h"


@implementation MWTransformSentencesGenerated





+ (void) initialize {

	[NSValueTransformer setValueTransformer:[[MWTransformSentencesGenerated alloc] init] forName:@"MWTransformSentencesGenerated"];

}





+ (Class) transformedValueClass {

	return [NSString class];
	
}





+ (BOOL) allowsReverseTransformation {

	return NO;

}





- (id) transformedValue:(id)value {
	
	NSInteger sentencesRecentlyGenerated = (NSInteger)value;

	if (sentencesRecentlyGenerated == 0){

		return @"Has not generated any sentence yet";

	} else if (sentencesRecentlyGenerated == 1) {

		return [NSString stringWithFormat:@"Make %i Sentence", sentencesRecentlyGenerated];

	} else {
	
		return [NSString stringWithFormat:@"Make %i Sentences", sentencesRecentlyGenerated];
	
	}
	
	return nil;

}



@end
