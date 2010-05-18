//
//  SystemSettings.h
//  TapToTeach
//
//  Created by Preston Rohner on 5/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>


@interface SystemSettings :  NSManagedObject  
{
}

@property (nonatomic, retain) NSDate * lastAccessed;
@property (nonatomic, retain) NSString * userName;
@property (nonatomic, retain) NSNumber * ttsSpeed;
@property (nonatomic, retain) NSString * ttsVoice;
@property (nonatomic, retain) NSDate * created;
@property (nonatomic, retain) NSString * userNamePhonetic;
@property (nonatomic, retain) NSNumber * ttsVariance;
@property (nonatomic, retain) NSNumber * ttsPitch;

@end



