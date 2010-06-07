//
//  CleanUpSettings.h
//  TapToTeach
//
//  Created by Preston Rohner on 6/5/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>


@interface CleanUpSettings :  NSManagedObject  
{
}

@property (nonatomic, retain) NSNumber * sizeOfImages;
@property (nonatomic, retain) NSNumber * numberOfImages;
@property (nonatomic, retain) NSSet* pictures;

@end


@interface CleanUpSettings (CoreDataGeneratedAccessors)
- (void)addPicturesObject:(NSManagedObject *)value;
- (void)removePicturesObject:(NSManagedObject *)value;
- (void)addPictures:(NSSet *)value;
- (void)removePictures:(NSSet *)value;

@end

