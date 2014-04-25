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

- (void) numberKeyPressedWithNumber:(NSUInteger) num {
    
    NSString *currentDisplayString = self.displayLabel.text;
    
    if ([currentDisplayString length] <= maxDisplaySign) {
        
        NSString *displayString = [NSString stringWithFormat:@"%@%d", (currentDisplayString)?currentDisplayString:@"", num];
        self.displayLabel.text = displayString;
    }
}

- (void) resetDisplay {
    
    self.displayLabel.text = nil;
}

- (void) backspaceDisplay {
    
    NSString *currentDisplayString = self.displayLabel.text;
    if (currentDisplayString) {
        NSString *displayString = [currentDisplayString substringToIndex:[currentDisplayString length] - 1];
        self.displayLabel.text = displayString;
    }
}

#pragma mark - Actions

- (IBAction)actionAnyCalcButtonTouchUpInside:(RITCalcButton *)sender {
    
    if (sender.tag < 10) {
        [self numberKeyPressedWithNumber:sender.tag];
    } else {
        switch (sender.tag) {
            case RITCalcBtnsReset:
                [self resetDisplay];
                break;
                
            case RITCalcBtnsBackspace:
                [self backspaceDisplay];
                break;
                
            default:
                break;
        }
    }
    
    
    
    [self.view bringSubviewToFront:sender];
    
    
    [UIView animateWithDuration:0.1f animations:^{
        sender.transform = CGAffineTransformMakeScale(1.1f, 1.1f);
    }];
    
    [UIView animateWithDuration:0.1f animations:^{
        sender.transform = CGAffineTransformIdentity;
    }];
    
}

@end
