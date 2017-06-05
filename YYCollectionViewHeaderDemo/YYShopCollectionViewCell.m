//
//  YYShopCollectionViewCell.m
//  YYCollectionViewHeaderDemo
//
//  Created by Ryan on 2017/6/5.
//  Copyright © 2017年 Ryan. All rights reserved.
//

#import "YYShopCollectionViewCell.h"

@interface YYShopCollectionViewCell ()

/* <#description#> */
@property (nonatomic,strong) UIImageView *imageView;
/* <#description#> */
@property (nonatomic,strong) UILabel *originLabal;
/* <#description#> */
@property (nonatomic,strong) UILabel *nowLabel;

@end

@implementation YYShopCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderWidth = 1;
        self.layer.borderColor = [UIColor redColor].CGColor;
        [self configLayout];
    }
    
    return self;
}

- (void)configLayout {
    
    CGFloat imageW = self.frame.size.width;
//    CGFloat imageH = 0.6 * self.frame.size.height;
//    CGFloat titleH = 0.2 * self.frame.size.height;
    CGFloat titleH = 20;
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, imageW, imageW)];
    [self addSubview:self.imageView];
    
    self.originLabal = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.imageView.frame), imageW, titleH)];
    self.originLabal.textAlignment = NSTextAlignmentCenter;
    self.originLabal.font = [UIFont systemFontOfSize:16];
    self.originLabal.text = @"$15.99";
    self.originLabal.textColor = [UIColor redColor];
    [self addSubview:self.originLabal];
    
    
    self.nowLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.originLabal.frame), imageW, titleH)];
    self.nowLabel.textAlignment = NSTextAlignmentCenter;
    self.nowLabel.font = [UIFont systemFontOfSize:14];
    self.nowLabel.text = @"$10.99";
    self.nowLabel.textColor = [UIColor lightGrayColor];
    [self addSubview:self.nowLabel];
}

- (void)setShopModel:(YYShopModel *)shopModel {
    _shopModel = shopModel;
    
    self.imageView.image = [UIImage imageNamed:shopModel.imageurl];
    self.originLabal.text = shopModel.originprice;
    self.nowLabel.text = shopModel.nowprice;
}

@end

































