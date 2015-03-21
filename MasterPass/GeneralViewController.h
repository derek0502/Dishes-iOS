//
//  GeneralViewController.h
//  dreamMaster
//
//  Created by Derek Cheung on 21/3/15.
//  Copyright (c) 2015 Derek Cheung. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GeneralViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIView *navContainer;
@property (strong, nonatomic) IBOutlet UIView *navView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIButton *backButton;
@property (strong, nonatomic) IBOutlet UIButton *nextButton;

@property (strong, nonatomic) IBOutlet UIView *contentContainer;
@property (strong, nonatomic) IBOutlet UIView *contentView;

@property (strong, nonatomic) IBOutlet UIView *footerContainer;
@property (strong, nonatomic) IBOutlet UIView *footerView;


- (IBAction)backPressed:(id)sender;
- (IBAction)nextPressed:(id)sender;

@end
