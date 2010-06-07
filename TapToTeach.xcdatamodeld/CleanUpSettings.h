//
//  CleanUpSettings.h
//  TapToTeach
//
//  Created by Preston Rohner on 6/6/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>

@class CleanUpPicture;

@interface CleanUpSettings :  NSManagedObject  
{
}

@property (nonatomic, retain) NSNumber * sizeOfImages;
@property (nonatomic, retain) NSNumber * numberOfImages;
@property (nonatomic, retain) NSSet* pictures;

@end


@interface CleanUpSettings (CoreDataGeneratedAccessors)
- (void)addPicturesObject:(CleanUpPicture *)value;
- (void)removePicturesObject:(CleanUpPicture *)value;
- (void)addPictures:(NSSet *)value;
- (void)removePictures:(NSSet *)value;

@end

