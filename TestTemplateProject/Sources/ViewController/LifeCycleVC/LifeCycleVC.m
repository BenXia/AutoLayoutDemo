//
//  LifeCycleVC.m
//  TestTemplateProject
//
//  Created by Ben on 2017/12/24.
//  Copyright © 2017年 iOSStudio. All rights reserved.
//

#import "LifeCycleVC.h"
#import "CustomView.h"

@interface LifeCycleVC ()

@property (weak, nonatomic) IBOutlet CustomView *customView;

@property (nonatomic, strong) CustomView *manuallyCreateCustomView;

@end

@implementation LifeCycleVC

// 如果有自己的 xib，不要重写该方法，否则不会找自己同名的 xib 初始化
//- (void)loadView {
//    NSLog (@"%@=======loadView before", [self class]);
//    
//    [super loadView];
//    
//    NSLog (@"%@=======loadView after", [self class]);
//    NSLog (@"self.customView : %@", self.customView);
//    
//}

- (void)awakeFromNib {
    NSLog (@"%@=======awakeFromNib before", [self class]);
    
    [super awakeFromNib];
    
    NSLog (@"%@=======awakeFromNib after", [self class]);
}

- (instancetype)init {
    NSLog (@"%@=======init before", [self class]);

    self = [super init];

    NSLog (@"%@=======init after", [self class]);

    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    NSLog (@"%@=======initWithCoder: before", [self class]);
    
    self = [super initWithCoder:aDecoder];
    
    NSLog (@"%@=======initWithCoder: after", [self class]);
    
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    NSLog (@"%@=======initWithNibName:%@ bundle:%@ before", [self class], nibNameOrNil, nibBundleOrNil);

    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    NSLog (@"%@=======initWithNibName:%@ bundle:%@ after", [self class], nibNameOrNil, nibBundleOrNil);
    NSLog (@"self.customView : %@", self.customView);

    return self;
}

- (void)viewDidLoad {
    NSLog (@"%@=======viewDidLoad before", [self class]);
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSLog (@"%@=======viewDidLoad after", [self class]);
    NSLog (@"self.customView : %@", self.customView);
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog (@"%@=======viewWillAppear before", [self class]);
    
    [super viewWillAppear:animated];
    
    NSLog (@"%@=======viewWillAppear after", [self class]);
    NSLog (@"self.customView : %@", self.customView);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions

- (IBAction)didClickManuallyCreateCustomViewButton:(id)sender {
    self.manuallyCreateCustomView = [[[NSBundle mainBundle] loadNibNamed:@"CustomView" owner:nil options:nil] firstObject];
    self.manuallyCreateCustomView.frame = CGRectMake(30, 100, kScreenWidth - 60 , 50);
    
    self.manuallyCreateCustomView.titleLabel.text = @"Title Label";
    [self.manuallyCreateCustomView.bottomButton setTitle:@"Bottom Button" forState:UIControlStateNormal];
    
    [self.view addSubview:self.manuallyCreateCustomView];
}

@end


