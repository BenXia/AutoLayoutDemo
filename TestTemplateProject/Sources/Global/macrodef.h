//
//  macrodef.h
//  TestTemplateProject
//
//  Created by Ben on 1/26/15.
//  Copyright © 2017年 iOSStudio. All rights reserved.
//

#ifndef BN_macrodef_h
#define BN_macrodef_h


// 单件.h中声明
#undef BN_DEC_SINGLETON
#define BN_DEC_SINGLETON(classname) \
+ (instancetype)sharedInstance;\
+ (instancetype)shared##classname;


// 单件.m中实现
#undef BN_IMP_SINGLETON
#if __has_feature(objc_arc)
#define BN_IMP_SINGLETON(classname) \
\
static classname *shared##classname = nil;\
\
+ (instancetype)sharedInstance {\
\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
shared##classname = [[super allocWithZone:NULL] init];\
});\
return shared##classname;\
} \
\
+ (instancetype)shared##classname {\
\
return [self sharedInstance];\
}\
\
+ (instancetype)allocWithZone:(struct _NSZone *)zone {\
\
return [self sharedInstance];\
}\
\
- (id)copyWithZone:(NSZone *)zone {\
return self;\
}\
\
- (id)mutableCopyWithZone:(NSZone *)zone\
{\
return self;\
}

#else
#define BN_IMP_SINGLETON(classname) \
\
static classname *shared##classname = nil;\
\
+ (instancetype)sharedInstance {\
\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
shared##classname = [[super allocWithZone:NULL] init];\
});\
return shared##classname;\
} \
\
+ (instancetype)shared##classname {\
\
return [self sharedInstance];\
}\
\
+ (instancetype)allocWithZone:(struct _NSZone *)zone {\
\
return [self sharedInstance];\
}\
\
- (id)copyWithZone:(NSZone *)zone {\
return self;\
}\
\
- (id)mutableCopyWithZone:(NSZone *)zone {\
return self;\
}\
\
- (oneway void)release {\
}\
\
- (instancetype)autorelease {\
    return self; \
}\
\
- (instancetype)retain {\
return self;\
}\
\
- (NSUInteger)retainCount {\
return NSUIntegerMax;\
}

#endif

#ifndef NS_ENUM
#define NS_ENUM(_type, _name) enum _name : _type _name; enum _name : _type
#endif

#define RUNLOOP_RUN_FOR_A_WHILE \
{ \
[[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.1]]; \
}

// 检查系统版本
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

// 系统版本
#define SYSTEM_VERSION  [[UIDevice currentDevice].systemVersion doubleValue]

// RGB颜色
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r, g, b, 1.0f)

/**
 *
 *  设备类型宏判断，提供给需要在不同机型的设备上的布局调整
 *
 */
#define IS_IPAD    (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE  (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA  ([[UIScreen mainScreen] scale] >= 2.0)


// 警告处理方案
#define IgnorePerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0);

#endif


