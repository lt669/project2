//
//  ViewController2.h
//  AudioKit - HelloWorld
//
//  Created by lewis thresh on 08/01/2016.
//  Copyright © 2016 Sam Beedell. All rights reserved.
//

#import <UIKit/UIKit.h>
// These imports are required to utilise AudioKit functionality within this class and also access the AKInstrument definition declared in the 'NewInstrument' class.
#import "AKFoundation.h"
#import "NewInstrument.h"
#import "AKPropertySlider.h"

@interface ViewController2 : UIViewController
@property (nonatomic) float sliderValue; //Should this be an int?

@end