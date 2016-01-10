//
//  ViewController.h
//  AudioKit - HelloWorld
//
//  Created by Y8185682 on 01/01/2016.
//  Copyright (c) 2015 Y8185682. All rights reserved.
//

#import <UIKit/UIKit.h>
// These imports are required to utilise AudioKit functionality within this class and also access the AKInstrument definition declared in the 'NewInstrument' class.
#import "AKFoundation.h"
#import "NewInstrument.h"
#import "ViewController2.h"

@interface ViewController : UIViewController
@property (nonatomic) CGPoint coordinates;
@property (nonatomic) float amplitude;
@property (nonatomic) CGPoint strumCood;
@property (nonatomic) int stringSelector; //Determines which string is being plucked based on coordinates
//Create properties for swip gesture recognisers

@property (strong, nonatomic) IBOutlet UIImageView *firstString;
@property (strong, nonatomic) IBOutlet UIImageView *secondString;
@property (strong, nonatomic) IBOutlet UIImageView *thirdString;
@property (strong, nonatomic) IBOutlet UIImageView *fourthString;

//Methods
-(void)touchCoodrinates:(NSSet *)touches withEvent:(UIEvent *)event;


@end

