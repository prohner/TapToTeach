//
//  CleanUpView.m
//  TapToTeach
//
//  Created by Preston Rohner on 5/23/10.
//  Copyright 2010 Cool Tool Apps. All rights reserved.
//

#import "CleanUpView.h"
#import <QuartzCore/QuartzCore.h>
#import <AVFoundation/AVFoundation.h>

#define RANDOM_FUNC		arc4random
#define IMAGE_SIZE		200

@implementation UIImage (Resizing)
//Read more: http://www.bukisa.com/articles/240216_iphone-resizing-a-uiimage#ixzz0px7HyDfw
- (UIImage*)scaleToSize:(CGSize)size {
	UIGraphicsBeginImageContext(size);
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextTranslateCTM(context, 0.0, size.height);
	CGContextScaleCTM(context, 1.0, -1.0);
	CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, size.width, size.height), self.CGImage);
	UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return scaledImage;
}
@end

@implementation CleanUpView

@synthesize infoButtonView;


//- (id)initWithFrame:(CGRect)frame {
//    if ((self = [super initWithFrame:frame])) {
//        // Initialization code
//    }
//    return self;
//}

- (id)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
		srandomdev();
		draggablesArray = [[NSMutableArray alloc] init];
        
//		CGRect mainViewBounds = self.bounds;
//		mainViewBounds.size.height -= 60;
//		[self setFrame:mainViewBounds];
		
		// create desk background
		deskLayer = [CALayer layer];
		deskLayer.frame = self.bounds;
		[self.layer addSublayer:deskLayer];
		
		targetLayer = [CALayer layer];
		targetLayer.bounds = CGRectMake(0, 0, 240, 240);
		targetLayer.position = CGPointMake(220, 220);
		targetLayer.contents = (id)[[UIImage imageNamed:@"CleanUpTarget.png"] CGImage];
		[deskLayer addSublayer:targetLayer];
		
		rootLayer = [CALayer layer];
		rootLayer.frame = self.bounds;
		[self.layer addSublayer:rootLayer];
		
//		CALayer *x = [CALayer layer];
//		x.bounds = CGRectMake(0, 0, 10, 10);
//		x.position = CGPointMake(210, 210);
//		x.contents = (id)[[self makeAnImageOfWidth:10 andHeight:10] CGImage];
//		[self.layer addSublayer:x];
		
		int imageSize = IMAGE_SIZE;
		
		for (int i = 0; i < 10; i++) {
			[self addImage:[self makeAnImageOfWidth:imageSize andHeight:imageSize]];
		}
		
		UITapGestureRecognizer *tapGesture2 = [[UITapGestureRecognizer alloc]
											  initWithTarget:self action:@selector(infoButtonPressed:)];
		[self.infoButtonView addGestureRecognizer:tapGesture2];
		[tapGesture2 release];
		
		UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]
											  initWithTarget:self 
											  action:@selector(handlePanGesture:)];
		[self addGestureRecognizer:panGesture];
		[panGesture release];
		
//		UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]
//											  initWithTarget:self action:@selector(handleTapGesture:)];
//		[self addGestureRecognizer:tapGesture];
//		[tapGesture release];

	}
    return self;
}

- (void)addImage:(UIImage *)newImage {
	CALayer *item = [CALayer layer];
	int imageSize = IMAGE_SIZE;

	int targetMinX = targetLayer.position.x - targetLayer.bounds.size.width / 2;
	int targetMinY = targetLayer.position.y - targetLayer.bounds.size.height / 2;
	int targetMaxX = targetLayer.position.x + targetLayer.bounds.size.width / 2;
	int targetMaxY = targetLayer.position.y + targetLayer.bounds.size.height / 2;
	int viewWidth  = self.bounds.size.width;
	int viewHeight  = self.bounds.size.height;
	
	item.cornerRadius = 15;
	//item.backgroundColor = [UIColor lightGrayColor].CGColor;
	
	item.bounds = CGRectMake(0, 0, imageSize, imageSize);
	
	
	float x = RANDOM_FUNC() % (viewWidth - imageSize / 2);
	float y = RANDOM_FUNC() % (viewHeight - imageSize / 2);
	BOOL positionIsBad = YES;
	while (positionIsBad) {
		FUNCTION_LOG(@"x=%.2f, y=%.2f, imageSize=%i, trgt.x=%f, trgt.width=%f", x, y, imageSize, targetLayer.position.x, targetLayer.bounds.size.width);
		if (x + imageSize / 2 < targetMinX) {
			// image is all the way to the left of the target
			break;
		} else if (x - imageSize / 2 > targetMaxX) {
			// image is to the right of the target
			break;
		} else {
			// image is in the same x column
			if (y - imageSize / 2 > targetMaxY) {
				// image is below the target
				break;
			}
			if (y + imageSize / 2 < targetMinY) {
				// image is below the target
				break;
			}
			
		}
		
		x = RANDOM_FUNC() % (viewWidth - imageSize / 2);
		y = RANDOM_FUNC() % (viewHeight - imageSize / 2);
	}
	
//	UIGraphicsBeginImageContext(size);
//	CGContextRef context = UIGraphicsGetCurrentContext();
//	CGContextTranslateCTM(context, 0.0, size.height);
//	CGContextScaleCTM(context, 1.0, -1.0);
//	CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, size.width, size.height), self.CGImage);
//	UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
//	UIGraphicsEndImageContext();

	item.position = CGPointMake(x, y);
	item.contents = (id)[[newImage scaleToSize: CGSizeMake(IMAGE_SIZE, IMAGE_SIZE)] CGImage];
	[item setValue:@"sheet" forKey:@"kind"];
	CGFloat r = (1000 - (RANDOM_FUNC() % 2000)) / 1000.0f;
	CGFloat angle = r * M_PI_2;
	[item setValue:[NSNumber numberWithFloat:angle] forKeyPath:@"transform.rotation.z"];
	
	[rootLayer addSublayer:item];
	[draggablesArray addObject:item];
}

