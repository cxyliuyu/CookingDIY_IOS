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
@property UISlider *choseTimeSlider;

@property UIButton *startButton;
@property UIButton *stopButton;
@property UIButton *pauseButton;
@property UIImageView *startImageView;
@property UIImageView *stopImageView;
@property UIImageView *pauseImageView;
@property UILabel *startLabel;
@property UILabel *stopLabel;
@property UILabel *pauseLabel;

@end
