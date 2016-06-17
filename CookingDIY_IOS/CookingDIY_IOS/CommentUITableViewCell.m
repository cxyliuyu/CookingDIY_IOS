//
//  CommentUITableViewCell.m
//  CookingDIY_IOS
//
//  Created by admin on 16/6/16.
//  Copyright © 2016年 cxyliuyu. All rights reserved.
//

#import "CommentUITableViewCell.h"
#import "UIImageView+WebCache.h"
#import "UIColor+ZXLazy.h"
#import "FoodDetailViewController.h"

#define SCREENWIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREENHEIGHT [[UIScreen mainScreen] bounds].size.height
@interface CommentUITableViewCell(){
    UIButton *cellButton;
    UIImageView *userImgView;
    UILabel *userNameLabel;
    UILabel *contentLabel;
    UILabel *timeLabel;
    //NSString *foodId;
}
@end
@implementation CommentUITableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
}

- (NSInteger)setUserImgView:(NSString *)userImg userNameView:(NSString *)userName ContentView:(NSString *) content timeView:(NSString *)time{
    cellButton = [UIButton new];
    userImgView = [UIImageView new];
    
    contentLabel = [UILabel new];
    timeLabel = [UILabel new];
    userNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 5, SCREENWIDTH-80,30)];
    NSLog(@"userName = %@",userName);
    contentLabel.numberOfLines = 0;
    contentLabel.lineBreakMode = UILineBreakModeWordWrap;
    userNameLabel.text = userName;
    contentLabel.text = content;
    timeLabel.text = [self timeStamp:time];
    [userImgView sd_setImageWithURL:[[NSURL alloc]initWithString:userImg]];
    
    userImgView.layer.cornerRadius = 25;
    userImgView.layer.borderWidth = 2;
    userImgView.layer.borderColor = [UIColor colorWithHexString:@"#eeeeee"].CGColor;
    userImgView.layer.masksToBounds = YES;
    
    UIFont *font = [UIFont fontWithName:@"Helvetica" size:14];
    contentLabel.font = font;
    CGSize size = CGSizeMake(SCREENWIDTH-10, CGFLOAT_MAX);
    CGSize labelSize = [content sizeWithFont:font constrainedToSize:size lineBreakMode:contentLabel.lineBreakMode];
    
    userImgView.frame = CGRectMake(5, ((50+labelSize.height)-50)/2, 50, 50);
    
    contentLabel.frame = CGRectMake(80, 31, SCREENWIDTH-80, labelSize.height);
    timeLabel.frame = CGRectMake(80,30+labelSize.height,SCREENWIDTH-80,20);
    cellButton.frame = CGRectMake(5, 5, SCREENWIDTH-10, 50+labelSize.height);
    
    timeLabel.font = [UIFont fontWithName:@"Helvetica" size:12];
    timeLabel.textColor = [UIColor colorWithHexString:@"A9A9A9"];
    userNameLabel.textColor = [UIColor colorWithHexString:@"339933"];
                       
    [cellButton addSubview:userImgView];
    [cellButton addSubview:contentLabel];
    [cellButton addSubview:userNameLabel];
    [cellButton addSubview:timeLabel];
    [self.contentView addSubview:cellButton];
    
    if (_foodId != nil) {
        [cellButton addTarget:self action:@selector(toFoodDetail) forControlEvents:UIControlEventTouchUpInside];
    }
    return labelSize.height;
}

- (NSString *)timeStamp:(NSString *)str{
    NSTimeInterval time=[str doubleValue]+28800;
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    NSLog(@"date:%@",[detaildate description]);
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    return currentDateStr;
}

- (void)toFoodDetail{
    FoodDetailViewController *foodDetailviewController = [[FoodDetailViewController alloc]init];
    foodDetailviewController.foodId =  [_foodId intValue];
    NSLog(@"foodId = %@",_foodId);
    [self.window.rootViewController presentViewController:foodDetailviewController animated:YES completion:nil];
}



@end
