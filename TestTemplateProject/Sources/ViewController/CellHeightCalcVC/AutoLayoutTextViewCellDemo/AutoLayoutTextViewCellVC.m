//
//  AutoLayoutTextViewCellVC.m
//  AutoLayoutDemo
//
//  Created by Ben on 15/7/15.
//  Copyright (c) 2015年 Ben. All rights reserved.
//

#import "AutoLayoutTextViewCellVC.h"
#import "AutoLayoutTextViewCell.h"

@interface AutoLayoutTextViewCellVC () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) UITableViewCell *prototypeCell;

@property (nonatomic, strong) NSArray *tableDatasourceArray;

@end

@implementation AutoLayoutTextViewCellVC

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UINib *cellNib = [UINib nibWithNibName:@"AutoLayoutTextViewCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"AutoLayoutTextViewCell"];
    
    self.prototypeCell = [self.tableView dequeueReusableCellWithIdentifier:@"AutoLayoutTextViewCell"];
    
    self.tableDatasourceArray = @[@"1\n2\n3\n4\n5\n6", @"12345678901234567890123456789012345678901234567890123456789012345678901234567890", @"1\n2", @"1\n2\n3", @"1"];

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
    AutoLayoutTextViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"AutoLayoutTextViewCell"];
    cell.titleTextView.text = [self.tableDatasourceArray objectAtIndex:indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    AutoLayoutTextViewCell *cell = (AutoLayoutTextViewCell *)self.prototypeCell;
    cell.titleTextView.text = [self.tableDatasourceArray objectAtIndex:indexPath.row];
    
    // 和 UILabel 一样使用 systemLayoutSizeFittingSize 方法计算高度是不行的，因为 UITextView 其实内部是有 UIScrollView 的
    // 所以使用 UITableView+FDTemplateLayoutCell 时注意如果内部有 UITextView 时想自动计算高度是不行的
    CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    CGFloat h = size.height;
    
//    // 使用下面方法手动计算没有问题
//    CGSize textViewSize = [cell.titleTextView sizeThatFits:CGSizeMake(cell.titleTextView.frame.size.width, FLT_MAX)];
//    CGFloat h = textViewSize.height + 16;
    
    h = h > 61 ? h : 61;  //61是保证图片显示的最低高度，见xib
    return 1 + h;
}

#pragma mark - 屏幕旋转相关

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

@end
