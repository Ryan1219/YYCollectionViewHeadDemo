//
//  YYHeaderCollectionReusableView.h
//  YYCollectionViewHeaderDemo
//
//  Created by Ryan on 2017/6/5.
//  Copyright © 2017年 Ryan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYShopHeadModel.h"

@class YYHeaderCollectionReusableView;
@protocol YYHeaderCollectionReusableViewdelegate <NSObject>

- (void)clickShopAllWithView:(YYHeaderCollectionReusableView *)view listingId:(NSString *)listingId;

@end

@interface YYHeaderCollectionReusableView : UICollectionReusableView

/* <#description#> */
@property (nonatomic,weak) id<YYHeaderCollectionReusableViewdelegate>delegate;

//- (void)configHeadViewModel:(YYShopModel *)shopModel;

/* <#description#> */
@property (nonatomic,strong) YYShopHeadModel *shopHeadModel;

@end
