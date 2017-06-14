//
//  PlaygroundVC.m
//  TestTemplateProject
//
//  Created by Ben on 15/7/16.
//  Copyright (c) 2015年 Ben. All rights reserved.
//

#import "PlaygroundVC.h"

@interface PlaygroundVC ()

@end

@implementation PlaygroundVC

- (void)viewDidLoad {
    [super viewDidLoad];

    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end


