//
//  FJFreeJokeModel.m
//  FirstJoke
//
//  Created by 刘伟强 on 2017/2/8.
//  Copyright © 2017年 刘伟强. All rights reserved.

#import "FJFreeJokeModel.h"

@implementation FJFreeJokeModel

+ (void)getjokeListOfPageNum:(NSUInteger)pageNum Success:(void(^)(NSMutableArray *dataArr))success failure:(void(^)())failure{

    [LQNetworkingRequest GET:[NSString stringWithFormat:@"http://japi.juhe.cn/joke/content/text.from?key=%@&page=%ld&pagesize=10",juheAppKey,pageNum] parameters:nil needCache:YES success:^(id operation, id responseObject) {
        NSMutableArray * dataArr = [[NSMutableArray alloc]init];
        NSString * str = [responseObject objectForKey:@"error_code"];
        int code = [str intValue];
        NSArray * arr = responseObject[@"result"][@"data"];
        
        if (str && code == 0 && arr.count != 0 && [arr isKindOfClass:[NSArray class]]) {
       
            for (NSDictionary * perDic in arr) {
                FJFreeJokeModel *model = [[FJFreeJokeModel alloc]init];
                model.content = perDic[@"content"];
                model.content = [model.content stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
                model.time = perDic[@"updatetime"];
                [dataArr addObject:model];
            }
        }else{
            NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"FJFree" ofType:@"plist"];
            NSMutableArray *data = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
            for (NSDictionary * perDic in data) {
                FJFreeJokeModel *model = [[FJFreeJokeModel alloc]init];
                model.content = perDic[@"content"];
                model.time = perDic[@"updatetime"];
                [dataArr addObject:model];
            }
        }
        success(dataArr);
    } failure:^(id operation, NSError *error) {
        failure();
    }];
}

@end
