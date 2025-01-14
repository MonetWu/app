//
//  WishListViewController.m
//  Mode
//
//  Created by YedaoDEV on 15/5/26.
//  Copyright (c) 2015年 YedaoDEV. All rights reserved.
//

#import "WishListViewController.h"
#import "ModeGood.h"
#import "WishlistScrollView.h"
#import <FMDB.h>
#import "WishlistView.h"
#import "ModeGoodAPI.h"
#import "GoodInfo.h"
#import "Coupon.h"
#import "UIImageView+WebCache.h"
#import "SDWebImageManager.h"
#import "ColorView.h"
#import "UIImage+PartlyImage.h"
#import "UIColor+HexString.h"
#import "Common.h"
#import "UIView+AutoLayout.h"
@interface WishListViewController ()<UIAlertViewDelegate>
@property (nonatomic, strong) NSMutableArray* clothes;
@property (nonatomic, strong) NSMutableArray* clothesIvArr;
@property (weak, nonatomic) UILabel *label;
@property (nonatomic, weak) WishlistScrollView *bigSV;
@property (strong, nonatomic) GoodInfo *goodInfo;
@property (weak, nonatomic) UIImageView *goods_img_detail;
@property (weak, nonatomic) UILabel *goods_price;
@property (weak, nonatomic) UIView *rightView;
@property (weak, nonatomic) UILabel *goods_title;
@property (weak, nonatomic) UIView *smallLineView;
@property (weak, nonatomic) UILabel *releaseTime;
@property (weak, nonatomic) UILabel *colorLabel;
@property (weak, nonatomic) UILabel *sizeLabel;


@property (weak, nonatomic) UIImageView *brandImageView;
@property (weak, nonatomic) UIButton *brandInfoBtn;
@property (weak, nonatomic) UIButton *viewDetailBtn;
@property (weak, nonatomic) UIButton *couponBtn;

@property (weak, nonatomic) ColorView *colorView1;
@property (weak, nonatomic) ColorView *colorView2;
@property (weak, nonatomic) ColorView *colorView3;
@property (weak, nonatomic) ColorView *colorView4;
@property (strong, nonatomic) NSArray *colorViews;
@end

@implementation WishListViewController




