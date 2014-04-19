//
//  RITViewController.h
//  2501ButtonsTestHW
//
//  Created by Pronin Alexander on 19.04.14.
//  Copyright (c) 2014 Pronin Alexander. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RITCalcButton.h"

@interface RITViewController : UIViewController

- (IBAction)actionNumberButtonTouchUpInside:(RITCalcButton *)sender;
- (IBAction)actionAnyCalcButtonTouchUpInside:(RITCalcButton *)sender;
- (IBAction)actionOperationButtonTouchUpInside:(RITCalcButton *)sender;

@property (weak, nonatomic) IBOutlet UILabel *displayLabel;

@end
