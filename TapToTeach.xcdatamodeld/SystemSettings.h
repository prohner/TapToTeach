//
//  SystemSettings.h
//  TapToTeach
//
//  Created by Preston Rohner on 4/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>


@interface SystemSettings :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * userNamePhonetic;
@property (nonatomic, retain) NSString * userName;

@end



