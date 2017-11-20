//
//  MJRefreshTableFooterView.h
//  MJRefresh
//
//  Created by mj on 13-2-26.
//  Copyright (c) 2013年 itcast. All rights reserved.
//  上拉加载更多

#import "MJRefreshBaseView.h"

@interface MJRefreshFooterView : MJRefreshBaseView
+ (instancetype)footer;

- (void)adjustFrameWithContentSize;  // 暴露一下，给自定义高度使用

@end
