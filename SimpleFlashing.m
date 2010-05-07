//
//  SimpleFlashing.m
//  TapToTeach
//
//  Created by Preston Rohner on 5/6/10.
//  Copyright 2010 Cool Tool Apps. All rights reserved.
//

#import "SimpleFlashing.h"


@implementation SimpleFlashing

- (void)viewDidLoad {
	[super viewDidLoad];
	label = [[UILabel alloc] initWithFrame:originRect];
	label.alpha = 0;
	label.backgroundColor = [UIColor brownColor];
	[self.view addSubview:label];
}

//- (void)viewDidAppear:(BOOL)animated {
//	[super viewWillAppear:animated];
//	[self reloadWordBankAndStart];
//}

- (void)run {
	[super run];
	[UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:duration];
	label.alpha = 1;
    [UIView commitAnimations];

	[UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:duration];
	label.alpha = 0;
    [UIView commitAnimations];
	
	[self endRun];
}

@end
