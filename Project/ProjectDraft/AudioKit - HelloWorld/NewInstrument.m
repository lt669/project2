//
//  NewInstrument.h
//  AudioKit - HelloWorld
//
//  Created by Y8185682 on 01/01/2016.
//  Copyright (c) 2015 Y8185682. All rights reserved.
//


#import "NewInstrument.h"
#import "ViewController2.h"

@implementation NewInstrument

// Produces setter and getter function for controlling properties 
//@synthesize osc;
@synthesize mandolin, amp, detune;
- (instancetype)init
{
    // Firstly, we must call the intialisation code for the inherited class (AKInstrument)
    // This starts the Orchestra (which only ever happens once) but also sets up the low-level features of the AKInstrument object
    self = [super init]; 
    if (self) {
        
        // Instrument Note Definition
        NewInstrumentNote *note = [[NewInstrumentNote alloc] init];
        
        // Instrument Definition
        mandolin = [AKMandolin mandolin];
     

        //Send parameter to mandolin
         mandolin.bodySize = akp(0.5);
         mandolin.frequency = note.frequency;

         //mandolin.amplitude = akp(0.5); This is now controlled elsewhere
        
        
        amp  = [self createPropertyWithValue:0.5 minimum:0  maximum:1];
        detune  = [self createPropertyWithValue:0.5 minimum:0  maximum:1];
        
        mandolin.amplitude = amp;
        mandolin.pairedStringDetuning = detune;
        
        // Output source of the instrument
        [self setAudioOutput:mandolin];

    }
    return self;
}

-(void)getAmplitude{
    NSLog(@"Get Amplitude Called!");
}

//- (IBAction)myUnwindAction:(UIStoryboardSegue*)unwindSegue{
//    //Set volume here
//    //ViewController2 *view = [segue sourceViewController];
//    
//    NSLog(@"Unwindedededed"); //Debugging
//    
//    if ([unwindSegue.identifier isEqualToString:@"saved"]) {
//        ViewController2 *view2 = (ViewController2 *)unwindSegue.sourceViewController;
//        NSLog(@"Violets are %f", view2.sliderValue);
//        
//        //Retrieve the slider value
//        amp = view2.sliderValue;
//        
//        NSLog(@"Amplitude %f", amp);
//        
//        //amplitude = newInstrument.amp;
//    }
//}

@end

@implementation NewInstrumentNote

@synthesize frequency;

- (instancetype)init {
    self = [super init];
    if (self) {
        
        frequency = [self createPropertyWithValue:440 minimum:20 maximum:20000];
        
        self.duration.value = 2; // Useful for testing polyphony in the simulator - not required if a keyReleased method is used
        
    }
    return self;
}

@end

