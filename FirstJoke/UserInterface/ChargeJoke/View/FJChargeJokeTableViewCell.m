//
//  FJChargeJokeTableViewCell.m
//  FirstJoke
//
//  Created by 刘伟强 on 2017/2/8.
//  Copyright © 2017年 刘伟强. All rights reserved.
//

#import "FJChargeJokeTableViewCell.h"

@interface FJChargeJokeTableViewCell ()

@property (strong, nonatomic) UILabel *custitleLable;
@property (strong, nonatomic) UILabel *timeLable;
@property (strong, nonatomic) UIImageView *cusImageView;

@end

@implementation FJChargeJokeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.custitleLable = [[UILabel alloc]initWithFrame:CGRectMake(SFwx(15), SFhy(10), ScreenWidth - SFwx(30), SFhy(15))];
        self.custitleLable.font = [UIFont systemFontOfSize:SFhy(15)];
        self.custitleLable.textColor = AppTitleColor;
        [self addSubview:self.custitleLable];
        
        self.cusImageView = [[UIImageView alloc]initWithFrame:CGRectMake(SFwx(10), self.custitleLable.bottom + SFhy(10), ScreenWidth - SFwx(20), SFhy(200))];
        [self.cusImageView setContentMode:UIViewContentModeScaleAspectFit];
        self.cusImageView.clipsToBounds = YES;
        self.cusImageView.userInteractionEnabled = YES;
        [self addSubview:self.cusImageView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapFun:)];
        [self.cusImageView addGestureRecognizer:tap];
        
        self.timeLable =[[UILabel alloc]initWithFrame:CGRectMake(SFwx(15), self.cusImageView.bottom + SFhy(5), ScreenWidth-SFwx(30), SFhy(13))];
        self.timeLable.textAlignment = NSTextAlignmentRight;
        self.timeLable.font = [UIFont systemFontOfSize:13];
        self.timeLable.textColor = AppTextColor;
        [self addSubview:self.timeLable];
        
    }
    return self;
}
- (void)setModel:(FJChargeJokeModel *)model{
    _model = model;
    self.custitleLable.text = model.title;
    self.timeLable.text = model.time;
    if ([model.imageUrl containsString:@"http"]) {
        [self.cusImageView sd_setImageWithURL:[NSURL URLWithString:model.imageUrl] placeholderImage:[UIImage imageNamed:@"timg.jpeg"] options:SDWebImageProgressiveDownload];
    }else{
        self.cusImageView.image = [UIImage imageNamed:model.imageUrl];
    }

}

- (void)tapFun:(UITapGestureRecognizer *)tap{
    if (self.delegate && [self.delegate respondsToSelector:@selector(tapFunDelegate:)]) {
        [self.delegate tapFunDelegate:(UIImageView *)tap.view];
    }
}
@end
