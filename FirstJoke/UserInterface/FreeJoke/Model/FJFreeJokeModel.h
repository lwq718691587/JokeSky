//
//  FJFreeJokeModel.h
//  FirstJoke
//
//  Created by 刘伟强 on 2017/2/8.
//  Copyright © 2017年 刘伟强. All rights reserved.
//

#import "BaseModel.h"

@interface FJFreeJokeModel : BaseModel

@property (nonatomic) CGFloat cellHeight;
@property (copy, nonatomic) NSString *content;
@property (copy, nonatomic) NSString *time;

+ (void)getjokeListOfPageNum:(NSUInteger)pageNum Success:(void(^)(NSMutableArray *dataArr))success failure:(void(^)())failure;

@end
