//
//  AlarmViewController.m
//  CookingDIY_IOS
//
//  Created by admin on 16/3/19.
//  Copyright © 2016年 cxyliuyu. All rights reserved.
//

#import "AlarmViewController.h"
#import "UIColor+ZXLazy.h"
#import "NSUserDefaultsUtil.h"

#define SCREENWIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREENHEIGHT [[UIScreen mainScreen] bounds].size.height

@interface AlarmViewController ()
{
    NSInteger time;
    NSTimer *timer;
    BOOL isStarted;
}

@end

@implementation AlarmViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    super.view.backgroundColor = [UIColor whiteColor];
    if (self) {
        self.navigationItem.title = @"计时";
        
        isStarted = NO;
        
        [self initView];
        
        [_pauseButton setUserInteractionEnabled:NO];//设置暂停按钮不可被点击
        [_startButton addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [_pauseButton addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [_stopButton addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)clickAction:(UIButton *)btn{
    //各种点击事件
    switch (btn.tag) {
        case 0:
            //NSLog(@"暂停按钮被点击了");
            _startButton.hidden = NO;
            _stopButton.hidden = YES;
            [timer invalidate];
            break;
        case 1:
            _startButton.hidden = YES;
            _stopButton.hidden = NO;
            _choseTimeView.hidden = YES;
            _timeLabel.hidden = NO;
            [_pauseButton setUserInteractionEnabled:YES];
            if (isStarted) {
                
            }else{
                [NSUserDefaultsUtil saveInteger:@"cxyliuyuCurrentTime" value:(time*60)];
                isStarted = YES;
            }
            timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timefired) userInfo:nil repeats:YES];
            [timer fire];
            break;
        case 2:
            //NSLog(@"停止按钮被点击了");
            _startButton.hidden = NO;
            _stopButton.hidden = YES;
            _choseTimeView.hidden = NO;
            _timeLabel.hidden = YES;
            [_pauseButton setUserInteractionEnabled:NO];
            [timer invalidate];
            isStarted = NO;
            break;
        default:
            break;
    }
    
}

-(void) timefired{
    //接收到计时器
    NSInteger currentTime = [NSUserDefaultsUtil getInteger:@"cxyliuyuCurrentTime"];
    //NSLog(@"%ld",currentTime);
    if (currentTime != 0) {
        currentTime -= 1;
        [NSUserDefaultsUtil saveInteger:@"cxyliuyuCurrentTime" value:currentTime];
        //如果本计时器正在被显示，通知更新页面.
        if (self.isViewLoaded) {
            [self refreshView:currentTime];
        }
    }else{
        //计时结束,如果当前页面正在被显示，提示结束
        if(self.isViewLoaded){
            //NSLog(@"计时结束");
            _startButton.hidden = NO;
            _stopButton.hidden = YES;
            _choseTimeView.hidden = NO;
            _timeLabel.hidden = YES;
            [_pauseButton setUserInteractionEnabled:NO];
            [timer invalidate];
            isStarted = NO;
        }
    }
    
    
}

-(void)refreshView:(NSInteger)currentTime{
    
    NSInteger minute = currentTime / 60;
    NSInteger second = currentTime % 60;
    NSString *minuteString;
    NSString *secondString;
    if (minute<10) {
        minuteString = [NSString stringWithFormat:@"0%ld:",minute];
    }else{
        minuteString = [NSString stringWithFormat:@"%ld:",minute];
    }
    if (second<10) {
        secondString = [NSString stringWithFormat: @"0%ld",second];
    }else{
        secondString = [NSString stringWithFormat: @"%ld",second];
    }
    NSString *timeString = [NSString stringWithFormat:@"%@%@",minuteString,secondString];
    _timeLabel.text = timeString;
    
    
}
- (void)initView{
    _topView = [UIView new];
    _topView.frame = CGRectMake(0, 65, SCREENWIDTH, (SCREENHEIGHT-65-60)/2);
    _topView.backgroundColor = [UIColor colorWithHexString:@"#99cc00"];
    
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
    _timeLabel.font = [UIFont fontWithName:@"Helvetica" size:65];
    _timeLabel.textColor = [UIColor whiteColor];
    _timeLabel.textAlignment = NSTextAlignmentCenter;
    
    [_choseTimeView addSubview:_choseTimeLabel];
    [_choseTimeView addSubview:_choseTimeSlider];
    [_topView addSubview:_choseTimeView];
    [_topView addSubview:_timeLabel];
    
    _timeLabel.hidden = YES;
    
    
    int pauseStartStopViewWidth = ((SCREENHEIGHT-65-60)/2)/2;
    
    //暂停相关控件的绘制
    _pauseButton = [UIButton new];
    _pauseButton.frame = CGRectMake(30, ((SCREENHEIGHT-65-60)/2)/4,pauseStartStopViewWidth , pauseStartStopViewWidth+10);
    //_pauseView.backgroundColor = [UIColor greenColor];
    _pauseImageView = [UIImageView new];
    _pauseImageView.frame = CGRectMake(10, 0, pauseStartStopViewWidth-20, pauseStartStopViewWidth-20);
    [_pauseImageView setImage:[UIImage imageNamed:@"pause"]];
    _pauseLabel = [UILabel new];
    _pauseLabel.frame = CGRectMake(0, pauseStartStopViewWidth-20, pauseStartStopViewWidth, 30);
    _pauseLabel.text = @"暂 停";
    _pauseLabel.textAlignment = NSTextAlignmentCenter;
    _pauseLabel.font = [UIFont fontWithName:@"Helvetica" size:25];
    _pauseLabel.textColor = [UIColor colorWithHexString:@"#339933"];
    [_pauseButton addSubview:_pauseImageView];
    [_pauseButton addSubview:_pauseLabel];
    _pauseButton.tag = 0;
    
    //开始相关控件的绘制
    _startButton = [UIButton new];
    _startButton.frame = CGRectMake(SCREENWIDTH-30-((SCREENHEIGHT-65-60)/2)/2, ((SCREENHEIGHT-65-60)/2)/4, pauseStartStopViewWidth, pauseStartStopViewWidth+10);
    _startImageView = [UIImageView new];
    _startImageView.frame = CGRectMake(10, 0, pauseStartStopViewWidth-20, pauseStartStopViewWidth-20);
    [_startImageView setImage:[UIImage imageNamed:@"start"]];
    _startLabel = [UILabel new];
    _startLabel.frame = CGRectMake(0, pauseStartStopViewWidth-20, pauseStartStopViewWidth, 30);
    _startLabel.text = @"开始";
    _startLabel.textAlignment = NSTextAlignmentCenter;
    _startLabel.font = [UIFont fontWithName:@"Helvetica" size:25];
    _startLabel.textColor = [UIColor colorWithHexString:@"#339933"];
    [_startButton addSubview:_startImageView];
    [_startButton addSubview:_startLabel];
    _startButton.tag = 1;
    
    //停止相关控件的绘制
    _stopButton = [UIButton new];
    _stopButton.frame = CGRectMake(SCREENWIDTH-30-((SCREENHEIGHT-65-60)/2)/2, ((SCREENHEIGHT-65-60)/2)/4, pauseStartStopViewWidth, pauseStartStopViewWidth);
    _stopImageView = [UIImageView new];
    _stopImageView.frame = CGRectMake(10, 0, pauseStartStopViewWidth-20, pauseStartStopViewWidth-20);
    [_stopImageView setImage:[UIImage imageNamed:@"stop1"]];
    _stopLabel = [UILabel new];
    _stopLabel.frame = CGRectMake(0, pauseStartStopViewWidth-20, pauseStartStopViewWidth, 30);
    _stopLabel.text = @"停止";
    _stopLabel.textAlignment = NSTextAlignmentCenter;
    _stopLabel.font = [UIFont fontWithName:@"Helvetica" size:25];
    _stopLabel.textColor = [UIColor colorWithHexString:@"#339933"];
    [_stopButton addSubview:_stopImageView];
    [_stopButton addSubview:_stopLabel];
    _stopButton.tag = 2;
    _stopButton.hidden = YES;
    
    
    [_bottomView addSubview:_pauseButton];
    [_bottomView addSubview:_startButton];
    [_bottomView addSubview:_stopButton];
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
