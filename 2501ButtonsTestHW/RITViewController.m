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

- (IBAction)actionNumberButtonTouchUpInside:(RITCalcButton *)sender {
    
    /*
     sender.backgroundColor = [UIColor whiteColor];
     [sender setNeedsDisplay];
     */
    
    UIColor *buttonBackgroundColor = sender.backgroundColor;
    
    [self.view bringSubviewToFront:sender];
    
    [UIView animateWithDuration:0.5f animations:^{
        sender.transform = CGAffineTransformMakeScale(1.1f, 1.1f);
        //sender.alpha = 1.0f;
        sender.backgroundColor = [UIColor whiteColor];
    }];
    [UIView animateWithDuration:0.5f animations:^{
        sender.transform = CGAffineTransformIdentity;
        //sender.alpha = 1.f;
        sender.backgroundColor = buttonBackgroundColor;
    }];
}
@end
