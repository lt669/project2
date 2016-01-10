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
int stringOneCounter, stringTwoCounter, stringThreeCounter, stringFourCounter;

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
        if (stringOneCounter == 0) { //Second if statement prevents string from activating again once inside the coordinate space
        stringOneCounter++;
        self.fingerPosition = 1;
        }
    } else if(touchPoint.x > 0 && touchPoint.x < self.bounds.size.width &&
              touchPoint.y > 329 && touchPoint.y < 355){
        if(stringTwoCounter ==0){
        stringTwoCounter++;
        self.fingerPosition = 2;
        }
      
    } else if(touchPoint.x > 0 && touchPoint.x < self.bounds.size.width &&
               touchPoint.y > 404 && touchPoint.y < 424){
        if(stringThreeCounter ==0){
            stringThreeCounter++;
            self.fingerPosition = 3;
        }
        
    } else if(touchPoint.x > 0 && touchPoint.x < self.bounds.size.width &&
               touchPoint.y > 476 && touchPoint.y < 496){
        if(stringFourCounter ==0){
            stringFourCounter++;
            self.fingerPosition = 4;
        }
        
    } else {
        stringOneCounter = 0;
        stringTwoCounter = 0;
        stringThreeCounter = 0;
        stringFourCounter = 0;
    }
    
    return fingerPosition;
}


@end
