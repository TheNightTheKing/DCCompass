//
//  ViewController.m
//  简易指南针
//
//  Created by hh on 16/3/11.
//  Copyright © 2016年 zhuangChuangTiYu. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>
@interface ViewController ()<CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *compassImageView;
/** 位置管理者 */
@property (nonatomic,strong)CLLocationManager *manager;

@end

@implementation ViewController

- (CLLocationManager *)manager
{
    if (!_manager) {
        _manager=[[CLLocationManager alloc] init];
        _manager.delegate=self;
        // 每隔多少度更新一次
        _manager.headingFilter = 2;
    }
    return _manager;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 开始监听设备朝向
    [self.manager startUpdatingHeading];
}


#pragma mark -CLLocationManagerDelegate
/**
 *  获取到手机朝向时调用
 *
 *  @param manager    位置管理者
 *  @param newHeading 朝向对象
 */
-(void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
{
    /**
     *  CLHeading
     *  magneticHeading : 磁北角度
     *  trueHeading : 真北角度
     */
    NSLog(@"%f", newHeading.magneticHeading);
    
    CGFloat angle = newHeading.magneticHeading;
    // 把角度转弧度
    CGFloat angleR = angle / 180.0 * M_PI;
    // 旋转图片
    [UIView animateWithDuration:0.25 animations:^{
        self.compassImageView.transform = CGAffineTransformMakeRotation(-angleR);
    }];


}












@end
