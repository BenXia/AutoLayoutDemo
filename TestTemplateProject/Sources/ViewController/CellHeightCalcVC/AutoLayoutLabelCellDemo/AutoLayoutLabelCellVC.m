//
//  AutoLayoutLabelCellVC.m
//  AutoLayoutDemo
//
//  Created by Ben on 15/7/15.
//  Copyright (c) 2015年 Ben. All rights reserved.
//

#import "AutoLayoutLabelCellVC.h"
#import "AutoLayoutLabelCell.h"

@interface AutoLayoutLabelCellVC () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) UITableViewCell *prototypeCell;

@property (nonatomic, strong) NSArray *tableDatasourceArray;

@end

@implementation AutoLayoutLabelCellVC

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
    
    UINib *cellNib = [UINib nibWithNibName:@"AutoLayoutLabelCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"AutoLayoutLabelCell"];
    
    self.prototypeCell = [self.tableView dequeueReusableCellWithIdentifier:@"AutoLayoutLabelCell"];
    
    self.tableDatasourceArray = @[@"1\n2\n3\n4\n5\n6", @"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890xx", @"1\n2", @"1\n2\n3", @"1"];

    // @"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901"
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
    AutoLayoutLabelCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"AutoLayoutLabelCell"];
    cell.titleLabel.text = [self.tableDatasourceArray objectAtIndex:indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    AutoLayoutLabelCell *cell = (AutoLayoutLabelCell *)self.prototypeCell;
    
    cell.titleLabel.text = [self.tableDatasourceArray objectAtIndex:indexPath.row];
    
    
    
    
    CGFloat contentViewWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat accessroyWidth = 0;
    NSLayoutConstraint *widthFenceConstraint = [NSLayoutConstraint constraintWithItem:cell.contentView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:contentViewWidth];
    
    // [bug fix] after iOS 10.3, Auto Layout engine will add an additional 0 width constraint onto cell's content view, to avoid that, we add constraints to content view's left, right, top and bottom.
    static BOOL isSystemVersionEqualOrGreaterThen10_2 = NO;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        isSystemVersionEqualOrGreaterThen10_2 = [UIDevice.currentDevice.systemVersion compare:@"10.2" options:NSNumericSearch] != NSOrderedAscending;
    });
    
    NSArray<NSLayoutConstraint *> *edgeConstraints;
    if (isSystemVersionEqualOrGreaterThen10_2) {
        // To avoid confilicts, make width constraint softer than required (1000)
        widthFenceConstraint.priority = UILayoutPriorityRequired - 1;
        
        // Build edge constraints
        NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:cell.contentView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:cell attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
        NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:cell.contentView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:cell attribute:NSLayoutAttributeRight multiplier:1.0 constant:accessroyWidth];
        NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:cell.contentView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:cell attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
        NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:cell.contentView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:cell attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
        edgeConstraints = @[leftConstraint, rightConstraint, topConstraint, bottomConstraint];
        [cell addConstraints:edgeConstraints];
    }
    
    [cell.contentView addConstraint:widthFenceConstraint];
    
    
    
//    cell.titleLabel.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - 69;
    CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
//    NSLog (@"size: %@", NSStringFromCGSize(size));
    
    
    
    [cell.contentView removeConstraint:widthFenceConstraint];
    if (isSystemVersionEqualOrGreaterThen10_2) {
        [cell removeConstraints:edgeConstraints];
    }
    
    
    
    return 1  + size.height;
}

#pragma mark - 屏幕旋转相关

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

@end
