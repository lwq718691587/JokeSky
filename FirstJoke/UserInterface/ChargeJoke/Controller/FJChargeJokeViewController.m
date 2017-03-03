//
//  FJChargeJokeViewController.m
//  FirstJoke
//
//  Created by 刘伟强 on 2017/2/8.
//  Copyright © 2017年 刘伟强. All rights reserved.
//

#import "FJChargeJokeViewController.h"
#import "FJChargeJokeModel.h"
#import "FJChargeJokeTableViewCell.h"
#import "LQFullscreenImageViewController.h"

#import <StoreKit/StoreKit.h>
#import <UMMobClick/MobClick.h>


@interface FJChargeJokeViewController ()<UITableViewDelegate,UITableViewDataSource,FJChargeJokeTableViewCellDelegate,SKPaymentTransactionObserver,SKProductsRequestDelegate>
@property (strong, nonatomic) UITableView *chargeJokeTableView;
@property (strong, nonatomic) NSMutableArray *dataArr;
@property (nonatomic) NSInteger pageNumber;

@end

@implementation FJChargeJokeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pageNumber = 1;
    [self update:self.pageNumber];
    [self createTableView];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"购买" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemFun)];
    
     [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    
    // Do any additional setup after loading the view.
}

- (void)update:(NSInteger )pagenumber{
    [FJChargeJokeModel getjokeListOfPageNum:pagenumber Success:^(NSMutableArray *dataArr) {
        self.dataArr = dataArr;
        [self.chargeJokeTableView reloadData];
        [self.chargeJokeTableView.mj_header endRefreshing];
        [self.chargeJokeTableView.mj_footer endRefreshing];
    } failure:^{
        [self.chargeJokeTableView.mj_header endRefreshing];
        [self.chargeJokeTableView.mj_footer endRefreshing];
    }];
}

//创建tableView
-(void)createTableView
{
    self.chargeJokeTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0 , self.view.bounds.size.width, self.view.bounds.size.height - 64 - 44) style:UITableViewStylePlain];
    self.chargeJokeTableView.delegate = self;
    self.chargeJokeTableView.dataSource =self;
    self.chargeJokeTableView.backgroundColor=[UIColor clearColor];
    
    self.chargeJokeTableView.rowHeight = SFhy(260);
    [self.view addSubview:self.chargeJokeTableView];
}

//设置row的个数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
//设置cell的内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *PickViewCell=@"PickViewCell";
    FJChargeJokeTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:PickViewCell];
    if (cell==nil) {
        cell = [[FJChargeJokeTableViewCell  alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:PickViewCell];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.backgroundColor = [UIColor clearColor];
    }
    cell.delegate = self;
    cell.model = self.dataArr[indexPath.row];
    return cell;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"一元5条笑话，购买立即获得更多快乐";
}

-(void)tapFunDelegate:(UIImageView *)iv{
    UIImageView * cell = iv;
    LQFullscreenImageViewController * vc = [[LQFullscreenImageViewController alloc]init];
    vc.liftedImageView = cell;
    [self presentViewController:vc animated:YES completion:nil];
}
//cell的点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(void)rightBarButtonItemFun{
    NSString *product = product1_ID;
    if([SKPaymentQueue canMakePayments]){
        [self requestProductData:product];
    }else{
        NSLog(@"不允许程序内付费");
    }

}

//请求商品
- (void)requestProductData:(NSString *)type{
    NSLog(@"-------------请求对应的产品信息----------------");
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD showWithStatus:nil];
    
    NSArray *product = [[NSArray alloc] initWithObjects:type,nil];
    NSSet *nsset = [NSSet setWithArray:product];
    SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:nsset];
    request.delegate = self;
    [request start];
    
}

