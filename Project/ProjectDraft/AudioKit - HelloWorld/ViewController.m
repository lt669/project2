//
//  ViewController.m
//  AudioKit - HelloWorld
//
//  Created by Y8185682 on 01/01/2016.
//  Copyright (c) 2015 Y8185682. All rights reserved.
//
//  ------------------------------------------------------------------------
//  Description:
//  This class control everything that is presented to the user on the storyboard file. It also uses AudioKit to generate an audible tone
//
//  ------------------------------------------------------------------------

#import "ViewController.h"

@interface ViewController()
//@property (nonatomic) CGPoint coordinates;

@end

@implementation ViewController
{
    NewInstrument *newInstrument; // The AKInstrument subclass declaration
    //float amplitude; //******Does this have to be in .h and  ?*****
    
    NewInstrumentNote *note; // This is the AKNote subclass declaration
    
    
    //Create array for notes and currently played notes
    NSArray *frequencies;
    NSMutableDictionary *currentNotes;
}

@synthesize amplitude;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //Load all the frequency values into a dictionary
    frequencies = @[@622.3,	@659.3,	@698.5,	@740.0,	@784.0,	@830.6,	@880.0, @932.3,	@987.8, @1047,	@1109,	@1175,	@1245,	@1319,	@1397, @1480,	@1568,	@1661,	@1760,	@1865,	@1976,
                    @2093,	@2217,	@2349,	@2489,	@2637,	@2794, @2960];
    
    currentNotes = [NSMutableDictionary dictionary];
    
    //Allocate memory for the AKInstrument subclass and run its 'init' method.
    newInstrument = [[NewInstrument alloc] init];
    
    //Add the declared AudioKit instrument(s) to the AKOrchestra
    [AKOrchestra addInstrument:newInstrument];
    
    //Connect the UISliders to the AKInstrumentProperty objects
    //amplitude = newInstrument.amp;

}

- (IBAction)myUnwindAction:(UIStoryboardSegue*)unwindSegue{
    //Set volume here
    //ViewController2 *view = [segue sourceViewController];
    
    NSLog(@"Unwindedededed"); // (DEBUGGING)
    
    if ([unwindSegue.identifier isEqualToString:@"saved"]) { //Check that the correct segue has occured
        ViewController2 *view2 = (ViewController2 *)unwindSegue.sourceViewController;
        
        //Retrieve the slider value
        amplitude = view2.sliderValue;

        [newInstrument.amp setValue:amplitude];
        
        /*********************TESTING*********************/
        NSLog(@"view2.sliderValue: %f", view2.sliderValue); //Check they are the same value (DEBUGGING)
        NSLog(@"Amplitude: %f", amplitude);
        [newInstrument getAmplitude];
        /*********************TESTING*********************/
        
//        newInstrument.amp = view2.sliderValue;
         //amplitude = newInstrument.amp;
    }
}





//-(void)setAmp:(int)amplitude
//{
//    _amplitude = amplitude;
//    self.view.amplitude = amplitude;
//}

//Add methods for UIGestures
//
//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//        
//        UITouch *touch = [touches anyObject];
//        [self.view setUserInteractionEnabled:NO];
//      //  self.firstPoint = [touch locationInView:self.view];
//
//        
//
//}
//
//
//- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
//    
//    
//    //  [self.swipeTimer invalidate];
//    
//    //  NSLog(@"the timer stops at %f seconds", swipeTime);
//    
//    UITouch *touch = [touches anyObject];
//    //self.lastPoint = [touch locationInView:self.view];
//    
// //   CGPoint tapVector = rwSub(self.lastPoint, self.firstPoint); // (vector) last point - first point
//
//    
//}


- (IBAction)keyPressed:(id)sender {
    //Receive tag
    NSInteger tag = [(UIButton *)sender tag];
    
    //Initialise note object
    note = [[NewInstrumentNote alloc]init];
    
    //Set the frequency to the note
    note.frequency.value = [[frequencies objectAtIndex:tag] floatValue];

    // Play the note
    [newInstrument playNote:note];
    
    // Save the note object to an array
    [currentNotes setObject:note forKey:[NSNumber numberWithInt:(int)tag]];
}


- (IBAction)keyReleased:(id)sender {
    
    //    // Recieve the tag of the button pressed
    //    NSInteger tag = [(UIButton *)sender tag];
    //
    //    // Get the key note instance from the tag property
    //    FMInstrumentNote *noteToRelease = [currentNotes objectForKey:[NSNumber numberWithInt:(int)tag]];
    //
    //    // Stop the note
    //    [fmInstrument stopNote:noteToRelease];
    //
    //    // Remove the note from the array
    //    [currentNotes removeObjectForKey:[NSNumber numberWithInt:(int)tag]];
}

//- (IBAction)toggleSound:(UIButton *)sender {
//    if (![sender.titleLabel.text isEqual: @"Stop"]) {
//        // Play the instrument
//        [newInstrument play];
//        // Change the text of the UIButton
//        [sender setTitle:@"Stop" forState:UIControlStateNormal];
//    } else {
//        // Stop the instrument
//        [newInstrument stop];
//        // Change the text of the UIButton
//        [sender setTitle:@"Play Sine Wave at 440Hz" forState:UIControlStateNormal];
//    }
//}

@end
