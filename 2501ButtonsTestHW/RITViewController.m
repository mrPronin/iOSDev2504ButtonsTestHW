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
    self.displayLabel.text = @"0";
    self.isSecondValueInput = NO;
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
    if ((!self.isSecondValueInput) && (selectedOperation)) {
        // first number input after the operation is selected
        // need to reset the current display string
        currentDisplayString = @"0";
        self.isSecondValueInput = YES;
    } else {
        currentDisplayString = self.displayLabel.text;
    }
    
    if ([currentDisplayString length] <= RITmaxDisplaySign) {
        
        NSString *displayString = nil;
        if ([currentDisplayString isEqualToString:@"0"] && (num < RITCalcBtnsDDecimalPoint)) {
            // zero value must be replaced with input number value
            displayString = [NSString stringWithFormat:@"%d", num];
        } else if (num == RITCalcBtnsDDecimalPoint) {
            // only one decimal point may be in result value
            NSRange range = [currentDisplayString rangeOfString:@"."];
            if (range.location == NSNotFound) {
                displayString = [NSString stringWithFormat:@"%@%@", currentDisplayString, @"."];
            } else {
                return;
            }
        } else {
            displayString = [NSString stringWithFormat:@"%@%d", currentDisplayString, num];
        }
        
        self.displayLabel.text = displayString;
        
        if (!self.isSecondValueInput) {
            self.firstValue = displayString.doubleValue;
        } else {
            self.secondValue = displayString.doubleValue;
        }
        
        NSLog(@"Value: %@", displayString);
    }
    [self performStandardAnimation:sender];
}

- (void) resetDisplay:(RITCalcButton *)sender {
    
    self.displayLabel.text = @"0";
    self.firstValue = 0;
    self.secondValue = 0;
    self.isSecondValueInput = NO;
    [self resetSelectionForOperations];
    [self performStandardAnimation:sender];
}

- (void) backspaceDisplay:(RITCalcButton *)sender {
    
    NSString *currentDisplayString = self.displayLabel.text;
    if ((currentDisplayString) && ([currentDisplayString length] > 0)) {
        
        NSString *displayString = nil;
        if ([currentDisplayString length] == 1) {
            displayString = @"0";
        } else {
            
            displayString = [currentDisplayString substringToIndex:[currentDisplayString length] - 1];
        }
        self.displayLabel.text = displayString;
        
        if (!self.isSecondValueInput) {
            self.firstValue = displayString.doubleValue;
        } else {
            self.secondValue = displayString.doubleValue;
        }
        //NSLog(@"Value: %@", displayString);
    }
    
    [self performStandardAnimation:sender];
}

- (void) setOperation:(RITCalcButton *)sender {
    
    [self resetSelectionForOperations];
    
    [self setSelectionForOperation:sender];
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

- (void) performStandardAnimation:(RITCalcButton *)sender {
    
    [UIView animateWithDuration:0.1f animations:^{
        sender.transform = CGAffineTransformMakeScale(1.1f, 1.1f);
    }];
    
    [UIView animateWithDuration:0.1f animations:^{
        sender.transform = CGAffineTransformIdentity;
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
    NSString *displayString = [self getDisplayString:self.firstValue];
    self.displayLabel.text = displayString;
    //NSLog(@"Value: %@", displayString);
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
                    //NSLog(@"%f / %f = %f", self.firstValue, self.secondValue, calculationResult);
                }
                break;
                
            case RITCalcBtnsMultiply:
                
                calculationResult = self.firstValue * self.secondValue;
                //NSLog(@"%f * %f = %f", self.firstValue, self.secondValue, calculationResult);
                break;
                
            case RITCalcBtnsSubstract:
                
                calculationResult = self.firstValue - self.secondValue;
                //NSLog(@"%f - %f = %f", self.firstValue, self.secondValue, calculationResult);
                break;
                
            case RITCalcBtnsAppend:
                
                calculationResult = self.firstValue + self.secondValue;
                //NSLog(@"%f + %f = %f", self.firstValue, self.secondValue, calculationResult);
                break;
        }
        
        self.secondValue = 0;
        self.firstValue = calculationResult;
        self.isSecondValueInput = NO;
        NSString *displayString = [self getDisplayString:self.firstValue];
        self.displayLabel.text = displayString;
        //NSLog(@"Value: %@", displayString);
    }
}

- (NSString*) getDisplayString:(double) value {
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setUsesGroupingSeparator:NO];
    [formatter setUsesSignificantDigits:YES];
    [formatter setMaximumSignificantDigits:13];
    [formatter setDecimalSeparator:@"."];
    
    NSNumber *number = [NSNumber numberWithDouble:value];
    return [formatter stringFromNumber:number];
}

#pragma mark - Actions

- (IBAction)actionAnyCalcButtonTouchUpInside:(RITCalcButton *)sender {
    
    [self.view bringSubviewToFront:sender];
    
    if (sender.tag < RITCalcBtnsDDecimalPoint + 1) {
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
