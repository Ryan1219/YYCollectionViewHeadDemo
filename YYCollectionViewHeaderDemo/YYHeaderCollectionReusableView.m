//
//  YYHeaderCollectionReusableView.m
//  YYCollectionViewHeaderDemo
//
//  Created by Ryan on 2017/6/5.
//  Copyright © 2017年 Ryan. All rights reserved.
//

#import "YYHeaderCollectionReusableView.h"


@interface YYHeaderCollectionReusableView ()

/* <#description#> */
@property (nonatomic,strong) UIImageView *imageView;
/* <#description#> */
@property (nonatomic,strong) UIButton *shopBtn;

/* <#description#> */
@property (nonatomic,strong) YYShopHeadModel *selectModel;

@end

@implementation YYHeaderCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20*iPhone_6_Width_Zoom, 10, ScreenWidth-40*iPhone_6_Width_Zoom, 180)];
//        self.imageView.image = [UIImage imageNamed:self.imageurl];
        [self addSubview:self.imageView];
        
        
        self.shopBtn = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth-120*iPhone_6_Width_Zoom, 120, 100, 40)];
        [self.shopBtn setTitle:@"SHOP ALL" forState:UIControlStateNormal];
        [self.shopBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.shopBtn.backgroundColor = [UIColor blackColor];
        self.shopBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        self.shopBtn.layer.cornerRadius = 6;
        self.shopBtn.layer.masksToBounds = true;
        [self.shopBtn addTarget:self action:@selector(clickShopAllBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.shopBtn];
        
    }
    return self;
}

- (void)clickShopAllBtnAction:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(clickShopAllWithView:listingId:)]) {
        [self.delegate clickShopAllWithView:self listingId:self.selectModel.imageurl];
    }
}

//- (void)configHeadViewModel:(YYShopModel *)shopModel {
//    self.selectModel = shopModel;
//    
//    self.imageView.image = [UIImage imageNamed:shopModel.headimageurl];
//}


- (void)setShopHeadModel:(YYShopHeadModel *)shopHeadModel {
    self.selectModel = shopHeadModel;
    self.imageView.image = [UIImage imageNamed:shopHeadModel.imageurl];
}

@end






































