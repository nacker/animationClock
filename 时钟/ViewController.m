//
//  ViewController.m
//  时钟
//
//  Created by nacker on 16/5/11.
//  Copyright © 2016年 帶頭二哥 QQ:648959. All rights reserved.
//

#define perSecondA 6

#define perMinA 6

#define perHourA 30

#define angle2Rad(angle) ((angle) / 180.0 * M_PI)

#define perMinHourA 0.5


#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *clockView;

@property (nonatomic, weak) CALayer *secLayer;

@property (nonatomic, weak) CALayer *minLayer;

@property (nonatomic, weak) CALayer *hourLayer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加时针
    [self addHour];
    
    //添加分针
    [self addMinute];
    
    //添加秒针
    [self addSecond];
    
    //添加定时器, 让秒针每一秒都做旋转操作
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
    
    //手动调用
    [self timeChange];
}

//每一秒调用一次
- (void)timeChange{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *cmp = [calendar components:NSCalendarUnitSecond | NSCalendarUnitMinute | NSCalendarUnitHour fromDate:[NSDate date]];
    NSInteger curSec = cmp.second;
    NSInteger curMin = cmp.minute;
    NSInteger curHour = cmp.hour;
    CGFloat secondA = curSec * perSecondA;
    self.secLayer.transform = CATransform3DMakeRotation(angle2Rad(secondA), 0, 0, 1);
    CGFloat minuteA = curMin * perMinA;
    self.minLayer.transform = CATransform3DMakeRotation(angle2Rad(minuteA), 0, 0, 1);
    CGFloat hourA = curHour * perHourA + curMin * perMinHourA;
    self.hourLayer.transform = CATransform3DMakeRotation(angle2Rad(hourA), 0, 0, 1);
}


//添加秒针
- (void)addSecond{
    CALayer *layer = [CALayer layer];
    layer.backgroundColor = [UIColor redColor].CGColor;
    layer.bounds = CGRectMake(0, 0, 1, 80);
    layer.position = CGPointMake(self.clockView.bounds.size.width * 0.5, self.clockView.bounds.size.height * 0.5);
    layer.anchorPoint = CGPointMake(0.5, 1);
    self.secLayer = layer;
    [self.clockView.layer addSublayer:layer];
}

//添加分针
- (void)addMinute{
    CALayer *layer = [CALayer layer];
    layer.backgroundColor = [UIColor blackColor].CGColor;
    layer.bounds = CGRectMake(0, 0, 3, 70);
    layer.position = CGPointMake(self.clockView.bounds.size.width * 0.5, self.clockView.bounds.size.height * 0.5);
    layer.anchorPoint = CGPointMake(0.5, 1);
    self.minLayer = layer;
    [self.clockView.layer addSublayer:layer];
}


//添加时针
- (void)addHour{
    CALayer *layer = [CALayer layer];
    layer.backgroundColor = [UIColor blackColor].CGColor;
    layer.bounds = CGRectMake(0, 0, 3, 60);
    layer.position = CGPointMake(self.clockView.bounds.size.width * 0.5, self.clockView.bounds.size.height * 0.5);
    layer.anchorPoint = CGPointMake(0.5, 1);
    self.hourLayer = layer;
    [self.clockView.layer addSublayer:layer];
    
}

@end
