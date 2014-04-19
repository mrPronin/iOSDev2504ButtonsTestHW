//
//  RITCalcButton.m
//  2501ButtonsTestHW
//
//  Created by Pronin Alexander on 19.04.14.
//  Copyright (c) 2014 Pronin Alexander. All rights reserved.
//

#import "RITCalcButton.h"

@implementation RITCalcButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // drow the black border
    CGContextSetLineWidth(context, 1);
    UIColor *color = [UIColor colorWithRed:0.8f green:0.8f blue:0.8f alpha:1];
    CGContextSetStrokeColorWithColor(context, [color CGColor]);
    CGContextAddRect(context, rect);
    CGContextStrokePath(context);
    
}


@end
