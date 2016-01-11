//
//  strumView.m
//  AudioKit - HelloWorld
//
//  Created by Y8185682 on 09/01/2016.
//  Copyright © 2016 Y8185682. All rights reserved.
//
//  Adapted from AudioKit Example "TouchRegions" written by  Aurelius Prochazka
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
    NSArray *touchSet = [[event allTouches] allObjects]; //Create array to store x and y values
    for (UITouch *touch in touchSet) {
        if ((!firstTouch) || (touch == firstTouch)) {
            CGPoint touchPoint = [touch locationInView:self]; //Retrive touch coordinates
            [self setFingerPositionWithTouchPoint:touchPoint]; //Send coordinates to method
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

- (void)setFingerPositionWithTouchPoint:(CGPoint) touchPoint //Method to detect which are of the view has been touched
{
    if (touchPoint.x > 0 && touchPoint.x < self.bounds.size.width &&
        touchPoint.y > 260 && touchPoint.y < 280) //Coordinates for first strings
    {
        if (stringOneCounter == 0) { //Second if statement prevents string from activating again once inside the coordinate space
        stringOneCounter++; //Increment counter
        self.fingerPosition = 1; //Arbitray value used to notify viewController which string has been struck
        }
    } else if(touchPoint.x > 0 && touchPoint.x < self.bounds.size.width &&
              touchPoint.y > 329 && touchPoint.y < 355){ //Coordinates for second strings
        if(stringTwoCounter ==0){
        stringTwoCounter++;
        self.fingerPosition = 2;
        }
      
    } else if(touchPoint.x > 0 && touchPoint.x < self.bounds.size.width &&
               touchPoint.y > 404 && touchPoint.y < 424){ //Coordinates for third strings
        if(stringThreeCounter ==0){
            stringThreeCounter++;
            self.fingerPosition = 3;
        }
        
    } else if(touchPoint.x > 0 && touchPoint.x < self.bounds.size.width &&
               touchPoint.y > 476 && touchPoint.y < 496){ //Coordinates for fourth strings
        if(stringFourCounter ==0){
            stringFourCounter++;
            self.fingerPosition = 4;
        }
        
    } else if(touchPoint.x < self.bounds.size.width){ //Once each string region has been left, the counters are reset to re-enable the use of that string
        stringOneCounter = 0;
        stringTwoCounter = 0;
        stringThreeCounter = 0;
        stringFourCounter = 0;
    }
}


@end
