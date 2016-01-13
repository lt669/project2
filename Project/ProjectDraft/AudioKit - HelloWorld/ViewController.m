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

//All buttons to set visible or invisible
@property (strong, nonatomic) IBOutlet UIButton *G;
@property (strong, nonatomic) IBOutlet UIButton *G_;
@property (strong, nonatomic) IBOutlet UIButton *A;
@property (strong, nonatomic) IBOutlet UIButton *Bb;
@property (strong, nonatomic) IBOutlet UIButton *B;
@property (strong, nonatomic) IBOutlet UIButton *C;
@property (strong, nonatomic) IBOutlet UIButton *C_;
@property (strong, nonatomic) IBOutlet UIButton *D;
@property (strong, nonatomic) IBOutlet UIButton *D_;
@property (strong, nonatomic) IBOutlet UIButton *E;
@property (strong, nonatomic) IBOutlet UIButton *F;
@property (strong, nonatomic) IBOutlet UIButton *F_;
@property (strong, nonatomic) IBOutlet UIButton *G_2;
@property (strong, nonatomic) IBOutlet UIButton *G2;
@property (strong, nonatomic) IBOutlet UIButton *A2;
@property (strong, nonatomic) IBOutlet UIButton *Bb2;
@property (strong, nonatomic) IBOutlet UIButton *B2;
@property (strong, nonatomic) IBOutlet UIButton *C2;
@property (strong, nonatomic) IBOutlet UIButton *C_2;
@property (strong, nonatomic) IBOutlet UIButton *D2;
@property (strong, nonatomic) IBOutlet UIButton *D_2;
@property (strong, nonatomic) IBOutlet UIButton *E2;
@property (strong, nonatomic) IBOutlet UIButton *F2;
@property (strong, nonatomic) IBOutlet UIButton *F_2;
@property (strong, nonatomic) IBOutlet UIButton *G3;
@property (strong, nonatomic) IBOutlet UIButton *G_3;
@property (strong, nonatomic) IBOutlet UIButton *A3;
@property (strong, nonatomic) IBOutlet UIButton *Bb3;



@end

//NSMutableArray *optionsArray;

@implementation ViewController
{
    IBOutlet UIButton *options;
    NewInstrument *newInstrument; // The AKInstrument subclass declaration
    NewInstrumentNote *note; // This is the AKNote subclass declaration
    
    //Create array for notes and currently played notes
    NSArray *frequencies;
    NSMutableDictionary *currentNotes;
    float optionsArray[3];
    float fretArray[28];
}

@synthesize amplitude, strumCood, tapModeValue, sustainModeValue,showNotesValue, firstLoad;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //Load all the frequency values into a dictionary
    frequencies = @[@622.3,	@659.3,	@698.5,	@740.0,	@784.0,	@830.6,	@880.0, @932.3,	@987.8, @1047,	@1109,	@1175,	@1245,	@1319,	@1397, @1480,	@1568,	@1661,	@1760,	@1865,	@1976,
                    @2093,	@2217,	@2349,	@2489,	@2637,	@2794, @2960];
    
    currentNotes = [NSMutableDictionary dictionary];
    
    for (int i = 0;i<28; i++) { //Load array with values
        fretArray[i] = 0;
    }
    
    //Allocate memory for the AKInstrument subclass and run its 'init' method.
    newInstrument = [[NewInstrument alloc] init];    
    
    //Add the declared AudioKit instrument(s) to the AKOrchestra
    [AKOrchestra addInstrument:newInstrument];
    
    [self.firstStringView addObserver:self  forKeyPath:@"fingerPosition" options:NSKeyValueObservingOptionNew context:Nil];
    
    //Default witch settings when opening the app
    tapModeValue = 1;
    sustainModeValue = 1;
    [self showNotesSettings:0];
    
    //Options button rounder
        options.layer.cornerRadius = 8;
}


- (IBAction)keyPressed:(id)sender {
    NSInteger tag = [(UIButton *)sender tag]; //Receive tag
    if(tapModeValue == TRUE){ //Play when frets are tapped
       [self playNote:tag]; //Play appropriate note
    } else{
        fretArray[tag - 1] = 1; //Set the currently pressed fret to 1
    }
}

