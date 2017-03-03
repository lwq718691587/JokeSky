//
//  OCAboutUSTableViewCell.m
//  Oracleen_Scrum
//
//  Created by 刘伟强 on 16/6/6.
//  Copyright © 2016年 周强. All rights reserved.
//

#import "OCAboutUSTableViewCell.h"
#import "LQMacro.h"
@implementation OCAboutUSTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        CGFloat cellHeight = SFhy(116/2);
        self.cusTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake( SFwx(16), 0, SFwx(200), SFhy(17))];
        self.cusTitleLabel.font = AppFontOfSize(16);
        self.cusTitleLabel.textColor = HexColor(@"2e3d4b");
        self.cusTitleLabel.centerY = cellHeight/2;
        [self addSubview:self.cusTitleLabel];
        
        self.cusSubTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(SFwx(16), 0, SFwx(200), SFhy(17))];
        self.cusSubTitleLabel.right = ScreenWidth - 40;
        self.cusSubTitleLabel.font = AppFontOfSize(16);
        self.cusSubTitleLabel.textColor = HexColor(@"2e3d4b");
        self.cusSubTitleLabel.centerY = cellHeight/2;
        self.cusSubTitleLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.cusSubTitleLabel];
        
        
        UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(0,cellHeight-0.5, ScreenWidth, 0.5)];
        lineView.backgroundColor = HexColor(@"e6e6e6");
        [self addSubview:lineView];
    }
    return self;
}


@end
