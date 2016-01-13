//
//  NewInstrument.h
//  AudioKit - HelloWorld
//
//  Created by Y8185682 on 01/01/2016.
//  Copyright (c) 2015 Y8185682. All rights reserved.
//


#import "NewInstrument.h"
#import "ViewController2.h"
#import "EffectsProcessor.h"

@implementation NewInstrument
{
    EffectsProcessor *fx;
}


@synthesize mandolin, amp, detune, bodySize;
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
      //   mandolin.flanger = akp(0.5);

         //mandolin.amplitude = akp(0.5); This is now controlled elsewhere
        
        
        amp  = [self createPropertyWithValue:0.5 minimum:0  maximum:1];
        detune  = [self createPropertyWithValue:0.5 minimum:0.01  maximum:1];
        bodySize  = [self createPropertyWithValue:0.5 minimum:0  maximum:0.9];
        
        mandolin.amplitude = amp;
        mandolin.pairedStringDetuning = detune;
        mandolin.bodySize = bodySize;
        
        
       // _auxilliaryOutput = [AKAudio globalParameter];
       // [self assignOutput:_auxilliaryOutput to:mandolin];
        
       // fx = [[EffectsProcessor alloc] initWithAudioSource:mandolin.auxilliaryOutput];
        [AKOrchestra addInstrument:fx];
        
        
        
        [fx play];

        // Output source of the instrument
        [self setAudioOutput:mandolin];

    }
    return self;
}

//- (instancetype)initWithAudioSource:(AKStereoAudio *)audioSource{
//    
//}

- (void)setReverbFeedbackLevel:(float)feedbackLevel
{
    fx.reverb.value = 0.5; /*feedbackLevel;*/
}

-(void)getAmplitude{
    NSLog(@"Get Amplitude Called!");
}

@end

@implementation NewInstrumentNote

@synthesize frequency;

- (instancetype)init {
    self = [super init];
    if (self) {
        
        frequency = [self createPropertyWithValue:440 minimum:20 maximum:20000];
       // self.duration.value = 2; // Useful for testing polyphony in the simulator - not required if a keyReleased method is used
        
    }
    return self;
}

@end

