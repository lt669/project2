//
//  ViewController2.m
//  AudioKit - HelloWorld
//
//  Created by Y8185682 on 01/01/2016.
//  Copyright (c) 2015 Y8185682. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ViewController2.h"

@interface ViewController2()
//@property (nonatomic) CGPoint coordinates;


@end
@implementation ViewController2
{
    IBOutlet UISlider *volume;
    IBOutlet UISlider *detuneValue;
    IBOutlet UISlider *bodySize;
    
    IBOutlet UILabel *amplitudeLabel;
    IBOutlet UILabel *detuneLabel;
    IBOutlet UILabel *bodySizeLabel;
}
@synthesize volumeSliderValue, detuneSliderValue, bodySizeSliderValue;

- (IBAction)defaultSettings:(id)sender {
    volume.value = 0.5;
    detuneValue.value = 0.5;
    bodySize.value = 0.5;
    amplitudeLabel.text = [NSString stringWithFormat:@"50%%"];
    detuneLabel.text = [NSString stringWithFormat:@"50%%"];
    bodySizeLabel.text = [NSString stringWithFormat:@"50%%"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    amplitudeLabel.text = [NSString stringWithFormat:@"50%%"];
    detuneLabel.text = [NSString stringWithFormat:@"50%%"];
    bodySizeLabel.text = [NSString stringWithFormat:@"50%%"];
}
                        
- (IBAction)volumeChanged:(UISlider *)sender { //Set label values
    
    amplitudeLabel.text = [NSString stringWithFormat:@"%0.0f%%",(volume.value*100)]; //In Percentage
    detuneLabel.text = [NSString stringWithFormat:@"%0.0f%%",(detuneValue.value*100)];
    bodySizeLabel.text = [NSString stringWithFormat:@"%0.0f%%",(bodySize.value*100)];
}

- (IBAction)saved:(UIButton *)sender {
    self.volumeSliderValue = volume.value; //
    self.detuneSliderValue = detuneValue.value;
    self.bodySizeSliderValue = bodySize.value;
}


////sending data from here to ViewController (main page)
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    if ([segue.identifier isEqualToString:[@"saved"]){
//        
//        ViewController *view = (ViewController *) segue.destinationViewController;
//        view.volume = self.sliderValue; //Send the value of the slider to the amplitude of the Mandolin
//    }
//}



@end