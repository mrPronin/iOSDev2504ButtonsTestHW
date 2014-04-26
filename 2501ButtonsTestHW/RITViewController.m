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
    
    self.firstValue = 0;
    self.secondValue = 0;
    
    //NSLog(@"Frame: %@, bounds: %@", NSStringFromCGRect(self.view.frame), NSStringFromCGRect(self.view.bounds));
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Helper functions

- (void) numberKeyPressedWithNumber:(NSUInteger) num andSender:(RITCalcButton *)sender {
    
    RITCalcButton *selectedOperation = [self selectedOperation];
    
    NSString *currentDisplayString = nil;
    if ((self.secondValue == 0) && (selectedOperation)) {
        // first number input after the operation is selected
        // need to reset the current display string
        currentDisplayString = @"";
    } else {
        currentDisplayString = self.displayLabel.text;
    }
    
    if ([currentDisplayString length] <= RITmaxDisplaySign) {
        
        NSString *displayString = [NSString stringWithFormat:@"%@%d", (currentDisplayString)?currentDisplayString:@"", num];
        self.displayLabel.text = displayString;
        
        if (!selectedOperation) {
            self.firstValue = displayString.doubleValue;
        } else {
            self.secondValue = displayString.doubleValue;
        }
        
        NSLog(@"Value: %f", displayString.doubleValue);
    }
    
    [self performStandardAnimation:sender];
}

- (void) resetDisplay:(RITCalcButton *)sender {
    
    self.displayLabel.text = nil;
    self.firstValue = 0;
    self.secondValue = 0;
    
    [self resetSelectionForOperations];
    
    [self performStandardAnimation:sender];
}

- (void) backspaceDisplay:(RITCalcButton *)sender {
    
    RITCalcButton *selectedOperation = [self selectedOperation];
    
    NSString *currentDisplayString = self.displayLabel.text;
    if ((currentDisplayString) && ([currentDisplayString length] > 0)) {
        NSString *displayString = [currentDisplayString substringToIndex:[currentDisplayString length] - 1];
        self.displayLabel.text = displayString;
        
        if (!selectedOperation) {
            self.firstValue = displayString.doubleValue;
        } else {
            self.secondValue = displayString.doubleValue;
        }
        
        NSLog(@"Value: %f", displayString.doubleValue);
    }
    
    [self performStandardAnimation:sender];
}

- (void) setOperation:(RITCalcButton *)sender {
    
    [self resetSelectionForOperations];
    
    [self setSelectionForOperation:sender];
}

- (void) performStandardAnimation:(RITCalcButton *)sender {
    
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
        sender.backgroundColor = [RITCalcButton selectedOperationColor];
    }];
}

- (void) resetSelectionForOperations {
    
    for (RITCalcButton *btn in self.operationButtons) {
        if (btn.isSelected) {
            
            [btn setSelected:NO];
            btn.backgroundColor = [RITCalcButton normalOperationColor];
        }
    }
}

- (RITCalcButton*) selectedOperation {
    RITCalcButton *selected = nil;
    
    for (RITCalcButton *btn in self.operationButtons) {
        if (btn.isSelected) {
            
            selected = btn;
            break;
        }
    }
    return selected;
}

- (void) invertTheValue:(RITCalcButton*) sender {
    
    [self performStandardAnimation:sender];
    
    if (self.firstValue == 0) {
        return;
    }
    
    self.firstValue = self.firstValue * (-1);
    NSString *displayString = [NSString stringWithFormat:@"%.2f", self.firstValue];
    //NSString *displayString = [NSString stringWithFormat:@"%d", (NSInteger)self.firstValue];
    self.displayLabel.text = displayString;
    NSLog(@"Value: %f", self.firstValue);
}

- (void) performOperation:(RITCalcButton*) sender {
    
    RITCalcButton *selectedOperation = [self selectedOperation];
    
    [self resetSelectionForOperations];
    [self performStandardAnimation:sender];
    
    double calculationResult = 0;
    
    if (selectedOperation) {
        switch (selectedOperation.tag) {
            
            case RITCalcBtnsDivide:
                
                if (self.secondValue == 0) {
                    
                    calculationResult = 0;
                } else {
                    
                    calculationResult = self.firstValue / self.secondValue;
                }
                break;
                
            case RITCalcBtnsMultiply:
                calculationResult = self.firstValue * self.secondValue;
                break;
                
            case RITCalcBtnsSubstract:
                calculationResult = self.firstValue - self.secondValue;
                break;
                
            case RITCalcBtnsAppend:
                calculationResult = self.firstValue + self.secondValue;
                break;
        }
        
        self.secondValue = 0;
        self.firstValue = calculationResult;
        NSString *displayString = [NSString stringWithFormat:@"%.2f", self.firstValue];
        //NSString *displayString = [NSString stringWithFormat:@"%lld", (long long)self.firstValue];
        self.displayLabel.text = displayString;
        NSLog(@"Value: %f", self.firstValue);
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
                [self resetDisplay:sender];
                break;
                
            case RITCalcBtnsBackspace:
                [self backspaceDisplay:sender];
                break;
                
            case RITCalcBtnsDivide:
            case RITCalcBtnsMultiply:
            case RITCalcBtnsSubstract:
            case RITCalcBtnsAppend:
                [self setOperation:sender];
                break;
                
            case RITCalcBtnsResult:
                [self performOperation:sender];
                break;
                
            case RITCalcBtnsInvert:
                [self invertTheValue:sender];
                break;
        }
    }
}

@end
