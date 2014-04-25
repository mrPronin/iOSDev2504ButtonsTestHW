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

- (void) numberKeyPressedWithNumber:(NSUInteger) num andSender:(RITCalcButton *)sender {
    
    NSString *currentDisplayString = self.displayLabel.text;
    
    if ([currentDisplayString length] <= RITmaxDisplaySign) {
        
        NSString *displayString = [NSString stringWithFormat:@"%@%d", (currentDisplayString)?currentDisplayString:@"", num];
        self.displayLabel.text = displayString;
        
        self.firstValue = displayString.floatValue;
        
        NSLog(@"First value: %.2f", self.firstValue);
    }
    
    [self performStandardAnimationWithSender:sender];
}

- (void) resetDisplayWithSender:(RITCalcButton *)sender {
    
    self.displayLabel.text = nil;
    
    [self performStandardAnimationWithSender:sender];
}

- (void) backspaceDisplayWithSender:(RITCalcButton *)sender {
    
    NSString *currentDisplayString = self.displayLabel.text;
    if (currentDisplayString) {
        NSString *displayString = [currentDisplayString substringToIndex:[currentDisplayString length] - 1];
        self.displayLabel.text = displayString;
    }
    
    [self performStandardAnimationWithSender:sender];
}

- (void) setOperation:(RITCalcBtns) operation withSender:(RITCalcButton *)sender {
    
    [self resetSelectionForOperations];
    
    [self setSelectionForOperation:sender];
}

- (void) performStandardAnimationWithSender:(RITCalcButton *)sender {
    
    [UIView animateWithDuration:0.1f animations:^{
        sender.transform = CGAffineTransformMakeScale(1.1f, 1.1f);
    }];
    
    [UIView animateWithDuration:0.1f animations:^{
        sender.transform = CGAffineTransformIdentity;
    }];
}

- (void) setSelectionForOperation:(RITCalcButton *)sender {
    
    [sender setSelected:YES];
    
    [UIView animateWithDuration:0.1f animations:^{
        sender.transform = CGAffineTransformMakeScale(1.1f, 1.1f);
    }];
    
    [UIView animateWithDuration:0.1f animations:^{
        sender.transform = CGAffineTransformIdentity;
        sender.backgroundColor = [UIColor colorWithRed:0.9922f green:0.6314f blue:0.4157f alpha:1.f];
    }];
}

- (void) resetSelectionForOperations {
    
    for (RITCalcButton *btn in self.operationButtons) {
        if (btn.isSelected) {
            
            [btn setSelected:NO];
            
            [UIView animateWithDuration:0 animations:^{
                btn.transform = CGAffineTransformIdentity;
                // !!! set background
            }];
        }
    }
}

#pragma mark - Actions

- (IBAction)actionAnyCalcButtonTouchUpInside:(RITCalcButton *)sender {
    
    [self.view bringSubviewToFront:sender];
    
    if (sender.tag < 10) {
        [self numberKeyPressedWithNumber:sender.tag andSender:sender];
    } else {
        switch (sender.tag) {
            case RITCalcBtnsReset:
                [self resetDisplayWithSender:sender];
                break;
                
            case RITCalcBtnsBackspace:
                [self backspaceDisplayWithSender:sender];
                break;
                
            case RITCalcBtnsDivide:
            case RITCalcBtnsMultiply:
            case RITCalcBtnsSubstract:
            case RITCalcBtnsAppend:
                [self setOperation:sender.tag withSender:sender];
                break;
                
            default:
                break;
        }
    }
    
    
    
}

@end
