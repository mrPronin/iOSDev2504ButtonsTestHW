//
//  RITCalcButton.h
//  2501ButtonsTestHW
//
//  Created by Pronin Alexander on 19.04.14.
//  Copyright (c) 2014 Pronin Alexander. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    RITCalcBtnsReset = 10,
    RITCalcBtnsBackspace = 11,
    RITCalcBtnsDivide = 14,
    RITCalcBtnsMultiply = 15,
    RITCalcBtnsSubstract = 16,
    RITCalcBtnsAppend = 17
} RITCalcBtns;

#define RITmaxDisplaySign    12

@interface RITCalcButton : UIButton

@end
