//
//  MixLayoutVC.m
//  AutoLayoutDemo
//
//  Created by Ben on 15/6/23.
//  Copyright (c) 2015年 Ben. All rights reserved.
//

#import "MixLayoutVC.h"

@interface MixLayoutVC ()

@property (strong, nonatomic) IBOutlet UIView *viewA;
@property (strong, nonatomic) IBOutlet UIView *viewB;

@end

@implementation MixLayoutVC

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    [self.view addSubview:self.viewA];

    self.view.translatesAutoresizingMaskIntoConstraints = YES;
    self.viewA.frame = CGRectMake(50, 100, 269, 361);
    self.viewA.translatesAutoresizingMaskIntoConstraints = NO;   // Notice:影响的是自己宽高或其他super view的约束会不生效

    NSLayoutConstraint *contentLeft = [NSLayoutConstraint constraintWithItem:self.viewA
                                                                   attribute:NSLayoutAttributeLeft
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.view
                                                                   attribute:NSLayoutAttributeLeft
                                                                  multiplier:1
                                                                    constant:50];

    NSLayoutConstraint *contentRight = [NSLayoutConstraint constraintWithItem:self.viewA attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:-50];

    NSLayoutConstraint *contentTop = [NSLayoutConstraint constraintWithItem:self.viewA attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:200];

    NSLayoutConstraint *contentBottom = [NSLayoutConstraint constraintWithItem:self.viewA attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:-50];

    [self.view addConstraints:@[contentLeft, contentRight, contentTop, contentBottom]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [self.viewA addSubview:self.viewB];
    self.viewB.translatesAutoresizingMaskIntoConstraints = NO;   // Notice:
    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:self.viewB attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:200];

    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self.viewB attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:200];

    NSLayoutConstraint *contentLeft = [NSLayoutConstraint constraintWithItem:self.viewA
                                                                   attribute:NSLayoutAttributeLeft
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.viewB
                                                                   attribute:NSLayoutAttributeLeft
                                                                  multiplier:1
                                                                    constant:-30];

    NSLayoutConstraint *contentTop = [NSLayoutConstraint constraintWithItem:self.viewA attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.viewB attribute:NSLayoutAttributeTop multiplier:1 constant:-30];

    [self.viewB addConstraints:@[widthConstraint, heightConstraint]];
    [self.viewA addConstraints:@[contentLeft, contentTop]];

    [self.view layoutIfNeeded];
}

#pragma mark - IBActions

- (IBAction)didClickChangeFrameButtonAction:(id)sender {
    self.viewA.frame = CGRectMake(50, 300, 200, 200);
    
//    [self.view setNeedsUpdateConstraints];
}

#pragma mark - 屏幕旋转相关

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

@end
