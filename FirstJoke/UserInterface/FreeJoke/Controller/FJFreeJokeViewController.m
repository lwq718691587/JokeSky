//
//  FJFreeJokeViewController.m
//  FirstJoke
//
//  Created by 刘伟强 on 2017/2/8.
//  Copyright © 2017年 刘伟强. All rights reserved.
//

#import "FJFreeJokeViewController.h"
#import "FJFreeJokeModel.h"
#import "FJFreeJokeTableViewCell.h"
@interface FJFreeJokeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView *freeJokeTableView;
@property (strong, nonatomic) NSMutableArray *dataArr;
@property (nonatomic) NSInteger pageNumber;
@end

@implementation FJFreeJokeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageNumber = 1;
    [self createTableView];
    [self update:self.pageNumber];
    // Do any additional setup after loading the view.
}


- (void)update:(NSInteger )pagenumber{
  
    if ([self.type isEqualToString:@"免费"]) {
        [FJFreeJokeModel getjokeListOfPageNum:pagenumber Success:^(NSMutableArray *dataArr) {
            if (pagenumber == 1) {
                self.dataArr = dataArr;
            }else{
                [self.dataArr addObjectsFromArray:dataArr];
            }
            [self.freeJokeTableView reloadData];
            [self.freeJokeTableView.mj_header endRefreshing];
            [self.freeJokeTableView.mj_footer endRefreshing];
        } failure:^{
            
            [self.freeJokeTableView.mj_header endRefreshing];
            [self.freeJokeTableView.mj_footer endRefreshing];
        }];
    }else{
        [FJFreeJokeModel getjokeListOfPageNum:pagenumber+15 Success:^(NSMutableArray *dataArr) {
            if (pagenumber == 1) {
                self.dataArr = dataArr;
            }else{
                [self.dataArr addObjectsFromArray:dataArr];
            }
            [self.freeJokeTableView reloadData];
            [self.freeJokeTableView.mj_header endRefreshing];
            [self.freeJokeTableView.mj_footer endRefreshing];
        } failure:^{
            [self.freeJokeTableView.mj_header endRefreshing];
            [self.freeJokeTableView.mj_footer endRefreshing];
        }];
    }
}

//创建tableView
-(void)createTableView
{
    self.freeJokeTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0 , self.view.bounds.size.width, self.view.bounds.size.height - 64 - 44) style:UITableViewStylePlain];
    self.freeJokeTableView.delegate = self;
    self.freeJokeTableView.dataSource =self;
    self.freeJokeTableView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:self.freeJokeTableView];
    
    MJRefreshNormalHeader* header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.pageNumber = 1;
        [self update:self.pageNumber];
    }];
    [header setTitle:@"下拉开始刷新" forState:MJRefreshStateIdle];
    [header setTitle:@"松开以进行刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"刷新中 ..." forState:MJRefreshStateRefreshing];
    self.freeJokeTableView.mj_header = header;
    
    self.freeJokeTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.pageNumber++;
        [self update:self.pageNumber];
    }];

}

//设置row的个数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
//设置cell的内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *PickViewCell=@"PickViewCell";
    FJFreeJokeTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:PickViewCell];
    if (cell==nil) {
        cell = [[FJFreeJokeTableViewCell  alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:PickViewCell];
        cell.backgroundColor = [UIColor clearColor];
    }
    cell.model = self.dataArr[indexPath.row];
    return cell;
}
//设置cell的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FJFreeJokeModel *model = self.dataArr[indexPath.row];
    if (model.cellHeight == 0 ) {
        model.cellHeight = [FJFreeJokeTableViewCell getCellHeight:model];
    }
    return model.cellHeight;

}
//cell的点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
