//
//  ManualLayoutTextViewCellVC.m
//  AutoLayoutDemo
//
//  Created by Ben on 15/7/15.
//  Copyright (c) 2015年 Ben. All rights reserved.
//

#import "ManualLayoutTextViewCellVC.h"
#import "ManualLayoutTextViewCell.h"
#import "NSString+Size.h"

@interface ManualLayoutTextViewCellVC () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) UITableViewCell *prototypeCell;

@property (nonatomic, strong) NSArray *tableDatasourceArray;

@end

@implementation ManualLayoutTextViewCellVC

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
    
    UINib *cellNib = [UINib nibWithNibName:@"ManualLayoutTextViewCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"ManualLayoutTextViewCell"];
    
    self.prototypeCell = [self.tableView dequeueReusableCellWithIdentifier:@"ManualLayoutTextViewCell"];
    
    self.tableDatasourceArray = @[@"1\n2\n3\n4\n5\n6", @"123456789012345678901234567890", @"1\n2", @"1\n2\n3", @"1"];
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
    ManualLayoutTextViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"ManualLayoutTextViewCell"];
    cell.titleTextView.text = [self.tableDatasourceArray objectAtIndex:indexPath.row];
    //[cell.titleTextView sizeToFit];
    cell.titleTextView.height = [cell.titleTextView sizeThatFits:CGSizeMake(cell.titleTextView.frame.size.width, FLT_MAX)].height;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ManualLayoutTextViewCell *cell = (ManualLayoutTextViewCell *)self.prototypeCell;
    NSString *str = [self.tableDatasourceArray objectAtIndex:indexPath.row];
    cell.titleTextView.text = str;
    CGSize s = [cell.titleTextView sizeThatFits:CGSizeMake(cell.titleTextView.frame.size.width, FLT_MAX)];
    CGFloat height = (s.height > 45) ? s.height : 45;  // 45为图片高度
    return 1  + height + 16;                           // 16为上下的间距
}

#pragma mark - 屏幕旋转相关

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

@end
