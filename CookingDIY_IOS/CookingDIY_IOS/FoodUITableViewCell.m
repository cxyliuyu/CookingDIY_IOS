//
//  FoodUITableViewCell.m
//  CookingDIY_IOS
//
//  Created by admin on 16/5/7.
//  Copyright © 2016年 cxyliuyu. All rights reserved.
//

#import "FoodUITableViewCell.h"

#define SCREENWIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREENHEIGHT [[UIScreen mainScreen] bounds].size.height

@interface FoodUITableViewCell()
@property UIImageView *foodImgImageView;   //食谱图片
@property UILabel *foodNameLabel;      //食谱名字
@property UILabel *contentLabel;       //食谱内容
@property NSOperationQueue* operationQueue;
@property NSString *imageURl;
@end
@implementation FoodUITableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
     self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

-(void)initView{
    //初始化视图
    _foodImgImageView = [UIImageView new];
    _foodNameLabel = [UILabel new];
    _contentLabel = [UILabel new];
    _foodImgImageView.frame = CGRectMake(5,  5, SCREENWIDTH-10, 150);
    _foodNameLabel.frame = CGRectMake(5, 160, SCREENWIDTH-10, 20);
    _contentLabel.frame = CGRectMake(5, 180, SCREENWIDTH-20, 14);
    _operationQueue = [[NSOperationQueue alloc] init];
    [self.contentView addSubview:_foodImgImageView];
    [self.contentView addSubview:_foodNameLabel];
    [self.contentView addSubview:_contentLabel];
    
}

-(void)setFoodImgImageView:(NSString *)foodImg foodNameLabel:(NSString *)foodName contentLabel:(NSString *)content{
    NSLog(@"1%@2%@3%@",foodImg,foodName,content);
    //同步方式加载图片，用户体验不好。放弃它
    //_foodImgImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:foodImg]]];
    _imageURl = foodImg;
    NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(downloadImage) object:nil];
    [_operationQueue addOperation:op];
    _foodNameLabel.text = foodName;
    if([content isEqual:nil]){
        NSLog(@"content == null");
        _contentLabel.text = @"";
    }else{
        NSLog(@"content != null");
        _contentLabel.text = content;
    }
    [_contentLabel setNumberOfLines:1];
}
- (void)downloadImage
{
    NSLog(@"imgURL = %@",_imageURl);
    NSURL *imageUrl = [NSURL URLWithString:_imageURl];
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl]];
    _foodImgImageView.image = image;
}
@end
