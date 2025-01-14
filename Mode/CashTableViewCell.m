//
//  CashTableViewCell.m
//  Mode
//
//  Created by YedaoDEV on 15/6/11.
//  Copyright (c) 2015年 YedaoDEV. All rights reserved.
//

#import "CashTableViewCell.h"
#import "Common.h"
@implementation CashTableViewCell

- (void)awakeFromNib {
    if (!self.cashView) {
        
    }
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        if (!self.cashNumStr) {
            self.cashView = [[CashView alloc]init];
            [self.contentView addSubview:self.cashView];
        }
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.cashView.cashNumStr = self.cashNumStr;
    float padding = 10.f;
    float cashViewW = 230.f;
    float cashViewH = 90.f;
    float cashViewY = 10.f;
    float cashViewX = self.cashNumStr.floatValue>0?(KScreenWidth - padding - cashViewW):padding;
    self.cashView.frame = CGRectMake(cashViewX, cashViewY, cashViewW, cashViewH);
    
}
@end
