//
//  Utility.h
//  TapToTeach
//
//  Created by Preston Rohner on 4/27/10.
//  Copyright 2010 Cool Tool Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

#define FUNCTION_LOGGING		1
#define MEMORY_WARNING_LOGGING		1

#if MEMORY_WARNING_LOGGING
	#define MEMORY_LOG(fmt, ...) NSLog(@"%s " fmt, __FUNCTION__, ## __VA_ARGS__)
#else
	#define MEMORY_LOG(fmt, ...) /* */
#endif

#if FUNCTION_LOGGING
	#define FUNCTION_LOG(fmt, ...) NSLog(@"%s " fmt, __FUNCTION__, ## __VA_ARGS__)
#else
	#define FUNCTION_LOG(fmt, ...) /* */
#endif


@interface Utility : NSObject {

}

@end