//收到产品返回信息
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response{
    NSLog(@"--------------收到产品反馈消息---------------------");
    NSArray *product = response.products;
    if([product count] == 0){
        [SVProgressHUD dismiss];
        NSLog(@"--------------没有商品------------------");
        return;
    }
    
    NSLog(@"productID:%@", response.invalidProductIdentifiers);
    NSLog(@"产品付费数量:%lu",(unsigned long)[product count]);
    
    SKProduct *p = nil;
    for (SKProduct *pro in product) {
        NSLog(@"%@", [pro description]);
        NSLog(@"%@", [pro localizedTitle]);
        NSLog(@"%@", [pro localizedDescription]);
        NSLog(@"%@", [pro price]);
        NSLog(@"%@", [pro productIdentifier]);
        if([pro.productIdentifier isEqualToString:product1_ID]){
            p = pro;
        }
    }
    SKPayment *payment = [SKPayment paymentWithProduct:p];
    NSLog(@"发送购买请求");
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}

//请求失败
- (void)request:(SKRequest *)request didFailWithError:(NSError *)error{
    [SVProgressHUD showErrorWithStatus:@"支付失败"];
    NSLog(@"------------------错误-----------------:%@", error);
}

- (void)requestDidFinish:(SKRequest *)request{
    [SVProgressHUD dismiss];
    NSLog(@"------------反馈信息结束-----------------");
}

/**
 *  验证购买，避免越狱软件模拟苹果请求达到非法购买问题
 *
 */
-(void)verifyPurchaseWithPaymentTransaction{
    //从沙盒中获取交易凭证并且拼接成请求体数据
    NSURL *receiptUrl=[[NSBundle mainBundle] appStoreReceiptURL];
    NSData *receiptData=[NSData dataWithContentsOfURL:receiptUrl];
    NSString *receiptString=[receiptData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];//转化为base64字符串
    NSString *bodyString = [NSString stringWithFormat:@"{\"receipt-data\" : \"%@\"}", receiptString];//拼接请求数据
    NSData *bodyData = [bodyString dataUsingEncoding:NSUTF8StringEncoding];
    //创建请求到苹果官方进行购买验证
    NSURL *url=[NSURL URLWithString:SANDBOX];
    NSMutableURLRequest *requestM=[NSMutableURLRequest requestWithURL:url];
    requestM.HTTPBody=bodyData;
    requestM.HTTPMethod=@"POST";
    //创建连接并发送同步请求
    NSError *error=nil;
    NSData *responseData=[NSURLConnection sendSynchronousRequest:requestM returningResponse:nil error:&error];
    if (error) {
        NSLog(@"验证购买过程中发生错误，错误信息：%@",error.localizedDescription);
        return;
    }
    NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:nil];
    if([dic[@"status"] intValue]==0){
        NSLog(@"购买成功！");
        [self update:++self.pageNumber];
        [MobClick event:@"FirstJoke_Purchase_oneRMB"];
    }else{
        NSLog(@"购买失败，未通过验证！");
    }
}
//监听购买结果
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transaction{
    
    for(SKPaymentTransaction *tran in transaction){
        switch (tran.transactionState) {
            case SKPaymentTransactionStatePurchased:{
                NSLog(@"交易完成");
                [self verifyPurchaseWithPaymentTransaction];
                [[SKPaymentQueue defaultQueue] finishTransaction:tran];
            }
                break;
            case SKPaymentTransactionStatePurchasing:
                NSLog(@"商品添加进列表");
                break;
            case SKPaymentTransactionStateRestored:{
                NSLog(@"已经购买过商品");
                [[SKPaymentQueue defaultQueue] finishTransaction:tran];
            }
                break;
            case SKPaymentTransactionStateFailed:{
                [[SKPaymentQueue defaultQueue] finishTransaction:tran];
                [SVProgressHUD setMinimumDismissTimeInterval:1];
                [SVProgressHUD showErrorWithStatus:@"购买失败"];
            }
                break;
            default:
                break;
        }
    }
}

- (void)dealloc{
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
}
@end
