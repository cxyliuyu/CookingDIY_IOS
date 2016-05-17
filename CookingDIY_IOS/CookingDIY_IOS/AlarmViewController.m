//
//  AlarmViewController.m
//  CookingDIY_IOS
//
//  Created by admin on 16/3/19.
//  Copyright © 2016年 cxyliuyu. All rights reserved.
//

#import "AlarmViewController.h"
#import "UIColor+ZXLazy.h"

#define SCREENWIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREENHEIGHT [[UIScreen mainScreen] bounds].size.height

@interface AlarmViewController ()
{
    int time;
}

@end

@implementation AlarmViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    super.view.backgroundColor = [UIColor whiteColor];
    if (self) {
        self.navigationItem.title = @"计时";
    }
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initView{
    _topView = [UIView new];
    _topView.frame = CGRectMake(0, 65, SCREENWIDTH, (SCREENHEIGHT-65-60)/2);
    _topView.backgroundColor = [UIColor colorWithHexString:@"#6bd403"];
    
    _bottomView = [UIView new];
    _bottomView.frame = CGRectMake(0, (SCREENHEIGHT/2)+1, SCREENWIDTH, (SCREENHEIGHT-65-60)/2);
    //_bottomView.backgroundColor = [UIColor colorWithHexString:@"#ff0000"];
    
    //时间选择器布局
    _choseTimeView = [UIView new];
    _choseTimeView.frame =CGRectMake(0, ((SCREENHEIGHT-65-60)/2)/3-10, SCREENWIDTH, ((SCREENHEIGHT-65-60)/2)/3+10);
    //_choseTimeView.backgroundColor = [UIColor redColor];
    
    _choseTimeLabel =[UILabel new];
    _choseTimeLabel.frame = CGRectMake(0, 0, SCREENWIDTH, 40);
    _choseTimeLabel.text = @"计时时间(30分钟)";
    _choseTimeLabel.textAlignment = NSTextAlignmentCenter;//文字居中
    _choseTimeLabel.textColor = [UIColor whiteColor];
    _choseTimeLabel.font = [UIFont fontWithName:@"Helvetica" size:24];
    
    _choseTimeSlider = [UISlider new];
    _choseTimeSlider = [UISlider new];
    _choseTimeSlider.frame = CGRectMake(10, 40, SCREENWIDTH-20, 40);
    _choseTimeSlider.minimumValue = 1;
    _choseTimeSlider.maximumValue = 60;
    _choseTimeSlider.value = 30;
    time = 30;
    _choseTimeSlider.minimumTrackTintColor = [UIColor whiteColor];
    _choseTimeSlider.thumbTintColor=[UIColor greenColor];
    [_choseTimeSlider addTarget:self action:@selector(sliderChange:) forControlEvents:UIControlEventValueChanged];
    
    _timeLabel = [UILabel new];
    _timeLabel.frame = CGRectMake(0, ((SCREENHEIGHT-65-60)/2)/3-10, SCREENWIDTH, ((SCREENHEIGHT-65-60)/2)/3+10);
    _timeLabel.text = @"00:00";
    _timeLabel.font = [UIFont fontWithName:@"Helvetica" size:45];
    _timeLabel.textColor = [UIColor whiteColor];
    _timeLabel.textAlignment = NSTextAlignmentCenter;
    
    [_choseTimeView addSubview:_choseTimeLabel];
    [_choseTimeView addSubview:_choseTimeSlider];
    [_topView addSubview:_choseTimeView];
    [_topView addSubview:_timeLabel];
    
    _timeLabel.hidden = YES;
    
    
    int pauseStartStopViewWidth = ((SCREENHEIGHT-65-60)/2)/2;
    //暂停相关控件的绘制
    _pauseView = [UIView new];
    _pauseView.frame = CGRectMake(30, ((SCREENHEIGHT-65-60)/2)/4,pauseStartStopViewWidth , pauseStartStopViewWidth);
    [_bottomView addSubview:_pauseView];
    _pauseImageView = [UIImageView new];
    _pauseImageView.frame = CGRectMake(0, 10, pauseStartStopViewWidth-20, pauseStartStopViewWidth-20);
    [_pauseImageView setImage:[UIImage imageNamed:@"pause"]];
    
    _pauseLabel = [UILabel new];
    _pauseLabel.frame = CGRectMake(0, pauseStartStopViewWidth-20, pauseStartStopViewWidth, 20);
    _pauseLabel.text = @"暂停";
    _pauseLabel.textAlignment = NSTextAlignmentCenter;
    [_pauseView addSubview:_pauseImageView];
    [_pauseView addSubview:_pauseLabel];
    
    //开始相关控件的绘制
    _startView = [UIView new];
    _startView.frame = CGRectMake(SCREENWIDTH-30-((SCREENHEIGHT-65-60)/2)/2, ((SCREENHEIGHT-65-60)/2)/4, pauseStartStopViewWidth, pauseStartStopViewWidth);
    [_bottomView addSubview:_startView];
    
    //停止相关控件的绘制
    _stopView = [UIView new];
    _stopView.frame = CGRectMake(SCREENWIDTH-30-((SCREENHEIGHT-65-60)/2)/2, ((SCREENHEIGHT-65-60)/2)/4, pauseStartStopViewWidth, pauseStartStopViewWidth);
    [_bottomView addSubview:_stopView];
    _stopView.hidden = YES;
    
    [self.view addSubview:_topView];
    [self.view addSubview:_bottomView];
}

-(IBAction)sliderChange:(id)sender{
    int value = _choseTimeSlider.value;
    time = value;
    if(value<10){
        NSString *string = [[NSString alloc] initWithFormat:@"计时时间(0%d分钟)", value];
        _choseTimeLabel.text = string;
    }else{
        NSString *string = [[NSString alloc] initWithFormat:@"计时时间(%d分钟)", value];
        _choseTimeLabel.text = string;
    }
    
}

@end
