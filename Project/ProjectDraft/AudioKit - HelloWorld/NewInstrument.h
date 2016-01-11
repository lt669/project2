//
//  NewInstrument.h
//  ProjectDraft
//
//  Created by Y8185682 on 01/01/2016.
//  Copyright (c) 2015 Y8185682. All rights reserved.
//

// This import is required for any class that wishes to use AudioKit. AKFoundation.h holds all of the neccesary files to make AudioKit operate
#import "AKFoundation.h"

// The 'AKInstrument' after the colon (below) defines the superclass of this class.
@interface NewInstrument : AKInstrument

// The properties of the instrument are defined here so that they can be accessed after instantiation by the parent class. These properties allow user-defined controls over specific attributes of the sound generation algorithm.
//@property (nonatomic, strong) AKOscillator *osc;
@property (nonatomic, strong) AKMandolin *mandolin;
@property (nonatomic, strong) AKInstrumentProperty *freq;
@property (nonatomic, strong) AKInstrumentProperty *amp;
@property (nonatomic, strong) AKInstrumentProperty *detune;
@property (nonatomic, strong) AKInstrumentProperty *bodySize;

//
//@property (nonatomic, strong) AKFlanger *flanger;
//@property (nonatomic) AKParameter *feedback;
//@property (readonly) AKAudio *auxilliaryOutput;

 -(void)getAmplitude;
- (instancetype)initWithAudioSource:(AKStereoAudio *)audioSource;

- (void)setReverbFeedbackLevel:(float)feedbackLevel; //Reverb feedback

@end

//Add a new interface to this class to hold the superclass of AKNote
@interface NewInstrumentNote : AKNote

//Add properties of the note which act as the variables (paramters) desired of this object
@property AKNoteProperty *frequency;


@end