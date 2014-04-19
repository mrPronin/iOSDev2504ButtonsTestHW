//
//  RITViewController.m
//  2501ButtonsTestHW
//
//  Created by Pronin Alexander on 19.04.14.
//  Copyright (c) 2014 Pronin Alexander. All rights reserved.
//

#import "RITViewController.h"
#import "RITCalcButton.h"

@interface RITViewController ()

@end

@implementation RITViewController

#pragma mark - View Conroller

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (!IS_WIDESCREEN) {
        
        self.displayLabel.center = CGPointMake(self.displayLabel.center.x, self.displayLabel.center.y - 88);
        
        for (UIView *view in self.view.subviews) {
            
            if ([view isKindOfClass:[RITCalcButton class]]) {
                UIButton *btn = (UIButton*)view;
                btn.center = CGPointMake(btn.center.x, btn.center.y - 88);
            }
        }
    }
    
    //NSLog(@"Frame: %@, bounds: %@", NSStringFromCGRect(self.view.frame), NSStringFromCGRect(self.view.bounds));
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Helper functions

- (void) setDisplayWithSender:(RITCalcButton *)sender {
    
    self.displayLabel.text = sender.currentTitle;
}

#pragma mark - Actions

- (IBAction)actionNumberButtonTouchUpInside:(RITCalcButton *)sender {
    
    NSLog(@"Number button pressed: %@", sender.currentTitle);
}

- (IBAction)actionAnyCalcButtonTouchUpInside:(RITCalcButton *)sender {
    
    [self setDisplayWithSender:sender];
    
    [self.view bringSubviewToFront:sender];
    
    [UIView animateWithDuration:0.5f animations:^{
        sender.transform = CGAffineTransformMakeScale(1.1f, 1.1f);
    }];
    
    [UIView animateWithDuration:0.5f animations:^{
        sender.transform = CGAffineTransformIdentity;
    }];
    
}

- (IBAction)actionOperationButtonTouchUpInside:(RITCalcButton *)sender {
    
    NSLog(@"Operation button pressed: %@", sender.currentTitle);
}

@end
