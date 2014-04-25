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

- (IBAction)actionAnyCalcButtonTouchUpInside:(RITCalcButton *)sender;

@property (weak, nonatomic) IBOutlet UILabel *displayLabel;
@property (strong, nonatomic) IBOutletCollection(RITCalcButton) NSArray *operationButtons;

@property (assign, nonatomic) long long firstValue;
@property (assign, nonatomic) long long secondValue;

@end
