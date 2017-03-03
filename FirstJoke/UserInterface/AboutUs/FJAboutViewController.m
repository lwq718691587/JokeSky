//
//  FJAboutViewController.m
//  FirstJoke
//
//  Created by 刘伟强 on 2017/2/9.
//  Copyright © 2017年 刘伟强. All rights reserved.
//

#import "FJAboutViewController.h"
#import "OCAboutUSTableViewCell.h"
@interface FJAboutViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSArray * dataArr;
@property(nonatomic,strong)NSArray * dataArr2;
@end

@implementation FJAboutViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArr = @[@"应用名称",@"开发商",@"联系方式"];
    self.dataArr2 = @[@"笑翻天",@"LCTechnology",@"718691587(QQ)"];
    [self createViews];
    
}

-(void)createViews
{
    self.title = @"关于我们";
    [self addViews];
    [self createTableView];
}

-(void)addViews
{
    UIImageView * logoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, SFhy(50), SFwx(100),  SFhy(100))];
    logoImageView.image = [UIImage imageNamed:@"Freeicon.png"];
    logoImageView.centerX =ScreenWidth/2;
    [self.view addSubview:logoImageView];
    
    UILabel * verLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, logoImageView.bottom + SFhy(16), ScreenWidth, SFhy(12))];
    verLabel.textColor = HexColor(@"7f8282");
    verLabel.font = AppFontOfSize(12);
    verLabel.textAlignment = NSTextAlignmentCenter;
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // app版本
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    verLabel.text = [NSString stringWithFormat:@"笑翻天 Ver %@",app_Version];
    [self.view addSubview:verLabel];
    

}

//创建tableView
-(void)createTableView
{
    UITableView * aboutUsTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, SFhy(453/2), SFwx(350), SFhy(116*3/2)) style:UITableViewStylePlain];
    aboutUsTableView.centerX = ScreenWidth/2;
    aboutUsTableView.delegate = self;
    aboutUsTableView.dataSource =self;
    aboutUsTableView.backgroundColor=[UIColor clearColor];
    aboutUsTableView.layer.cornerRadius = 5;
    aboutUsTableView.layer.borderColor = HexColor(@"e6e6e6").CGColor;
    aboutUsTableView.layer.borderWidth = 0.5;
    //tableview滚动到头是否有反弹效果
    aboutUsTableView.bounces=NO;
    //cell分割线的风格
    [aboutUsTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:aboutUsTableView];
}

//设置row的个数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
//设置cell的内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *PickViewCell=@"PickViewCell";
    OCAboutUSTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:PickViewCell];
    if (cell==nil) {
        cell = [[OCAboutUSTableViewCell  alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PickViewCell];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    cell.cusTitleLabel.text = self.dataArr[indexPath.row];
    cell.cusSubTitleLabel.text = self.dataArr2[indexPath.row];
    return cell;
}
//设置cell的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SFhy(116/2);
}

@end
