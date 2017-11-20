//
//  MJRefreshHeaderView.h
//  MJRefresh
//
//  Created by mj on 13-2-26.
//  Copyright (c) 2013年 itcast. All rights reserved.
//  下拉刷新

#import "MJRefreshBaseView.h"

@protocol MJRefreshHeaderViewDelegate;

@interface MJRefreshHeaderView : MJRefreshBaseView

@property (nonatomic, weak) id<MJRefreshHeaderViewDelegate> animateDelegate;
@property (nonatomic, assign) BOOL inBindDragging;

+ (instancetype)header;

@end

@protocol MJRefreshHeaderViewDelegate <NSObject>

@optional
- (void)handleFinishAnimate;
- (void)handleRefreshingAnimate;

@end