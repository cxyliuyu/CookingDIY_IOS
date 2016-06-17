//
//  FoodUITableViewCell.m
//  CookingDIY_IOS
//
//  Created by admin on 16/5/7.
//  Copyright © 2016年 cxyliuyu. All rights reserved.
//

#import "FoodUITableViewCell.h"
#import "UIImageView+WebCache.h"
#import "FoodDetailViewController.h"
#import "UIColor+ZXLazy.h"
#import "FoodListViewController.h"

#define SCREENWIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREENHEIGHT [[UIScreen mainScreen] bounds].size.height

@interface FoodUITableViewCell(){
    UIButton *cellButton;
    UIImageView *foodImageView;
    UILabel *foodNameLabel;
    UILabel *contentLabel;
}
@end
@implementation FoodUITableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
     self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
}

-(NSInteger)setFoodImgImageView:(NSString *)foodImg foodNameLabel:(NSString *)foodName contentLabel:(NSString *)content foodId:(NSInteger)foodId{
    //cellButton = [[UIButton alloc]initWithFrame:CGRectMake(5, 5, SCREENWIDTH-10, 230)];
    cellButton = [UIButton new];
    foodImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH-10, 150)];
    foodNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 150, SCREENWIDTH-10, 20)];
    //contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 170, SCREENWIDTH-10, 28)];
    contentLabel = [UILabel new];
    //contentLabel.font = [UIFont fontWithName:@"Helvetica" size:12];
    contentLabel.numberOfLines = 0;
    contentLabel.lineBreakMode = UILineBreakModeWordWrap;
    contentLabel.textColor = [UIColor colorWithHexString:@"#A9A9A9"];
    foodNameLabel.text = foodName;
    contentLabel.text = content;
    [foodImageView sd_setImageWithURL:[[NSURL alloc]initWithString: foodImg]];
    cellButton.tag = foodId;
    [cellButton addTarget:self action:@selector(toDetailView:) forControlEvents:UIControlEventTouchUpInside];
    UIFont *font = [UIFont fontWithName:@"Helvetica" size:14];
    contentLabel.font = font;
    CGSize size = CGSizeMake(SCREENWIDTH-10, CGFLOAT_MAX);
    CGSize labelSize = [content sizeWithFont:font constrainedToSize:size lineBreakMode:contentLabel.lineBreakMode];
    contentLabel.frame = CGRectMake(0, 170, SCREENWIDTH-10, labelSize.height);
    cellButton.frame = CGRectMake(5, 5, SCREENWIDTH-10, 180+labelSize.height);
    //cellButton.backgroundColor = [UIColor redColor];
    
    [cellButton addSubview:foodImageView];
    [cellButton addSubview:foodNameLabel];
    [cellButton addSubview:contentLabel];
    [self.contentView addSubview:cellButton];
    return labelSize.height;
}

- (void)toDetailView:(UIButton *)btn{
    //前往菜谱详情页面
    NSLog(@"前往显示详情页面，foodId = %ld",btn.tag);
    FoodDetailViewController *foodDetailviewController = [[FoodDetailViewController alloc]init];
    foodDetailviewController.foodId = btn.tag;
    //[self.na]
    //[self.navigationController pushViewController:foodDetailviewController animated:YES];
    if (_foodListViewController != nil) {
        [_foodListViewController presentViewController:foodDetailviewController animated:YES completion:nil];
    }else{
        [self.window.rootViewController presentViewController:foodDetailviewController animated:YES completion:nil];
    }

   
}

@end
