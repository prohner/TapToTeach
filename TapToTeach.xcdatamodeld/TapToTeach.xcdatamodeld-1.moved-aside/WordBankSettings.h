//
//  WordBankSettings.h
//  TapToTeach
//
//  Created by Preston Rohner on 4/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>


@interface WordBankSettings :  NSManagedObject  
{
}

@property (nonatomic, retain) NSNumber * giveAudioCongratulations;
@property (nonatomic, retain) NSNumber * giveVisualCongratulations;
@property (nonatomic, retain) NSString * audioCongratulationsText;
@property (nonatomic, retain) NSNumber * numberOfTouchpoints;
@property (nonatomic, retain) NSNumber * touchpointSize;

@end



