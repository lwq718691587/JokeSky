//
//  FJFreeJokeTableViewCell.m
//  FirstJoke
//
//  Created by 刘伟强 on 2017/2/8.
//  Copyright © 2017年 刘伟强. All rights reserved.
//

#import "FJFreeJokeTableViewCell.h"
#import "LQMacro.h"
@interface FJFreeJokeTableViewCell ()

@property (strong, nonatomic) UILabel *contentLable;
@property (strong, nonatomic) UILabel *timeLable;

@end

@implementation FJFreeJokeTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentLable = [[UILabel alloc]initWithFrame:CGRectMake(SFwx(15), SFhy(10), ScreenWidth - SFwx(30), 0)];
        self.contentLable.font = [UIFont systemFontOfSize:15];
        self.contentLable.textColor = AppTitleColor;
        [self addSubview:self.contentLable];
        self.timeLable =[[UILabel alloc]initWithFrame:CGRectMake(SFwx(15), SFhy(5), ScreenWidth-SFwx(30), SFhy(13))];
        self.timeLable.textAlignment = NSTextAlignmentRight;
        self.timeLable.font = [UIFont systemFontOfSize:13];
        self.timeLable.textColor = AppTextColor;
        [self addSubview:self.timeLable];
    }
    return self;
}

-(void)setModel:(FJFreeJokeModel *)model{
    _model = model;
    self.contentLable.text = model.content;
    [self.contentLable LQLabelAutoHeightWith:3];
    self.timeLable.top = self.contentLable.bottom + SFhy(5);
    self.timeLable.text = model.time;
}

+ (CGFloat)getCellHeight:(FJFreeJokeModel *)model{
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, ScreenWidth - 30, 0)];
    lable.font = [UIFont systemFontOfSize:15];
    lable.text = model.content;
    [lable LQLabelAutoHeightWith:3];
    return  lable.height + SFhy(35);
}

@end
