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
#import "strumView.h"


@interface ViewController()

//Declare Swiping methods (NOT USED)
-(void)slideDownFirstStringWithGestureRecognizer:(UISwipeGestureRecognizer *)gestureRecognizer;
-(void)slideUpFirstStringWithGestureRecognizer:(UISwipeGestureRecognizer *)gestureRecognizer;
-(void)touchCoodrinates;

@property (strong, nonatomic) IBOutlet UIView *firstStringView;
@property (strong, nonatomic) IBOutlet UIView *secondStringView;

@end

//NSMutableArray *optionsArray;

@implementation ViewController
{
    NewInstrument *newInstrument; // The AKInstrument subclass declaration
    NewInstrumentNote *note; // This is the AKNote subclass declaration
    
    //Create array for notes and currently played notes
    NSArray *frequencies;
    NSMutableDictionary *currentNotes;
//    NSMutableArray *optionsArray;
    float optionsArray[3];
    
    //CGPoint for tracking finger movement
    //CGPoint *strumCood;
    
    //Create outlets for swip gesture recognisers (THESE ARE NOT USED BECAUSE UIIMAGEVIEW IS SHIT)
    IBOutlet UIImageView *firstString;
    IBOutlet UIImageView *secondString;
    IBOutlet UIImageView *thirdString;
    IBOutlet UIImageView *fourthString;
    
}

@synthesize amplitude, strumCood, tapModeValue,sustainModeValue, firstLoad;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //Load all the frequency values into a dictionary
    frequencies = @[@622.3,	@659.3,	@698.5,	@740.0,	@784.0,	@830.6,	@880.0, @932.3,	@987.8, @1047,	@1109,	@1175,	@1245,	@1319,	@1397, @1480,	@1568,	@1661,	@1760,	@1865,	@1976,
                    @2093,	@2217,	@2349,	@2489,	@2637,	@2794, @2960];
    
    currentNotes = [NSMutableDictionary dictionary];
    
    //Allocate memory for the AKInstrument subclass and run its 'init' method.
    newInstrument = [[NewInstrument alloc] init];    
    
    //Add the declared AudioKit instrument(s) to the AKOrchestra
    [AKOrchestra addInstrument:newInstrument];
    
    [self.firstStringView addObserver:self  forKeyPath:@"fingerPosition" options:NSKeyValueObservingOptionNew context:Nil];
    
    //TapMode is the default setting when opening the app
    tapModeValue = 1;
    sustainModeValue = 1;
  
}



- (void)touchCoodrinates:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"HELLOOOO");
    UITouch *touch = [touches anyObject];
    CGPoint pointToMove = [touch locationInView:self.view];
    
    
    NSLog(@"X: %f Y: %f",pointToMove.x, pointToMove.y);
}


- (IBAction)keyPressed:(id)sender {
    if(tapModeValue == TRUE){ //Play when frets are tapped
    NSInteger tag = [(UIButton *)sender tag]; //Receive tag
    [self playNote:tag]; //Play appropriate note
    } else{
        
    }
}

/***********************playNote Method***********************/
-(void)playNote:(int)tagNumber{ //Method for playing a specific note
    //Initialise note object
    note = [[NewInstrumentNote alloc]init];
    
    //Set the frequency to the note
    note.frequency.value = [[frequencies objectAtIndex:tagNumber] floatValue];
    
    // Play the note
    [newInstrument playNote:note];
    
    // Save the note object to an array
    [currentNotes setObject:note forKey:[NSNumber numberWithInt:(int)tagNumber]];
}
/***********************playNote Method***********************/