- (IBAction)infoButtonPressed:(id)sender {
	FUNCTION_LOG();
}


- (IBAction)handleTapGesture:(UIPanGestureRecognizer *)sender {
	FUNCTION_LOG();
}

- (IBAction)handlePanGesture:(UIPanGestureRecognizer *)sender {
	//FUNCTION_LOG();
	switch (sender.state) {
		case UIGestureRecognizerStatePossible:
		case UIGestureRecognizerStateBegan:
		{
			FUNCTION_LOG(@"UIGestureRecognizerStateBegan");
			CGPoint viewPoint = [sender locationInView:self];
			CGPoint where = [rootLayer convertPoint:viewPoint fromLayer:self.layer];
			CALayer *hitLayer = [rootLayer hitTest:where];
			if (hitLayer != nil && hitLayer != rootLayer) {
				dragLayer = hitLayer;
				dragOrigin = hitLayer.position;
				dragLayer.zPosition = 2;
				[dragLayer setValue:[NSNumber numberWithFloat:1.5f] forKeyPath:@"transform.scale"];
				[dragLayer setValue:[NSNumber numberWithFloat:0.0f] forKeyPath:@"transform.rotation.z"];
			}
		}	
			break;
		case UIGestureRecognizerStateChanged:
			if (dragLayer != nil) {
				CGPoint viewPoint = [sender locationInView:self];
				dragLastPoint = [rootLayer convertPoint:viewPoint fromLayer:self.layer];
				// disable animation while dragging
				[CATransaction flush];
				[CATransaction begin];
				[CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
				dragLayer.position = dragLastPoint;
				[CATransaction commit];
			}
			break;
		case UIGestureRecognizerStateEnded:
			if (dragLayer != nil) {
//				CGPoint viewPoint = [sender locationInView:self];
//				CGPoint where = [rootLayer convertPoint:viewPoint fromLayer:self.layer];
				CGPoint where = dragLastPoint;
				
				CALayer *dropLayer = [deskLayer hitTest:where];
				if (dropLayer != nil && dropLayer != deskLayer) {

					NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:@"PutAway" ofType:@"wav"];
					NSData *data = [NSData dataWithContentsOfFile:soundFilePath];
					AVAudioPlayer *newPlayer = [[AVAudioPlayer alloc] initWithData:data error:nil];
					[newPlayer play];
					
					[self endDragAtPosition:dropLayer.position];
				} else {
					// generate r in range (-1, 1)
					CGFloat r = (1000 - (RANDOM_FUNC() % 2000)) / 1000.0f;
					CGFloat angle = r * M_PI_2;
					[dragLayer setValue:[NSNumber numberWithFloat:angle] forKeyPath:@"transform.rotation.z"];
					
					[self endDragAtPosition:where];
				}
			}
			break;

		default:
			break;
	}
//    CGPoint translate = sender.translation;
//	
//    CGRect newFrame = currentImageFrame;
//    newFrame.origin.x += translate.x;
//    newFrame.origin.y += translate.y;
//    sender.view.frame = newFrame;
//	
//    if (sender.state == UIGestureRecognizerStateEnded)
//        currentImageFrame = newFrame;
}

- (void)endDragAtPosition:(CGPoint)where {
	[CATransaction begin];
	[CATransaction setValue:(id)kCFBooleanTrue
					 forKey:kCATransactionDisableActions];

	dragLayer.position = where;
	dragLayer.zPosition = 0;
	[dragLayer setValue:[NSNumber numberWithFloat:1.0f] forKeyPath:@"transform.scale"];

	NSMutableArray* sublayers = [[rootLayer sublayers] mutableCopy];
	[sublayers removeObject:dragLayer];
	[sublayers addObject:dragLayer];
	rootLayer.sublayers = sublayers;
	[sublayers release];
	
	dragLayer = nil;

	[CATransaction commit];
}

