//
//  FJChargeJokeModel.h
//  FirstJoke
//
//  Created by 刘伟强 on 2017/2/8.
//  Copyright © 2017年 刘伟强. All rights reserved.
//

#import "BaseModel.h"

@interface FJChargeJokeModel : BaseModel

@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *time;
@property (copy, nonatomic) NSString *imageUrl;

+ (void)getjokeListOfPageNum:(NSUInteger)pageNum Success:(void(^)(NSMutableArray *dataArr))success failure:(void(^)())failure;

@end
