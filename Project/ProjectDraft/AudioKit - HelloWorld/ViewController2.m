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
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)saved:(UIButton *)sender {
    self.sliderValue = volume.value; //
}

////seding data from here to ViewController (main page)
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    if ([segue.identifier isEqualToString:[@"saved"]){
//        
//        ViewController *view = (ViewController *) segue.destinationViewController;
//        view.volume = self.sliderValue; //Send the value of the slider to the amplitude of the Mandolin
//    }
//}



@end