//增加右下视图  商品详情控件
-(void)createRightView{
//    float padding = 10.f;
//    float x = KScreenWidth/2;
//    float y = CGRectGetMaxY(self.bigSV.frame) + 2* padding;
//    float w = KScreenWidth/2;
//    float h = KScreenHeight - y - kStatusNaviBarH - 40.f;
//    UIView* view = [[UIView alloc]initWithFrame:CGRectMake(x, y, w, h)];
    UIView* view = [[UIView alloc]init];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    self.rightView = view;
    [self.view addSubview:self.rightView];
    
    UILabel* l1 = [[UILabel alloc]init];
    l1.translatesAutoresizingMaskIntoConstraints = NO;
    l1.numberOfLines=0;
    l1.font = [UIFont italicSystemFontOfSize:14];
    l1.textAlignment = NSTextAlignmentCenter;
    l1.textColor = [UIColor colorWithRed:77/255.f green:77/255.f blue:77/255.f alpha:1];
    self.goods_title = l1;
    [self.rightView addSubview:l1];
    
    UIView* v1 = [[UIView alloc]init];
    v1.backgroundColor = [UIColor colorWithRed:115/255.f green:115/255.f blue:115/255.f alpha:1];
    v1.translatesAutoresizingMaskIntoConstraints = NO;
    self.smallLineView = v1;
    [self.rightView addSubview:v1];
    
    UILabel* l2 = [[UILabel alloc]init];
    l2.textColor = [UIColor colorWithRed:95/255.f green:197/255.f blue:66/255.f alpha:1];
    l2.translatesAutoresizingMaskIntoConstraints = NO;
    l2.textAlignment = NSTextAlignmentCenter;
    l2.font = [UIFont italicSystemFontOfSize:12];
    self.releaseTime = l2;
    [self.rightView addSubview:l2];
    
    UILabel* l3 = [[UILabel alloc]init];
    l3.text = @"COLOUR";
    l3.font = [UIFont systemFontOfSize:11];
    l3.textColor = [UIColor blackColor];
    l3.translatesAutoresizingMaskIntoConstraints = NO;
    self.colorLabel = l3;
    [self.rightView addSubview:l3];
    
    UILabel* l4 = [[UILabel alloc]init];
    l4.text = @"SIZE:";
    l4.font = [UIFont systemFontOfSize:11];
    l4.textColor = [UIColor blackColor];
    l4.translatesAutoresizingMaskIntoConstraints = NO;
    self.sizeLabel = l4;
    [self.rightView addSubview:l4];
    
    UIButton* b1 = [[UIButton alloc]init];
    b1.translatesAutoresizingMaskIntoConstraints = NO;
    [b1 setImage:[UIImage imageNamed:@"brand_info_normal.png"] forState:UIControlStateNormal];
    [b1 setImage:[UIImage imageNamed:@"brand_info_press.png"] forState:UIControlStateHighlighted];
    b1.tag = 1;
    self.brandInfoBtn = b1;
    [self.rightView addSubview:b1];
    
    UIButton* b2 = [[UIButton alloc]init];
    b2.translatesAutoresizingMaskIntoConstraints = NO;
    [b2 setImage:[UIImage imageNamed:@"view_detal_normal.png"] forState:UIControlStateNormal];
    [b2 setImage:[UIImage imageNamed:@"view_detal_press.png"] forState:UIControlStateHighlighted];
    b2.tag = 2;
    self.viewDetailBtn = b2;
    [self.rightView addSubview: b2];
    
    UIImageView* iv = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"red_coupon_normal.png"]];
    iv.userInteractionEnabled = YES;
    self.brandImageView = iv;
    [self.brandInfoBtn addSubview:iv];
    
    UIButton* b3 = [[UIButton alloc]init];
    [b3 setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [b3 setImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
    b3.tag = 3;
    self.couponBtn = b3;
    [self.rightView addSubview:b3];
    
    ColorView* colorView = [[ColorView alloc]init];
    colorView.colorStr = @"";
    self.colorView1 = colorView;
    self.colorView1.translatesAutoresizingMaskIntoConstraints = NO;
    [self.rightView addSubview:self.colorView1];
    
    colorView = [[ColorView alloc]init];
    colorView.colorStr = @"";
    self.colorView2 = colorView;
    self.colorView2.translatesAutoresizingMaskIntoConstraints = NO;
    [self.rightView addSubview:self.colorView2];
    
    colorView = [[ColorView alloc]init];
    colorView.colorStr = @"";
    self.colorView3 = colorView;
    self.colorView3.translatesAutoresizingMaskIntoConstraints = NO;
    [self.rightView addSubview:self.colorView3];
    
    colorView = [[ColorView alloc]init];
    colorView.colorStr = @"";
    self.colorView4 = colorView;
    self.colorView4.translatesAutoresizingMaskIntoConstraints = NO;
    [self.rightView addSubview:self.colorView4];
    
    self.colorViews = @[self.colorView1,self.colorView2,self.colorView3,self.colorView4];
    
    self.rightView.backgroundColor = [UIColor clearColor];
}
- (void)updateViewConstraints
{
    [super updateViewConstraints];
    
    [self setupConstraintsForRightView];
}

-(void)setupConstraintsForRightView{
    [self.rightView autoRemoveConstraintsAffectingViewAndSubviews];
    
    [self.rightView autoPinToTopLayoutGuideOfViewController:self withInset:(CGRectGetMaxY(self.bigSV.frame) + 2* 10.f)];
    [self.rightView autoPinToBottomLayoutGuideOfViewController:self withInset:40.0f];
    [self.rightView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:KScreenWidth/2];
    [self.rightView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0.0f];
    [self resetAllElementsInRightView];
}
//设置右视图的所有子控件位置及大小
-(void)resetAllElementsInRightView{
    
    
    //配置goods_title位置
    CGRect frame = [self getGoodTitleFrame];
    [self.goods_title autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0.f];
    [self.goods_title autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0.f];
    [self.goods_title autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10.f];
    [self.goods_title autoSetDimension:ALDimensionHeight toSize:frame.size.height+10.f];
    
    [self.smallLineView autoSetDimensionsToSize:CGSizeMake(30.f, 2.f)];
    [self.smallLineView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.goods_title withOffset:5.f relation:NSLayoutRelationGreaterThanOrEqual];
    [self.smallLineView autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.goods_title];
    
    [self.releaseTime autoSetDimensionsToSize:CGSizeMake(frame.size.width, 20.f)];
    [self.releaseTime autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.smallLineView withOffset:5.f relation:NSLayoutRelationGreaterThanOrEqual];
    [self.releaseTime autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.releaseTime];
    
    [self.colorLabel autoSetDimensionsToSize:CGSizeMake(50.f, 20.f)];
    [self.colorLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:20.f];
    [self.colorLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.releaseTime withOffset:5.f];
    
    [self.colorView1 autoSetDimensionsToSize:CGSizeMake(20.f, 20.f)];
    [self.colorView1 autoAlignAxis:ALAxisVertical toSameAxisOfView:self.colorLabel];
    [self.colorView1 autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.colorLabel withOffset:0.f];
    [self.colorView2 autoSetDimensionsToSize:CGSizeMake(20.f, 20.f)];
    [self.colorView2 autoAlignAxis:ALAxisVertical toSameAxisOfView:self.colorLabel];
    [self.colorView2 autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.colorView1 withOffset:0.f];
    [self.colorView3 autoSetDimensionsToSize:CGSizeMake(20.f, 20.f)];
    [self.colorView3 autoAlignAxis:ALAxisVertical toSameAxisOfView:self.colorLabel];
    [self.colorView3 autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.colorView2 withOffset:0.f];
    [self.colorView4 autoSetDimensionsToSize:CGSizeMake(20.f, 20.f)];
    [self.colorView4 autoAlignAxis:ALAxisVertical toSameAxisOfView:self.colorLabel];
    [self.colorView4 autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.colorView3 withOffset:0.f];
    
    self.goods_title.text = self.goodInfo.goods_title;
    self.releaseTime.text = self.goodInfo.ctime;
    
    [self.brandInfoBtn autoSetDimensionsToSize:CGSizeMake(50.f, 20.f)];
    [self.brandInfoBtn autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.goods_title];
    [self.brandInfoBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.sizeLabel withOffset:5.f];
    [self.viewDetailBtn autoSetDimensionsToSize:CGSizeMake(50.f, 20.f)];
    [self.viewDetailBtn autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.goods_title];
    [self.viewDetailBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.brandInfoBtn withOffset:5.f];
    
    [self.brandImageView autoSetDimensionsToSize:CGSizeMake(18.f, 18.f)];
    [self.brandImageView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10.f];
    [self.brandImageView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:1.f];
    
//    self.goods_title.frame = CGRectMake(10.f, 0.f, frame.size.width, frame.size.height+10.f);
//    
//    
//    
//    
//    self.smallLineView.frame = CGRectMake(CGRectGetWidth(self.goods_title.frame)/2-15.f, CGRectGetMaxY(self.goods_title.frame)+5.f, 15.f*2, 2.f);
//    
//
//    self.releaseTime.frame = CGRectMake(0, CGRectGetMaxY(self.smallLineView.frame) + 10.f, CGRectGetWidth(self.rightView.frame), 20.f);
//    
//    self.colorLabel.frame = CGRectMake(CGRectGetMinX(self.releaseTime.frame)+10.f, CGRectGetMaxY(self.releaseTime.frame)+10.f, 50.f, 20.f);
//    
//    
    NSArray* colorArr= [self.goodInfo.goods_color componentsSeparatedByString:@","];
//    float colorViewW = 20.f;
//    float colorViewH = 20.f;
//    
//    self.colorView1.frame = CGRectMake(CGRectGetMaxX(self.colorLabel.frame), CGRectGetMinY(self.colorLabel.frame), colorViewW, colorViewH);
//    self.colorView2.frame = CGRectMake(CGRectGetMaxX(self.colorView1.frame), CGRectGetMinY(self.colorLabel.frame), colorViewW, colorViewH);
//    self.colorView3.frame = CGRectMake(CGRectGetMaxX(self.colorView2.frame), CGRectGetMinY(self.colorLabel.frame), colorViewW, colorViewH);
//    self.colorView4.frame = CGRectMake(CGRectGetMaxX(self.colorView3.frame), CGRectGetMinY(self.colorLabel.frame), colorViewW, colorViewH);
//    
//    
    for (int i = 0; i<self.colorViews.count; i++) {
        ColorView*colorView = self.colorViews[i];
        if (i>=colorArr.count) {
            colorView.colorStr = @"";
            continue;
        }
        colorView.colorStr = colorArr[i];
        //重绘在View中的类的setter方法已写
    }
    [self.sizeLabel autoSetDimensionsToSize:CGSizeMake(100.f, 20.f)];
    [self.sizeLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:20.f];
    [self.sizeLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.colorLabel withOffset:5.f];
    
    
    
//    self.sizeLabel.frame = CGRectMake(CGRectGetMinX(self.colorLabel.frame), CGRectGetMaxY(self.colorLabel.frame)+5.f, 100, 20);
//    self.sizeLabel.text = [NSString stringWithFormat:@"SIZE:  %@",self.goodInfo.goods_size];
//    
//    
//    
//    
//    float couponIVX = 20.f;
//    self.couponIV.frame = CGRectMake(couponIVX, CGRectGetMaxY(self.sizeLabel.frame)+10.f, CGRectGetWidth(self.rightView.bounds)-2* couponIVX, 40.f);
//    
//    self.couponBtn.frame = CGRectMake(10.f, 10.f, 40.f, 20.f);
//    
//    self.goodDetailBtn.frame = CGRectMake(CGRectGetMinX(self.couponIV.frame), CGRectGetMaxY(self.couponIV.frame)+10.f, CGRectGetWidth(self.couponIV.frame), 40.f);
    
    
}
//懒加载
-(NSMutableArray *)clothes{
    if (!_clothes) {
        _clothes = [NSMutableArray array];
    }
    return _clothes;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Wishlist";
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue" size:20],NSForegroundColorAttributeName:[UIColor whiteColor]};
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"#1b1b1b"];
    [[UIBarButtonItem appearance]setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60.f) forBarMetrics:UIBarMetricsDefault];
    
    
