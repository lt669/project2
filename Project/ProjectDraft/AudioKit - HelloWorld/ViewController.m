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

#define NSLog(FORMAT, ...) printf("%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);

@interface ViewController()
//@property (nonatomic) CGPoint coordinates;

//Declare Swiping methods (NOT USED)
-(void)slideDownFirstStringWithGestureRecognizer:(UISwipeGestureRecognizer *)gestureRecognizer;
-(void)slideUpFirstStringWithGestureRecognizer:(UISwipeGestureRecognizer *)gestureRecognizer;
-(void)touchCoodrinates;


@property (strong, nonatomic) IBOutlet UIView *firstStringView;
@property (strong, nonatomic) IBOutlet UIView *secondStringView;

@end

@implementation ViewController
{
    NewInstrument *newInstrument; // The AKInstrument subclass declaration
    NewInstrumentNote *note; // This is the AKNote subclass declaration
    
    //Create array for notes and currently played notes
    NSArray *frequencies;
    NSMutableDictionary *currentNotes;
    
    //CGPoint for tracking finger movement
    //CGPoint *strumCood;
    
    //Create outlets for swip gesture recognisers (THESE ARE NOT USED BECAUSE UIIMAGEVIEW IS SHIT)
    IBOutlet UIImageView *firstString;
    IBOutlet UIImageView *secondString;
    IBOutlet UIImageView *thirdString;
    IBOutlet UIImageView *fourthString;
    
}

@synthesize amplitude, strumCood;
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
    
    [self.firstStringView addObserver:self  forKeyPath:@"fingerPosition" options:NSKeyValueObservingOptionNew context:Nil];
    
  
    
    /***********************SWIPES DON'T WORK***********************/
    //Set up swipe gestures
    
    //First String
//    UISwipeGestureRecognizer *swipeDownFirstString = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(slideDownFirstStringWithGestureRecognizer:)];
//    swipeDownFirstString.direction = UISwipeGestureRecognizerDirectionDown;
//    
//    UISwipeGestureRecognizer *swipeUpFirstString = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(slideUpFirstStringWithGestureRecognizer:)];
//    swipeUpFirstString.direction = UISwipeGestureRecognizerDirectionUp;
//    
//    
//    [self.firstString addGestureRecognizer:swipeDownFirstString];
//    [self.firstString addGestureRecognizer:swipeUpFirstString];
    /***********************SWIPES DON'T WORK***********************/
}



- (void)touchCoodrinates:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"HELLOOOO");
    UITouch *touch = [touches anyObject];
    CGPoint pointToMove = [touch locationInView:self.view];
    
    
    NSLog(@"X: %f Y: %f",pointToMove.x, pointToMove.y);
}


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


/***********************Unwind Segue***********************/
- (IBAction)myUnwindAction:(UIStoryboardSegue*)unwindSegue{
    //Set volume here
    //ViewController2 *view = [segue sourceViewController];
    
    NSLog(@"Unwindedededed"); // (DEBUGGING)
    
    if ([unwindSegue.identifier isEqualToString:@"saved"]) { //Check that the correct segue has occured
        ViewController2 *view2 = (ViewController2 *)unwindSegue.sourceViewController;
        
        //Retrieve the slider value
        //amplitude = view2.sliderValue;
        
        [newInstrument.amp setValue:view2.volumeSliderValue]; //Set amplitude with volume slider
        [newInstrument.detune setValue:view2.detuneSliderValue];
//        /*********************TESTING*********************/
//        NSLog(@"view2.sliderValue: %f", view2.volumeSliderValue); //Check they are the same value (DEBUGGING)
//        NSLog(@"Amplitude: %f", amplitude);
//        [newInstrument getAmplitude];
        /*********************TESTING*********************/
        
        //        newInstrument.amp = view2.sliderValue;
        //amplitude = newInstrument.amp;
    }
}
/***********************Unwind Segue***********************/


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

/***********************Touch Regions Methods***********************/
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if ([keyPath isEqualToString:@"fingerPosition"]) { //Using Key-Value Coding
     float stringSelector = [[change objectForKey:@"new"] floatValue]; //Coordinate region detection value from strumView.m
        if (object == self.firstStringView) {
            if(stringSelector == 1){
                [self playNote:1];
            } else if(stringSelector == 2){
                [self playNote:8];
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
