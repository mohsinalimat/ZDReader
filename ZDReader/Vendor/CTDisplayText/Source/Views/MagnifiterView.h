//
//  MagnifiterView.h
//  CoreTextDemo
//
//  Created by Noah on 5/8/14.
//  Copyright (c) 2014 Noah. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MagnifiterView : UIView

@property (weak, nonatomic) UIView *viewToMagnify;
@property (nonatomic) CGPoint touchPoint;

@end
