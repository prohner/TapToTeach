//
//  WordBank.h
//  TapToTeach
//
//  Created by Preston Rohner on 4/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>


@interface WordBank :  NSManagedObject  
{
}

@property (nonatomic, retain) NSDate * created;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSDate * lastAccessed;
@property (nonatomic, retain) NSSet* words;

@end


@interface WordBank (CoreDataGeneratedAccessors)
- (void)addWordsObject:(NSManagedObject *)value;
- (void)removeWordsObject:(NSManagedObject *)value;
- (void)addWords:(NSSet *)value;
- (void)removeWords:(NSSet *)value;

@end

