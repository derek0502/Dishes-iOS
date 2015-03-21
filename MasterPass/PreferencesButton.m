//
//  PreferencesButton.m
//  MasterPass
//
//  Created by Mike on 21/3/15.
//  Copyright (c) 2015 David Benko. All rights reserved.
//

#import "PreferencesButton.h"

@implementation PreferencesButton


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [self.layer setCornerRadius:4.0f];
    [self.layer setBorderWidth:1.0f];
    [self.layer setBorderColor:COLOR_White.CGColor];
}


@end
