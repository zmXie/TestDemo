//
//  CTMediator+PaperManagement.m
//  CTMediator
//
//  Created by xzm on 2018/8/27.
//

#import "CTMediator+PaperManagement.h"

//target
static NSString * const kCTMediatorTargetPM = @"PaperManagement";

//action
static NSString * const kCTMediatorActionGetMyPaperVC = @"getMyPaperVC";
static NSString * const kCTMediatorActionGetClaimPaperVC = @"getClaimPaperVC";


@implementation CTMediator (PaperManagement)

/**
 获取我的论文控制器
 
 @param userId 用户id
 @return 我的论文
 */
- (UIViewController *)getMyPaperVCWithUserId:(NSString *)userId
{
    return [self performTarget:kCTMediatorTargetPM
                        action:kCTMediatorActionGetMyPaperVC
                        params:@{@"userId":userId ? userId : @""}
             shouldCacheTarget:NO
            ];
}

/**
 获取认领论文控制器
 
 @param userId 用户id
 @return 认领论文
 */
- (UIViewController *)getClaimPaperVCWithUserId:(NSString *)userId
{
    return [self performTarget:kCTMediatorTargetPM
                        action:kCTMediatorActionGetClaimPaperVC
                        params:@{@"userId":userId ? userId : @""}
             shouldCacheTarget:NO
            ];
}

@end

