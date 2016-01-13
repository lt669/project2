//
//  ViewController2.m
//  AudioKit - HelloWorld
//
//  Created by Y8185682 on 01/01/2016.
//  Copyright (c) 2015 Y8185682. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ViewController2.h"
//#import "ViewController.h"

@interface ViewController2()

@end

//NSMutableArray *optionsValuesArray;

@implementation ViewController2
{
    IBOutlet UISlider *volume;
    IBOutlet UISlider *detuneValue;
    IBOutlet UISlider *bodySize;
    
    IBOutlet UILabel *amplitudeLabel;
    IBOutlet UILabel *detuneLabel;
    IBOutlet UILabel *bodySizeLabel;
    
    IBOutlet UISwitch *tapModeSwitch;
    IBOutlet UISwitch *sustainModeSwitch;
    IBOutlet UISwitch *showNotesSwitch;
    
    IBOutlet UIButton *save;
}
@synthesize volumeSliderValue, detuneSliderValue, bodySizeSliderValue, optionsValuesArray, volumeSliderValueReceive, detuneSliderValueReceive, bodySizeSliderValueReceive, tapModeInt, sustainModeInt, showNotesInt, firstLoadReceive;

- (IBAction)defaultSettings:(id)sender {//Sets parameters to a default setting
    volume.value = 0.5;
    detuneValue.value = 0.5;
    bodySize.value = 0.5;
    [tapModeSwitch setOn:YES animated:YES];
    [sustainModeSwitch setOn:YES animated:YES];
    tapModeInt = 1;
    sustainModeInt = 1;
    showNotesInt = 0;
    amplitudeLabel.text = [NSString stringWithFormat:@"50%%"];
    detuneLabel.text = [NSString stringWithFormat:@"50%%"];
    bodySizeLabel.text = [NSString stringWithFormat:@"50%%"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Set button round
    save.layer.cornerRadius = 8;
    
    if (firstLoadReceive == 0) {//Set default settings if this is the first time the app is open
    amplitudeLabel.text = [NSString stringWithFormat:@"40%%"];
    detuneLabel.text = [NSString stringWithFormat:@"50%%"];
    bodySizeLabel.text = [NSString stringWithFormat:@"50%%"];
    [tapModeSwitch setOn:YES animated:YES];
    [sustainModeSwitch setOn:YES animated:YES];
    [showNotesSwitch setOn:NO animated:YES];
    volume.value = 0.5;
    detuneValue.value = 0.5;
    bodySize.value = 0.5;

    //If sustain/tapMode isnt pressed this value keeps its state when reopened
    tapModeInt = 1;
    sustainModeInt = 1;
    showNotesInt = 0;

    } else { //Take previously set values

    //Receive the previously saved sliders values and reset the sliders and tapMode switch
    volume.value = volumeSliderValueReceive;
    detuneValue.value = detuneSliderValueReceive;
    bodySize.value = bodySizeSliderValueReceive;
        
    if(tapModeInt == 1){
        [tapModeSwitch setOn:YES animated:YES];
    } else if(tapModeInt ==0){
        [tapModeSwitch setOn:NO animated:YES];
    }
        
    if(sustainModeInt == 1){
        [sustainModeSwitch setOn:YES animated:YES];
    } else if(sustainModeInt ==0){
        [sustainModeSwitch setOn:NO animated:YES];
    }
        
    if(showNotesInt == 1){
        [showNotesSwitch setOn:YES animated:YES];
    } else if(showNotesInt == 0){
        [showNotesSwitch setOn:NO animated:YES];
    }

    //Reset the slider lables
    amplitudeLabel.text = [NSString stringWithFormat:@"%0.0f%%",(volumeSliderValueReceive*100)];
    detuneLabel.text = [NSString stringWithFormat:@"%0.0f%%",(detuneSliderValueReceive*100)];
    bodySizeLabel.text = [NSString stringWithFormat:@"%0.0f%%",(bodySizeSliderValueReceive*100)];
    }
}

- (IBAction)volumeChanged:(UISlider *)sender { //Set label values
    
    amplitudeLabel.text = [NSString stringWithFormat:@"%0.0f%%",(volume.value*100)]; //In Percentage
    detuneLabel.text = [NSString stringWithFormat:@"%0.0f%%",(detuneValue.value*100)];
    bodySizeLabel.text = [NSString stringWithFormat:@"%0.0f%%",(bodySize.value*100)];
}
- (IBAction)tapMode:(UISwitch *)sender {

    if ([tapModeSwitch isOn]) {
        self.tapModeInt = 1;
    } else {
        self.tapModeInt = 0;
    }
}
- (IBAction)sustainMode:(UISwitch *)sender {
    if([sustainModeSwitch isOn]){
    self.sustainModeInt = 1;
    } else {
        self.sustainModeInt = 0;
    }
}
- (IBAction)showNotes:(UISwitch *)sender {
    if([showNotesSwitch isOn]){
        self.showNotesInt = 1;
    } else {
        self.showNotesInt = 0;
    }
}

- (IBAction)saved:(UIButton *)sender {
    self.volumeSliderValue = volume.value; //
    self.detuneSliderValue = detuneValue.value;
    self.bodySizeSliderValue = bodySize.value;
}
@end