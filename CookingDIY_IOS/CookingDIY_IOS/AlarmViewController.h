//
//  AlarmViewController.h
//  CookingDIY_IOS
//
//  Created by admin on 16/3/19.
//  Copyright © 2016年 cxyliuyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlarmViewController : UIViewController
@property UIView *topView;
@property UIView *bottomView;

@property UILabel *timeLabel;

@property UIView *choseTimeView;
@property UILabel *choseTimeLabel;
@property UISlider *timeSlider;

@property UIView *startView;
@property UIView *stopView;
@property UIView *pauseView;
@property UIButton *startButton;
@property UIButton *stopButton;
@property UIButton *pauseButton;
@property UILabel *startLabel;
@property UILabel *stopLabel;
@property UILabel *pauseLabel;

@end
