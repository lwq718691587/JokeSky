//
//                         _oo8oo_
//                        o8888888o
//                        88" . "88
//                        (| -_- |)
//                        0\  =  /0
//                      ___/'==='\___
//                    .' \\|     |// '.
//                   / \\|||  :  |||// \
//                  / _||||| -:- |||||_ \
//                 |   | \\\  -  /// |   |
//                 | \_|  ''\---/''  |_/ |
//                 \  .-\__  '-'  __/-.  /
//               ___'. .'  /--.--\  '. .'___
//            ."" '<  '.___\_<|>_/___.'  >' "".
//           | | :  `- \`.:`\ _ /`:.`/ -`  : | |
//           \  \ `-.   \_ __\ /__ _/   .-` /  /
//       =====`-.____`.___ \_____/ ___.`____.-`=====
//                                  `=---=`
//
//
//       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//
//               佛祖保佑              永无bug
//  AppDelegate.h
//  FirstJoke
//
//  Created by 刘伟强 on 2017/2/8.
//  Copyright © 2017年 刘伟强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (assign, nonatomic) AFNetworkReachabilityStatus   networkStatus;

@end