- (UIImage *)makeAnImageOfWidth:(int)width andHeight:(int)height {
	UIGraphicsBeginImageContext(CGSizeMake(width, width));
	CGContextRef context = UIGraphicsGetCurrentContext();
	UIGraphicsPushContext(context);
	
//	CGContextSetShadow(context, CGSizeMake(-5.0f, 5.0f), 5.0f);
	
	CGColorRef strokeColor = [UIColor blackColor].CGColor;
	CGColorRef fillColor = [UIColor blackColor].CGColor;
	switch (random() % 13) {
		case 0:
			strokeColor = [UIColor blackColor].CGColor;
			fillColor = [UIColor blackColor].CGColor;
			break;
		case 1:
			strokeColor = [UIColor darkGrayColor].CGColor;
			fillColor = [UIColor darkGrayColor].CGColor;
			break;
		case 2:
			strokeColor = [UIColor lightGrayColor].CGColor;
			fillColor = [UIColor lightGrayColor].CGColor;
			break;
		case 3:
			strokeColor = [UIColor grayColor].CGColor;
			fillColor = [UIColor grayColor].CGColor;
			break;
		case 4:
			strokeColor = [UIColor redColor].CGColor;
			fillColor = [UIColor redColor].CGColor;
			break;
		case 5:
			strokeColor = [UIColor greenColor].CGColor;
			fillColor = [UIColor greenColor].CGColor;
			break;
		case 6:
			strokeColor = [UIColor blueColor].CGColor;
			fillColor = [UIColor blueColor].CGColor;
			break;
		case 7:
			strokeColor = [UIColor cyanColor].CGColor;
			fillColor = [UIColor cyanColor].CGColor;
			break;
		case 8:
			strokeColor = [UIColor yellowColor].CGColor;
			fillColor = [UIColor yellowColor].CGColor;
			break;
		case 9:
			strokeColor = [UIColor magentaColor].CGColor;
			fillColor = [UIColor magentaColor].CGColor;
			break;
		case 10:
			strokeColor = [UIColor orangeColor].CGColor;
			fillColor = [UIColor orangeColor].CGColor;
			break;
		case 11:
			strokeColor = [UIColor purpleColor].CGColor;
			fillColor = [UIColor purpleColor].CGColor;
			break;
		case 12:
			strokeColor = [UIColor brownColor].CGColor;
			fillColor = [UIColor brownColor].CGColor;
			break;
		case 13:
			strokeColor = [UIColor blackColor].CGColor;
			fillColor = [UIColor whiteColor].CGColor;
			break;
		default:
			break;
	}
	strokeColor = [UIColor blackColor].CGColor;

	CGContextSetStrokeColorWithColor(context, strokeColor);
	CGContextSetFillColorWithColor( context,  fillColor);
	
	CGContextBeginPath(context);
	switch (random() % 5) {
		case 0:
			// triangle
			CGContextMoveToPoint(context,    width / 2,   0);
			CGContextAddLineToPoint(context, width, height);
			CGContextAddLineToPoint(context,   0, height);
			CGContextAddLineToPoint(context, width / 2,   0);
			break;
		case 1:
			// square
			CGContextMoveToPoint(context,    0,   0);
			CGContextAddLineToPoint(context, width, 0);
			CGContextAddLineToPoint(context, width, height);
			CGContextAddLineToPoint(context, 0, height);
			CGContextMoveToPoint(context,    0,   0);
			break;
		case 2:
			// pentagon
			CGContextMoveToPoint(context,    width / 2,   0);
			CGContextAddLineToPoint(context, width, height * .35);
			CGContextAddLineToPoint(context, width * .8, height);
			CGContextAddLineToPoint(context, width * .2, height);
			CGContextAddLineToPoint(context, 0, height * .35);
			CGContextAddLineToPoint(context,    width / 2,   0);
			break;
		case 3:
			// hexagon
			CGContextMoveToPoint(context,    width / 2,   0);
			CGContextAddLineToPoint(context, width, height * .25);
			CGContextAddLineToPoint(context, width, height * .75);
			CGContextAddLineToPoint(context, width / 2, height-5);
			CGContextAddLineToPoint(context, 0, height * .75);
			CGContextAddLineToPoint(context, 0, height * .25);
			CGContextAddLineToPoint(context,    width / 2,   0);
			break;
		case 4:
			// circle
			CGContextAddEllipseInRect(context, CGRectMake(0, 0, width, height));
			break;

		default:
			break;
	}
	CGContextClosePath(context);
	CGContextDrawPath(context, kCGPathFillStroke);
	
	UIGraphicsPopContext();
	UIImage *img = [UIGraphicsGetImageFromCurrentImageContext() retain];
	UIGraphicsEndImageContext();

//	CGColorRelease(strokeColor);
//	CGColorRelease(fillColor);
	
	return img;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)dealloc {
	[draggablesArray release];
    [super dealloc];
}


@end