//由于页面显示的关系  因此本通知写在viewDidLoad中   在页面显示的时候   会显示出第一件物品的信息
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(requestLoadGoodInfo:) name:@"selectGood_id" object:nil];
    if ([[[UIDevice currentDevice]systemVersion]floatValue]>=7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
//如果跳转页面未传值，则显示本地未上传给服务器的wishlist列表，如果传值则显示网络上喜欢的历史纪录
    if (!self.receiveArr) {
        [self readDataFromTableWishlist];
    } else {
        [self.clothes addObjectsFromArray:self.receiveArr];
    }
    [self createScrollView];
    [self createRightView];
    [self createLeftView];
//从数据库读取数据
    [self resetAllElementsInRightView];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
}
//页面已经显示时添加两个通知的观察者
-(void)viewDidAppear:(BOOL)animated{
    
    if (!self.receiveArr) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(removeDataFromWishlist:) name:@"removeNopedGood" object:nil];
    }
}
//页面即将消失把通知注销掉
-(void)viewDidDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"removeNopedGood" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"requestLoadGoodInfo" object:nil];
}
//收到通知  网络请求商品详情
-(void)requestLoadGoodInfo:(NSNotification*)noti{
    [ModeGoodAPI requestGoodInfoWithGoodID:[noti.userInfo objectForKey:@"goods_id"] andCallback:^(id obj) {
        if ([obj isKindOfClass:[NSNull class]]) {
            return ;
        }
        self.goodInfo = obj;
        self.goods_price.text = [NSString stringWithFormat:@"Sale Price:$%.2f",self.goodInfo.goods_price.floatValue];
        
        [self.goods_img_detail sd_setImageWithURL:[NSURL URLWithString:self.goodInfo.img_detail_link] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            self.goods_img_detail.image = [UIImage getSubImageByImage:image andImageViewFrame:self.goods_img_detail.frame];
            [[SDImageCache sharedImageCache]storeImage:image forKey:[self.goodInfo.img_detail_link lastPathComponent] toDisk:YES];
        }];
        
        [self resetAllElementsInRightView];
        [self.view setNeedsLayout];
        [self.view setNeedsUpdateConstraints];
    }];
}
//计算右视图中商品标题的大小
-(CGRect)getGoodTitleFrame {
    NSDictionary* attributes = @{NSFontAttributeName:[UIFont italicSystemFontOfSize:14],NSForegroundColorAttributeName:[UIColor colorWithRed:77/255.f green:77/255.f blue:77/255.f alpha:1]};
    return [self.goodInfo.goods_title boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.rightView.bounds)-10.f, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
}

