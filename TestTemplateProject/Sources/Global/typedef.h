//
//  typedef.h
//  TestTemplateProject
//
//  Created by Ben on 15/7/16.
//  Copyright (c) 2015年 Ben. All rights reserved.
//

#ifndef BN_typedef_h
#define BN_typedef_h

/*
 * Block 预定义
 */
typedef id(^ReturnObjectBlock)(void);
typedef void(^Block)(void);
typedef void(^BlockBlock)(Block block);
typedef void(^BOOLBlock)(BOOL b);
typedef void(^ObjectBlock)(id obj);
typedef void(^ArrayBlock)(NSArray *array);
typedef void(^MutableArrayBlock)(NSMutableArray *array);
typedef void(^DictionaryBlock)(NSDictionary *dic);
typedef void(^ErrorBlock)(NSError *error);
typedef void(^IndexBlock)(NSInteger index);
typedef void(^ListItemBlock) (NSInteger index, id param);
typedef void(^FloatBlock)(CGFloat afloat);
typedef void(^StringBlock)(NSString *str);
typedef void(^ImageBlock)(UIImage *image);

typedef void(^CancelBlock)(id viewController);
typedef void(^FinishedBlock)(id viewController, id object);

#endif