- (IBAction)keyReleased:(id)sender {
    
    NSInteger tag = [(UIButton *)sender tag]; //Receive tag
    
//    if(sustainModeValue == TRUE){
//        // Recieve the tag of the button pressed
//        NSInteger tag = [(UIButton *)sender tag];
//    
        // Get the key note instance from the tag property
        NewInstrumentNote *noteToRelease = [currentNotes objectForKey:[NSNumber numberWithInt:(int)tag]];
        noteToRelease = [[NewInstrumentNote alloc]init];
    
        // Stop the note
//        [newInstrument stopNote:noteToRelease];
                [newInstrument stopNote:noteToRelease];
    // Remove the note from the array
     [currentNotes removeObjectForKey:[NSNumber numberWithInt:(int)tag]];
//
//   } else {
//        //Do nothing
//   }
    
    
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


/***********************Unwind Segue***********************/
- (IBAction)myUnwindAction:(UIStoryboardSegue*)unwindSegue{
    
    //Check that the correct segue has occured
    if ([unwindSegue.identifier isEqualToString:@"saved"]) {
        ViewController2 *view2 = (ViewController2 *)unwindSegue.sourceViewController;

    //Set parameters with sliders from ViewController2 (options screen)
    [newInstrument.amp setValue:view2.volumeSliderValue];
    [newInstrument.detune setValue:view2.detuneSliderValue];
    [newInstrument.bodySize setValue:view2.bodySizeSliderValue];

    tapModeValue = view2.tapModeInt;
    sustainModeValue = view2.sustainModeInt;
        
    optionsArray[0] = view2.volumeSliderValue;
    optionsArray[1] = view2.detuneSliderValue;
    optionsArray[2] = view2.bodySizeSliderValue;
    
    NSLog(@"actualy value: %f [unwind array] %f",view2.volumeSliderValue,optionsArray[0]);
    NSLog(@"Array Vale: %f", optionsArray[0]);
    
    firstLoad = 1;
    
    }
}
/***********************Unwind Segue***********************/



- (IBAction)openOptions:(UIButton *)sender {
   // NSMutableArray *optionsArray = [[NSMutableArray alloc]init];
//    [self performSegueWithIdentifier:@"options" sender:optionsArray];
}



/***********************Prepare For Segue***********************/
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"options"])
    {
        // Get reference to the destination view controller
       // ViewController2 *vc2 = (ViewController2 *) segue.destinationViewController;
        
        ViewController2 *vc2 =[segue destinationViewController];
        
        //Send the previously saved options values back to viewController2
        vc2.volumeSliderValueReceive = optionsArray[0];
        vc2.detuneSliderValueReceive = optionsArray[1];
        vc2.bodySizeSliderValueReceive = optionsArray[2];
        vc2.tapModeInt = tapModeValue;
        vc2.sustainModeInt = sustainModeValue;
        vc2.firstLoadReceive = firstLoad;
        
        NSLog(@"[prepare array] %f", optionsArray[0]);
    }
}
/***********************Prepare For Segue***********************/


/***********************Touch Regions Methods***********************/
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if ([keyPath isEqualToString:@"fingerPosition"]) { //Using Key-Value Coding
     float stringSelector = [[change objectForKey:@"new"] floatValue]; //Coordinate region detection value from strumView.m
        if (tapModeValue == true) { //Is tapMode is on play strum open notes only
            if (object == self.firstStringView) {
                if(stringSelector == 1){ //If finger is in the firstString area
                    [self playNote:1];
                } else if(stringSelector == 2){
                    [self playNote:8];
                } else if (stringSelector == 3){
                    [self playNote:15];
                } else if(stringSelector == 4){
                    [self playNote:22];
                }
            }
        } else if (tapModeValue == false){ //If tapMode is off strum note according to fret position
            if (object == self.firstStringView) {
             //Project   NSInteger tag = [(UIButton *)sender tag]; //Receive tag
                if(stringSelector == 1){ //If finger is in the firstString area
                    [self playNote:1];
                } else if(stringSelector == 2){
                    [self playNote:8];
                } else if (stringSelector == 3){
                    [self playNote:15];
                } else if(stringSelector == 4){
                    [self playNote:22];
                }
            }
        }
    } else {
        [NSException raise:@"Unexpected Keypath" format:@"%@", keyPath];
    }
    
}
/***********************Touch Regions Methods***********************/


 /***********************Debug Methods***********************/
- (IBAction)makeSound:(id)sender {
    NSLog(@"ERRRROWWOWOWOWOWOWOWOW");
}
-(void)slideDownFirstStringWithGestureRecognizer:(UISwipeGestureRecognizer *)gestureRecognizer{
    NSLog(@"ERRROOOOOOW");
}
 /***********************Debug Methods***********************/







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
