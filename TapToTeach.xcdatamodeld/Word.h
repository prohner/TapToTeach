//
//  Word.h
//  TapToTeach
//
//  Created by Preston Rohner on 4/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>

@class WordBank;

@interface Word :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * word;
@property (nonatomic, retain) NSDate * created;
@property (nonatomic, retain) NSDate * lastAccessed;
@property (nonatomic, retain) NSString * wordPhonetic;
@property (nonatomic, retain) WordBank * wordBank;

@end



