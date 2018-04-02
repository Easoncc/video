//
//  CCMainTableViewCell.m
//  VideoVip_iphone
//
//  Created by chenchao on 2018/3/30.
//  Copyright © 2018年 chenchao. All rights reserved.
//

#import "CCMainTableViewCell.h"
#import <Masonry.h>

@implementation CCMainTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.accessoryType = UITableViewCellAccessoryNone;
        
        [self.contentView addSubview:self.nameLabel];
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        
    }
    return self;
}

- (UILabel *)nameLabel{
    
    if (!_nameLabel) {
        
        UILabel *label = [UILabel new];
    
        label.font = [UIFont boldSystemFontOfSize:19];
        label.textColor = [UIColor blackColor];
        label.numberOfLines = 2;
        label.textAlignment = NSTextAlignmentCenter;
        
        _nameLabel = label;
    }
    
    return _nameLabel;
}

@end
