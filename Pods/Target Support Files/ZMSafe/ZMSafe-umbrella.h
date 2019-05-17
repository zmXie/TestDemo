#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "NSArray+ZMSafe.h"
#import "NSDictionary+ZMSafe.h"
#import "NSMutableArray+ZMSafe.h"
#import "NSMutableDictionary+ZMSafe.h"
#import "NSMutableString+ZMSafe.h"
#import "NSObject+Swizzle.h"
#import "NSObject+ZMSafe.h"
#import "NSString+ZMSafe.h"

FOUNDATION_EXPORT double ZMSafeVersionNumber;
FOUNDATION_EXPORT const unsigned char ZMSafeVersionString[];

