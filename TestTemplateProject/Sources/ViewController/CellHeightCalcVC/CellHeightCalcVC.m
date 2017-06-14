//
//  CellHeightCalcVC.m
//  AutoLayoutDemo
//
//  Created by Ben on 15/7/15.
//  Copyright (c) 2015年 Ben. All rights reserved.
//

#import "CellHeightCalcVC.h"
#import "AutoLayoutLabelCellVC.h"
#import "AutoLayoutTextViewCellVC.h"
#import "ManualLayoutLabelCellVC.h"
#import "ManualLayoutTextViewCellVC.h"

/*
   动态计算UITableViewCell高度详解:  http://www.ifun.cc/blog/2014/02/21/dong-tai-ji-suan-uitableviewcellgao-du-xiang-jie/
 */

@interface CellHeightCalcVC ()

@end

@implementation CellHeightCalcVC

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions

- (IBAction)didClickAutoLayoutLabelCellDemoButtonAction:(id)sender {
    AutoLayoutLabelCellVC *vc = [[AutoLayoutLabelCellVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)didClickAutoLayoutTextViewCellDemoButtonAction:(id)sender {
    AutoLayoutTextViewCellVC *vc = [[AutoLayoutTextViewCellVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)didClickManualLayoutLabelCellDemoButtonAction:(id)sender {
    ManualLayoutLabelCellVC *vc = [[ManualLayoutLabelCellVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)didClickManualLayoutTextViewCellDemoButtonAction:(id)sender {
    ManualLayoutTextViewCellVC *vc = [[ManualLayoutTextViewCellVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - 屏幕旋转相关

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

@end
