//
//  AppSystem.m
//  QQing
//
//  Created by 李杰 on 5/22/15.
//
//
#import "AppSystem.h"

/**
 *  @author fallenink
 
 *  About error: @""
 
 *  Initialize in Class Method: @"+ (void)initialize"
 *  or change file suffix from "*.m" to "*.mm"
 */

#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
const BOOL IOS11_OR_LATER = ( [[[UIDevice currentDevice] systemVersion] compare:@"11.0" options:NSNumericSearch] != NSOrderedAscending );
const BOOL IOS10_OR_LATER = ( [[[UIDevice currentDevice] systemVersion] compare:@"10.0" options:NSNumericSearch] != NSOrderedAscending );
const BOOL IOS9_OR_LATER = ( [[[UIDevice currentDevice] systemVersion] compare:@"9.0" options:NSNumericSearch] != NSOrderedAscending );
const BOOL IOS8_OR_LATER = ( [[[UIDevice currentDevice] systemVersion] compare:@"8.0" options:NSNumericSearch] != NSOrderedAscending );
const BOOL IOS7_OR_LATER = ( [[[UIDevice currentDevice] systemVersion] compare:@"7.0" options:NSNumericSearch] != NSOrderedAscending );
const BOOL IOS6_OR_LATER = ( [[[UIDevice currentDevice] systemVersion] compare:@"6.0" options:NSNumericSearch] != NSOrderedAscending );
const BOOL IOS5_OR_LATER = ( [[[UIDevice currentDevice] systemVersion] compare:@"5.0" options:NSNumericSearch] != NSOrderedAscending );
const BOOL IOS4_OR_LATER = ( [[[UIDevice currentDevice] systemVersion] compare:@"4.0" options:NSNumericSearch] != NSOrderedAscending );
const BOOL IOS3_OR_LATER = ( [[[UIDevice currentDevice] systemVersion] compare:@"3.0" options:NSNumericSearch] != NSOrderedAscending );

const BOOL IOS10_OR_EARLIER = !IOS11_OR_LATER;
const BOOL IOS9_OR_EARLIER = !IOS10_OR_LATER;
const BOOL IOS8_OR_EARLIER = !IOS9_OR_LATER;
const BOOL IOS7_OR_EARLIER = !IOS8_OR_LATER;
const BOOL IOS6_OR_EARLIER = !IOS7_OR_LATER;
const BOOL IOS5_OR_EARLIER = !IOS6_OR_LATER;
const BOOL IOS4_OR_EARLIER = !IOS5_OR_LATER;
const BOOL IOS3_OR_EARLIER = !IOS4_OR_LATER;
#else
const BOOL IOS11_OR_LATER = NO;
const BOOL IOS10_OR_LATER = NO;
const BOOL IOS9_OR_LATER = NO;
const BOOL IOS8_OR_LATER = NO;
const BOOL IOS7_OR_LATER = NO;
const BOOL IOS6_OR_LATER = NO;
const BOOL IOS5_OR_LATER = NO;
const BOOL IOS4_OR_LATER = NO;
const BOOL IOS3_OR_LATER = NO;

const BOOL IOS10_OR_EARLIER = NO;
const BOOL IOS9_OR_EARLIER = NO;
const BOOL IOS8_OR_EARLIER = NO;
const BOOL IOS7_OR_EARLIER = NO;
const BOOL IOS6_OR_EARLIER = NO;
const BOOL IOS5_OR_EARLIER = NO;
const BOOL IOS4_OR_EARLIER = NO;
const BOOL IOS3_OR_EARLIER = NO;
#endif



