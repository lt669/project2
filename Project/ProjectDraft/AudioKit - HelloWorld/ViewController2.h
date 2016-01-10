//
//  ViewController2.h
//  AudioKit - HelloWorld
//
//  Created by Y8185682 on 01/01/2016.
//  Copyright (c) 2015 Y8185682. All rights reserved.
//

#import <UIKit/UIKit.h>
// These imports are required to utilise AudioKit functionality within this class and also access the AKInstrument definition declared in the 'NewInstrument' class.
#import "AKFoundation.h"
#import "NewInstrument.h"
#import "AKPropertySlider.h"

@interface ViewController2 : UIViewController
@property (nonatomic) float volumeSliderValue;
@property (nonatomic) float detuneSliderValue;

@end