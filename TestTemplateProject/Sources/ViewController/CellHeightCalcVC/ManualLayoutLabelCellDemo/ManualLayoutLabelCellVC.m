//
//  ManualLayoutLabelCellVC.m
//  AutoLayoutDemo
//
//  Created by Ben on 15/7/15.
//  Copyright (c) 2015年 Ben. All rights reserved.
//

#import "ManualLayoutLabelCellVC.h"
#import "ManualLayoutLabelCell.h"
#import "NSString+Size.h"

@interface ManualLayoutLabelCellVC () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) UITableViewCell *prototypeCell;

@property (nonatomic, strong) NSArray *tableDatasourceArray;

@end

@implementation ManualLayoutLabelCellVC

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
    }
    
    UINib *cellNib = [UINib nibWithNibName:@"ManualLayoutLabelCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"ManualLayoutLabelCell"];
    
    self.prototypeCell = [self.tableView dequeueReusableCellWithIdentifier:@"ManualLayoutLabelCell"];
    
    self.tableDatasourceArray = @[@"1\n2\n3\n4\n5\n6", @"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890xx", @"1\n2", @"1\n2\n3", @"1"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource & UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableDatasourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ManualLayoutLabelCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"ManualLayoutLabelCell"];
    cell.titleLabel.text =  [self.tableDatasourceArray objectAtIndex:indexPath.row];
    //[cell.titleLabel sizeToFit];
    cell.titleLabel.height = [cell.titleLabel.text textSizeWithFont:cell.titleLabel.font
                                                  constrainedToSize:CGSizeMake(cell.titleLabel.frame.size.width, FLT_MAX)
                                                      lineBreakMode:NSLineBreakByWordWrapping].height;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ManualLayoutLabelCell *cell = (ManualLayoutLabelCell *)self.prototypeCell;
    NSString *str =  [self.tableDatasourceArray objectAtIndex:indexPath.row];
    cell.titleLabel.text = str;
    
    CGSize s = [str textSizeWithFont:cell.titleLabel.font
                   constrainedToSize:CGSizeMake(cell.titleLabel.frame.size.width, FLT_MAX)
                       lineBreakMode:NSLineBreakByWordWrapping];
    CGFloat height = (s.height > 45) ? s.height : 45;  // 45为图片高度
    return 1  + height + 16;                         // 16为上下的间距
    
//        // 以下代码只是为了调试 UITableView+FDTemplateLayoutCell
//        CGFloat contentViewWidth = [UIScreen mainScreen].bounds.size.width;
//        CGFloat accessroyWidth = 0;
//        NSLayoutConstraint *widthFenceConstraint = [NSLayoutConstraint constraintWithItem:cell.contentView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:contentViewWidth];
//
//        // [bug fix] after iOS 10.3, Auto Layout engine will add an additional 0 width constraint onto cell's content view, to avoid that, we add constraints to content view's left, right, top and bottom.
//        static BOOL isSystemVersionEqualOrGreaterThen10_2 = NO;
//        static dispatch_once_t onceToken;
//        dispatch_once(&onceToken, ^{
//            isSystemVersionEqualOrGreaterThen10_2 = [UIDevice.currentDevice.systemVersion compare:@"10.2" options:NSNumericSearch] != NSOrderedAscending;
//        });
//
//        NSArray<NSLayoutConstraint *> *edgeConstraints;
//        if (isSystemVersionEqualOrGreaterThen10_2) {
//            // To avoid confilicts, make width constraint softer than required (1000)
//            widthFenceConstraint.priority = UILayoutPriorityRequired - 1;
//
//            // Build edge constraints
//            NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:cell.contentView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:cell attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
//            NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:cell.contentView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:cell attribute:NSLayoutAttributeRight multiplier:1.0 constant:accessroyWidth];
//            NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:cell.contentView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:cell attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
//            NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:cell.contentView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:cell attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
//            edgeConstraints = @[leftConstraint, rightConstraint, topConstraint, bottomConstraint];
//            [cell addConstraints:edgeConstraints];
//        }
//
//        [cell.contentView addConstraint:widthFenceConstraint];
//
//
//
//        //cell.titleLabel.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - 69;
//        CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
//    //    NSLog (@"size: %@", NSStringFromCGSize(size));
//
//
//
//        [cell.contentView removeConstraint:widthFenceConstraint];
//        if (isSystemVersionEqualOrGreaterThen10_2) {
//            [cell removeConstraints:edgeConstraints];
//        }
//
//
//        if (size.height == 0) {
//            #if DEBUG
//            // Warn if using AutoLayout but get zero height.
//            if (cell.contentView.constraints.count > 0) {
//                NSLog(@"[FDTemplateLayoutCell] Warning once only: Cannot get a proper cell height (now 0) from '- systemFittingSize:'(AutoLayout). You should check how constraints are built in cell, making it into 'self-sizing' cell.");
//            }
//            #endif
//            // Try '- sizeThatFits:' for frame layout.
//            // Note: fitting height should not include separator view.
//            size.height = [cell sizeThatFits:CGSizeMake(contentViewWidth, 0)].height;
//
//            NSLog(@"calculate using sizeThatFits - %@", @(size.height));
//        }
//
//        // Still zero height after all above.
//        if (size.height == 0) {
//            // Use default row height.
//            size.height = 44;
//        }
//
//        return size.height;
}

#pragma mark - 屏幕旋转相关

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

@end