//导入wishlist数据  主要用来显示右上角红心数
-(void)readDataFromTableWishlist{
    NSString* documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString* path = [documentPath stringByAppendingPathComponent:@"my.sqlite"];
    FMDatabase* db = [FMDatabase databaseWithPath:path];
    if ([db open]) {
        NSLog(@"打开数据库成功");
        FMResultSet* set = [db executeQuery:@"select * from wishlist"];
        while ([set next]) {
            ModeGood* modeGood = [[ModeGood alloc]init];
            modeGood.brand_img_link = [set stringForColumn:@"brand_img_link"];
            modeGood.brand_name = [set stringForColumn:@"brand_name"];
            modeGood.goods_id = [set stringForColumn:@"goods_id"];
            modeGood.img_link = [set stringForColumn:@"img_link"];
            modeGood.has_coupon = [set stringForColumn:@"has_coupon"];
            [self.clothes addObject:modeGood];
        }
        [db close];
    } else {
        NSLog(@"打开数据库失败");
        [db close];
    }
}
//增加横向滚动的scrollView视图
-(void)createScrollView{
    [self defineRightBarItem];
    WishlistScrollView* sv = [[WishlistScrollView alloc]initWithFrame:CGRectMake(0, 10.f, CGRectGetWidth(self.view.bounds), (KScreenHeight - kStatusNaviBarH)/3.5) WithWishlistArr:self.clothes];
    self.bigSV = sv;
    [self.view addSubview:sv];
    float padding = 10.f;
    UIView *topLineView = [[UIView alloc]initWithFrame:CGRectMake(padding*2, CGRectGetMaxY(self.bigSV.frame)+padding, KScreenWidth - 4*padding, 2.f)];
    topLineView.backgroundColor = [UIColor colorWithHexString:@"#dbdbdb"];
    [self.view addSubview:topLineView];
    UIView *bottomLineView = [[UIView alloc]initWithFrame:CGRectMake(padding*2, KScreenHeight- kStatusNaviBarH - 40.f, KScreenWidth - 4* padding, 2.f)];
    bottomLineView.backgroundColor = [UIColor colorWithHexString:@"#dbdbdb"];
    [self.view addSubview:bottomLineView];
}
-(void)createLeftView{
    float padding = 10.f;
    float leftViewX = 0;
    float leftViewY = CGRectGetMaxY(self.bigSV.frame) + 2* padding;
    float leftViewW = KScreenWidth/2;
    float leftViewH = KScreenHeight - kStatusNaviBarH - leftViewY - 40.f;
    UIView* leftView = [[UIView alloc]initWithFrame:CGRectMake(leftViewX, leftViewY, leftViewW, leftViewH)];
    [self.view addSubview:leftView];
    
    leftView.backgroundColor = [UIColor clearColor];
    
    float labelX = 0;
    float labelH = 20.f;
    float labelY = leftViewH - padding -labelH;
    float labelW = leftViewW;
    UILabel * l1 = [[UILabel alloc]initWithFrame:CGRectMake(labelX, labelY, labelW, labelH)];
    l1.textAlignment = NSTextAlignmentCenter;
    l1.font = [UIFont systemFontOfSize:15];
    l1.minimumScaleFactor = 0.7;
    self.goods_price = l1;
    [leftView addSubview:l1];
    
    float leftH = leftViewH - labelH - padding;
    float leftW = leftViewW - 2* padding;
    float imageViewX,imageViewY,imageViewW,imageViewH;
    float scale = 0.6;
    if (leftW/leftH>=scale) {
        imageViewX = (leftW - scale * leftH)/2 + padding;
        imageViewY = 0;
        imageViewW = scale * leftH;
        imageViewH = leftH;
    } else {
        imageViewX = padding;
        imageViewY = (leftH - leftW/scale)/2;
        imageViewW = leftW;
        imageViewH = leftW/scale;
    }
    UIImageView* imageView = [[UIImageView alloc]initWithFrame:CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH)];
    self.goods_img_detail = imageView;
    [leftView addSubview:imageView];
    
    
    
    
    
    
}
//根据滚动视图中的子视图删除按钮的通知  把该视图从scrollView中删除  并且从数据库删除，更新右上角红心数 重置选中视图下标
-(void)removeDataFromWishlist:(NSNotification*)noti{
    NSString* nopedGoods_id = [noti.userInfo objectForKey:@"goods_id"];
    NSString* documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString*path=[documentPath stringByAppendingPathComponent:@"my.sqlite"];
    FMDatabase* db = [FMDatabase databaseWithPath:path];
    if ([db open]) {
        NSLog(@"数据库成功打开");
        BOOL res = [db executeUpdate:@"DELETE FROM wishlist WHERE goods_id = ?",nopedGoods_id];
        NSLog(@"%@",nopedGoods_id);
        if (res) {
            NSLog(@"删除成功");
        }
        [db close];
    } else {
        [db close];
        NSLog(@"数据库打开失败");
    }
    id obj = noti.object;
    if ([obj isMemberOfClass:[WishlistView class]]) {
        WishlistView* wishlistView = (WishlistView*)obj;
        [self.bigSV.wishlists removeObject:wishlistView.modeGood];
        [self.bigSV.wishlistViews removeObject:wishlistView];
        [wishlistView removeFromSuperview];
        [self.bigSV layoutSubviews];
        int count = self.label.text.intValue;
        count--;
        self.label.text = [NSString stringWithFormat:@"%d",(int)count];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"modificationWishlistCount" object:nil userInfo:@{@"wishlistCount":self.label.text}];
        if ([self.label.text isEqualToString:@"0"]) {
            UIAlertView* av = [[UIAlertView alloc]initWithTitle:@"Caution" message:@"Please come back and choose some your liked fashion goods first" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [av show];
        }
    }
}
#pragma mark UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == alertView.cancelButtonIndex) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
//定义导航栏右上角红心位置的视图
-(void)defineRightBarItem{
    UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 34 ,34)];
    UIImageView *bgIV = [[UIImageView alloc]initWithFrame:rightView.bounds];
    bgIV.image = [UIImage imageNamed:@"heart.png"];
    UILabel *l = [[UILabel alloc]initWithFrame:bgIV.bounds];
    l.textAlignment = NSTextAlignmentCenter;
    l.textColor = [UIColor whiteColor];
    l.text = [NSString stringWithFormat:@"%d",(int)self.clothes.count];
    self.label = l;
    [rightView addSubview:bgIV];
    [rightView addSubview:l];
    UIBarButtonItem* rightBarItem = [[UIBarButtonItem alloc]initWithCustomView:rightView];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    UIBarButtonItem* barItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemReply target:self action:@selector(comeback:)];
    self.navigationItem.leftBarButtonItem = barItem;
}
#pragma mark navigationItem.leftBarButtonItem Action
-(void)comeback:(UIBarButtonItem*)btn{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)gotoBrandRunway:(UIButton *)sender {
    self.navigationController.interactivePopGestureRecognizer.enabled = YES; self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    [self performSegueWithIdentifier:@"gotoBrandRunway" sender:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
