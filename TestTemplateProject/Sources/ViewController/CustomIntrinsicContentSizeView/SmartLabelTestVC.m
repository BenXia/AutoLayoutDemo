//
//  SmartLabelTestVC.m
//  TestTemplateProject
//
//  Created by Ben on 2017/12/31.
//  Copyright © 2017年 iOSStudio. All rights reserved.
//

#import "SmartLabelTestVC.h"
#import "SmartLabel.h"

@interface SmartLabelTestVC ()

@property (weak, nonatomic) IBOutlet SmartLabel *smartView;

@property (nonatomic, strong) NSTimer *repeatTimer;

@end

@implementation SmartLabelTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    @weakify(self);
    self.repeatTimer = [NSTimer scheduledTimerWithTimeInterval:0.3 repeats:YES block:^(NSTimer *timer) {
        @strongify(self);
        [self appendTextToSmartView];
        if (self.smartView.title.length >= 60) {
            [timer invalidate];
            timer = nil;
        }
    }];
    [[NSRunLoop mainRunLoop] addTimer:self.repeatTimer forMode:NSRunLoopCommonModes];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)appendTextToSmartView {
    static int s_num = 0;
    
    s_num++;
    if (s_num >= 10) {
        s_num = 0;
    }
    
    self.smartView.title = [NSString stringWithFormat:@"%@%d", self.smartView.title ? : @"", s_num];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    NSLog (@"%@ dealloc", [self class]);
}

@end


