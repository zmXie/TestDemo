//
//  CTMediator+PaperManagement.h
//  CTMediator
//
//  Created by xzm on 2018/8/27.
//

#import <CTMediator/CTMediator.h>

@interface CTMediator (PaperManagement)

/**
  获取我的论文控制器

 @param userId 用户id
 @return 我的论文
 */
- (UIViewController *)getMyPaperVCWithUserId:(NSString *)userId;

/**
 获取认领论文控制器
 
 @param userId 用户id
 @return 认领论文
 */
- (UIViewController *)getClaimPaperVCWithUserId:(NSString *)userId;

@end
