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
}

#pragma mark - 屏幕旋转相关

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

@end
