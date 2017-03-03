//
//  FJFreeJokeTableViewCell.h
//  FirstJoke
//
//  Created by 刘伟强 on 2017/2/8.
//  Copyright © 2017年 刘伟强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FJFreeJokeModel.h"
@interface FJFreeJokeTableViewCell : UITableViewCell

@property (strong, nonatomic) FJFreeJokeModel *model;

+ (CGFloat)getCellHeight:(FJFreeJokeModel *)model;

@end
