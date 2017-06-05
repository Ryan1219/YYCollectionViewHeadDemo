//
//  ViewController.m
//  YYCollectionViewHeaderDemo
//
//  Created by Ryan on 2017/6/5.
//  Copyright © 2017年 Ryan. All rights reserved.
//

#import "ViewController.h"
#import "YYShopCollectionViewCell.h"
#import "YYHeaderCollectionReusableView.h"
#import "YYShopModel.h"
#import "YYShopHeadModel.h"

@interface ViewController () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>

/* <#description#> */
@property (nonatomic,strong) UIScrollView *scrollView;
/* <#description#> */
@property (nonatomic,strong) NSMutableArray *sectionArray;
/* <#description#> */
@property (nonatomic,strong) NSMutableArray *dataArray;

@end

@implementation ViewController

/* <#description#> */
- (NSMutableArray *)sectionArray {
    
    if (_sectionArray == nil) {
        _sectionArray = [NSMutableArray array];
    }
    return _sectionArray;
}

/* <#description#> */
- (NSMutableArray *)dataArray {
    
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    
    return _dataArray;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self loadData];
    [self configCollectionView];
    
}
//MARK:-加载假数据
- (void)loadData {
    for (NSInteger i = 0; i < 5; i++) {
        YYShopHeadModel *model = [[YYShopHeadModel alloc] init];
        model.imageurl = @"1";
        if (i%2 == 0) {
            model.imageurl = @"2";
        }
        model.listingId = [NSString stringWithFormat:@"head listingId %ld",i];
        [self.sectionArray addObject:model];
    }
    
    for (NSInteger i = 0; i < 10; i++) {
        YYShopModel *model = [[YYShopModel alloc] init];
        model.imageurl = @"3";
        if (i % 2 == 0) {
            model.imageurl = @"4";
        }
        model.originprice = [NSString stringWithFormat:@"$ %.2f",20.99+i];
        model.nowprice = [NSString stringWithFormat:@"$ %.2f",15.99+i];
        [self.dataArray addObject:model];
    }
}

//MARK:-界面创建
- (void)configCollectionView {
    
    CGFloat cellW = (ScreenWidth - 40*iPhone_6_Width_Zoom) / 3.5; //item宽
    CGFloat cellH = cellW + 40; //item高
    CGFloat collectionViewH = cellH + 10; //UICollectionView高
    CGFloat contentH = (200 + collectionViewH) * 5 + 64; //UIScrollView高
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView.delegate = self;
    self.scrollView.contentSize = CGSizeMake(ScreenWidth, contentH); //设置UIScrollView的content区域大小
    [self.view addSubview:self.scrollView];
    
    for (NSInteger i = 0; i < self.sectionArray.count; i++) {
        
        //头部区域
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, i * (200 + collectionViewH), ScreenWidth, 200)];
        headView.backgroundColor = [UIColor whiteColor];
        [self.scrollView addSubview:headView];
        
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10*iPhone_6_Width_Zoom, 10, ScreenWidth-20*iPhone_6_Width_Zoom, 180)];
        imageView.userInteractionEnabled = true;
        YYShopHeadModel *model = self.sectionArray[i];
        imageView.image = [UIImage imageNamed:model.imageurl];
        [headView addSubview:imageView];
        
        
        UIButton *shopBtn = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth-120*iPhone_6_Width_Zoom, 120, 100, 40)];
        [shopBtn setTitle:@"SHOP ALL" forState:UIControlStateNormal];
        [shopBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        shopBtn.backgroundColor = [UIColor blackColor];
        shopBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        shopBtn.layer.cornerRadius = 6;
        shopBtn.layer.masksToBounds = true;
        shopBtn.tag = 1990 + i;
        [shopBtn addTarget:self action:@selector(clickShopAllBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [headView addSubview:shopBtn];
        
        //UICollectionView区域
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(cellW, cellH);
        flowLayout.sectionInset = UIEdgeInsetsMake(5, 10, 0, 10);//设置所有item的范围
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.minimumLineSpacing = 10; //水平滑动的时候有作用
//        flowLayout.minimumInteritemSpacing = 10 * iPhone_6_Width_Zoom; //竖直滑动的时候有作用
//        flowLayout.headerReferenceSize = CGSizeMake(10*iPhone_6_Width_Zoom, cellH); //设置头部范围
        flowLayout.footerReferenceSize = CGSizeMake(cellW, cellH);
        
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 200 + i * (200 + collectionViewH), ScreenWidth, collectionViewH) collectionViewLayout:flowLayout];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.tag = 2000 + i;
        collectionView.showsHorizontalScrollIndicator = false;
        collectionView.backgroundColor = [UIColor whiteColor];
        [collectionView registerClass:[YYShopCollectionViewCell class] forCellWithReuseIdentifier:@"shopCellIndentifier"];
        [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"shopCellHeaderIndentifier"];
        [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"shopCellFooterIndentifier"];
        [self.scrollView addSubview:collectionView];
    }
}

//MARK:-UICollectionViewDelegate && DataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    YYShopCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"shopCellIndentifier" forIndexPath:indexPath];
    cell.shopModel = self.dataArray[indexPath.row];
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *reuseableView = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"shopCellHeaderIndentifier" forIndexPath:indexPath];
        reuseableView = headView;
    } else {
        
        UICollectionReusableView *footerview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"shopCellFooterIndentifier" forIndexPath:indexPath];
        footerview.layer.borderColor = [UIColor lightGrayColor].CGColor;
        footerview.layer.borderWidth = 0.5;
        UIButton *allSelectBt = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, footerview.frame.size.width,footerview.frame.size.height)];
        UIImage *allSelctImage = [UIImage imageNamed:@"home_ic_next_slide"];
        [allSelectBt setImage:allSelctImage forState:UIControlStateNormal];
        [allSelectBt setTitle:@"More" forState:UIControlStateNormal];
        [allSelectBt setTitleColor:YYColor(0x666666) forState:UIControlStateNormal];
        [allSelectBt addTarget:self action:@selector(clickLastCellWithSeeMoreBtn:) forControlEvents:UIControlEventTouchUpInside];
        allSelectBt.titleLabel.font = [UIFont systemFontOfSize:12];
        allSelectBt.titleLabel.numberOfLines = 0;
        allSelectBt.imageEdgeInsets = UIEdgeInsetsMake(-footerview.frame.size.height/4, (footerview.frame.size.height-allSelctImage.size.width)/5, 0, 0);
        allSelectBt.titleEdgeInsets = UIEdgeInsetsMake(footerview.frame.size.height/4, -10, 0, 0);
        allSelectBt.tag = collectionView.tag + 1990;
        [footerview addSubview:allSelectBt];
        reuseableView = footerview;

    }
    
    return reuseableView;
}

//MARK:-UIButton Action
//点击最后一个cell
- (void)clickLastCellWithSeeMoreBtn:(UIButton *)sender {
    
    NSLog(@"------%ld",sender.tag-1990);
   
}
//点击头部的shopall
- (void)clickShopAllBtnAction:(UIButton *)sender {
    
    NSLog(@"------%ld",sender.tag-1990);
}

@end






















































