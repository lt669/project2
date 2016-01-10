//
//  strumView.m
//  AudioKit - HelloWorld
//
//  Created by lewis thresh on 09/01/2016.
//  Copyright © 2016 Sam Beedell. All rights reserved.
//
//
//
//  Created by Aurelius Prochazka on 8/6/14.
//  Copyright (c) 2014 Aurelius Prochazka. All rights reserved.
//

#import "strumView.h"

@interface strumView () {
    UITouch *firstTouch;
}
@end


@implementation strumView
@synthesize fingerPosition;
int stringOneCounter;

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"TouchesBegan!");
    NSArray *touchSet = [[event allTouches] allObjects];
    for (UITouch *touch in touchSet) {
        if ((!firstTouch) || (touch == firstTouch)) {
            CGPoint touchPoint = [touch locationInView:self];
            [self setFingerPositionWithTouchPoint:touchPoint];
         //   NSLog(@"X: %f Y: %f",touchPoint.x , touchPoint.y);
        }
    }
    
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSArray *touchSet = [[event allTouches] allObjects];
    for (UITouch *touch in touchSet) {
        if ((!firstTouch) || (touch == firstTouch)) {
            CGPoint touchPoint = [touch locationInView:self];
            [self setFingerPositionWithTouchPoint:touchPoint];
        }
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSArray *touchSet = [[event allTouches] allObjects];
    for (UITouch *touch in touchSet) {
        if ((!firstTouch) || (touch == firstTouch)) {
            CGPoint touchPoint = [touch locationInView:self];
            [self setFingerPositionWithTouchPoint:touchPoint];
            firstTouch=nil;
        }
    }
}

- (int)setFingerPositionWithTouchPoint:(CGPoint) touchPoint
{
    self.fingerPosition = 0; //Set to 0 to prevent reactivation of string
    NSLog(@"stringOneCounter: %i",stringOneCounter);
    if (touchPoint.x > 0 && touchPoint.x < self.bounds.size.width &&
        touchPoint.y > 260 && touchPoint.y < 280)
    {
        if (stringOneCounter == 0) {
        stringOneCounter++;
        self.fingerPosition = 1;
       // NSLog(@"WITHIN FIRST STRING");
        }
    } else if(touchPoint.x > 0 && touchPoint.x < self.bounds.size.width &&
              touchPoint.y > 329 && touchPoint.y < 355){
        self.fingerPosition = 2;
        //NSLog(@"WITHIN SECOND STRING");
    } else {
        stringOneCounter = 0;
    }
    
    return fingerPosition;
}


@end