- (IBAction)keyReleased:(id)sender {
    
    NSInteger tag = [(UIButton *)sender tag];
    fretArray[tag - 1] = 0;
    
    if(sustainModeValue == FALSE){
        // Get the key note instance from the tag property
        NewInstrumentNote *noteToRelease = [currentNotes objectForKey:[NSNumber numberWithInt:(int)tag]];
        noteToRelease = [[NewInstrumentNote alloc]init];
        
        // Stop the note
        [newInstrument stopNote:[currentNotes objectForKey:[NSNumber numberWithInt:(int)tag]]];
        
        // Remove the note from the array
        [currentNotes removeObjectForKey:[NSNumber numberWithInt:(int)tag]];
    } else {
        //Do nothing
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
    showNotesValue = view2.showNotesInt;
        
    optionsArray[0] = view2.volumeSliderValue;
    optionsArray[1] = view2.detuneSliderValue;
    optionsArray[2] = view2.bodySizeSliderValue;
    
    firstLoad = 1;
    [self showNotesSettings:showNotesValue];
        
    }
}

-(void)showNotesSettings:(int)value{
    //Set buttons to hide or show
    if(value == 0){
        _G.hidden = YES;
        _G_.hidden = YES;
        _A.hidden = YES;
        _B.hidden = YES;
        _Bb.hidden = YES;
        _C.hidden = YES;
        _C_.hidden = YES;
        _D.hidden = YES;
        _D_.hidden = YES;
        _E.hidden = YES;
        _F.hidden = YES;
        _F_.hidden = YES;
        _G2.hidden = YES;
        _G.hidden = YES;
        _G_2.hidden = YES;
        _A2.hidden = YES;
        _Bb2.hidden = YES;
        _B2.hidden = YES;
        _C2.hidden = YES;
        _C_2.hidden = YES;
        _D2.hidden = YES;
        _D_2.hidden = YES;
        _E2.hidden = YES;
        _F2.hidden = YES;
        _F_2.hidden = YES;
        _G3.hidden = YES;
        _G_3.hidden = YES;
        _A3.hidden = YES;
        _Bb3.hidden = YES;
    } else {
        _G.hidden = NO;
        _G_.hidden = NO;
        _A.hidden = NO;
        _B.hidden = NO;
        _Bb.hidden = NO;
        _C.hidden = NO;
        _C_.hidden = NO;
        _D.hidden = NO;
        _D_.hidden = NO;
        _E.hidden = NO;
        _F.hidden = NO;
        _F_.hidden = NO;
        _G2.hidden = NO;
        _G.hidden = NO;
        _G_2.hidden = NO;
        _A2.hidden = NO;
        _Bb2.hidden = NO;
        _B2.hidden = NO;
        _C2.hidden = NO;
        _C_2.hidden = NO;
        _D2.hidden = NO;
        _D_2.hidden = NO;
        _E2.hidden = NO;
        _F2.hidden = NO;
        _F_2.hidden = NO;
        _G3.hidden = NO;
        _G_3.hidden = NO;
        _A3.hidden = NO;
        _Bb3.hidden = NO;
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
        vc2.showNotesInt = showNotesValue;
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
                if(stringSelector == 1)
                    if (fretArray[0] == 1){
                        [self playNote:2];
                    } else if ( fretArray[1] == 1){
                        [self playNote:3];
                    } else if(fretArray[2] == 1){
                        [self playNote:4];
                    } else if(fretArray[3] == 1){
                        [self playNote:5];
                    } else if(fretArray[4] == 1){
                        [self playNote:6];
                    } else if(fretArray[5] == 1){ //If finger is in the firstString area
                        [self playNote:7];
                    } else {
                        [self playNote:1]; //Play open string
                    }
                } else if(stringSelector == 2){
                    if (fretArray[6] == 1){
                        [self playNote:9];
                    } else if ( fretArray[7] == 1){
                        [self playNote:10];
                    } else if(fretArray[8] == 1){
                        [self playNote:11];
                    } else if(fretArray[9] == 1){
                        [self playNote:12];
                    } else if(fretArray[10] == 1){
                        [self playNote:13];
                    } else if(fretArray[11] == 1){ //If finger is in the firstString area
                        [self playNote:14];
                    } else {
                        [self playNote:8]; //Play open string
                    }
                } else if (stringSelector == 3){
                    [self playNote:15];
                } else if(stringSelector == 4){
                    [self playNote:22];
                }
        }
    } else {
        [NSException raise:@"Unexpected Keypath" format:@"%@", keyPath];
    }
    
}
/***********************Touch Regions Methods***********************/


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
