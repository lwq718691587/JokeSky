//
//  FJChargeJokeTableViewCell.h
//  FirstJoke
//
//  Created by 刘伟强 on 2017/2/8.
//  Copyright © 2017年 刘伟强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FJChargeJokeModel.h"

@protocol FJChargeJokeTableViewCellDelegate <NSObject>

-(void)tapFunDelegate:(UIImageView *)iv;

@end

@interface FJChargeJokeTableViewCell : UITableViewCell

@property (strong, nonatomic) FJChargeJokeModel *model;

@property (nonatomic) id<FJChargeJokeTableViewCellDelegate> delegate;

@end
