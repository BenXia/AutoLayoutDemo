//
//  StandardAutoLayoutVC.m
//  AutoLayoutDemo
//
//  Created by Ben on 15/7/13.
//  Copyright (c) 2015年 Ben. All rights reserved.
//

#import "StandardAutoLayoutVC.h"

static const CGFloat kViewAiPhoneVerticalOriginY = 72;
static const CGFloat kViewAiPhoneHorizontalOriginY = 38;
static const CGFloat kViewAiPadOriginY = 72;

@interface StandardAutoLayoutVC ()

@property (weak, nonatomic) IBOutlet UIImageView *avatorImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *gradeLabel;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *avatorWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *avatorTopConstraint;
@property (nonatomic, assign) BOOL isBigAvator;

@end

@implementation StandardAutoLayoutVC

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    self.isBigAvator = NO;
    self.descriptionLabel.text = @"这是小图模式\n1976年4月1日，乔布斯签署了一份合同，决定成立一家电脑公司。 1977年4月，乔布斯在美国第一次计算机展览会展示了苹果Ⅱ号样机。1997年苹果推出iMac，创新的外壳颜色透明设计使得产品大卖，并让苹果度过财政危机。  2011年8月24日，史蒂夫·乔布斯向苹果董事会提交辞职申请。乔布斯被认为是计算机业界与娱乐业界的标志性人物，他经历了苹果公司几十年的起落与兴衰，先后领导和推出了麦金塔计算机（Macintosh）、iMac、iPod、iPhone、iPad等风靡全球的电子产品，深刻地改变了现代通讯、娱乐、生活方式。乔布斯同时也是前Pixar动画公司的董事长及行政总裁。";
    
    self.avatorImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapAvatorImageViewAction:)];
    [self.avatorImageView addGestureRecognizer:tapRecognizer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setIsBigAvator:(BOOL)isBigAvator {
    _isBigAvator = isBigAvator;
    
    [self.view setNeedsUpdateConstraints];
}

#pragma mark - IBActions & Gestures

- (void)didTapAvatorImageViewAction:(UITapGestureRecognizer *)gesture {
    self.isBigAvator = !self.isBigAvator;
    
    self.descriptionLabel.text = self.isBigAvator ? @"这是大图模式\n1976年4月1日，乔布斯签署了一份合同，决定成立一家电脑公司。 1977年4月，乔布斯在美国第一次计算机展览会展示了苹果Ⅱ号样机。1997年苹果推出iMac，创新的外壳颜色透明设计使得产品大卖，并让苹果度过财政危机。  2011年8月24日，史蒂夫·乔布斯向苹果董事会提交辞职申请。乔布斯被认为是计算机业界与娱乐业界的标志性人物，他经历了苹果公司几十年的起落与兴衰，先后领导和推出了麦金塔计算机（Macintosh）、iMac、iPod、iPhone、iPad等风靡全球的电子产品，深刻地改变了现代通讯、娱乐、生活方式。乔布斯同时也是前Pixar动画公司的董事长及行政总裁。2011年8月24日，史蒂夫·乔布斯向苹果董事会提交辞职申请。他还在辞职信中建议由首席营运长蒂姆·库克接替他的职位。乔布斯在辞职信中表示，自己无法继续担任行政总裁，不过自己愿意担任公司董事长、董事或普通职员。苹果公司股票暂停盘后交易。乔布斯在信中并没有指明辞职原因，但他一直都在与胰腺癌作斗争。2011年8月25日，苹果宣布他辞职，并立即生效，职位由蒂姆·库克接任。同时苹果宣布任命史蒂夫·乔布斯为公司董事长，蒂姆·库克担任CEO。" : @"这是小图模式\n1976年4月1日，乔布斯签署了一份合同，决定成立一家电脑公司。 1977年4月，乔布斯在美国第一次计算机展览会展示了苹果Ⅱ号样机。1997年苹果推出iMac，创新的外壳颜色透明设计使得产品大卖，并让苹果度过财政危机。  2011年8月24日，史蒂夫·乔布斯向苹果董事会提交辞职申请。乔布斯被认为是计算机业界与娱乐业界的标志性人物，他经历了苹果公司几十年的起落与兴衰，先后领导和推出了麦金塔计算机（Macintosh）、iMac、iPod、iPhone、iPad等风靡全球的电子产品，深刻地改变了现代通讯、娱乐、生活方式。乔布斯同时也是前Pixar动画公司的董事长及行政总裁。";
}

#pragma mark - 布局相关统一代码规范

- (void)updateViewConstraints {
    [super updateViewConstraints];
    
    if (self.isBigAvator) {
        self.avatorWidthConstraint.constant = 120;
    } else {
        self.avatorWidthConstraint.constant = 100;
    }
    
    self.avatorTopConstraint.constant = IS_IPHONE ? (UIDeviceOrientationIsPortrait([UIDevice currentDevice].orientation) ? kViewAiPhoneVerticalOriginY : kViewAiPhoneHorizontalOriginY) : kViewAiPadOriginY;
}

#pragma mark - 屏幕旋转相关

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

@end
