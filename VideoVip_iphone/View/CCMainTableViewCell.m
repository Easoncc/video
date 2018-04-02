//
//  CCMainTableViewCell.m
//  VideoVip_iphone
//
//  Created by chenchao on 2018/3/30.
//  Copyright © 2018年 chenchao. All rights reserved.
//

#import "CCMainTableViewCell.h"

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
        
    }
    return self;
}

- (UILabel *)nameLabel{
    
    if (!_nameLabel) {
        
        UILabel *label = [UILabel new];
        label.frame = CGRectMake(0, 0, self.frame.size.width, 100);
        label.font = [UIFont boldSystemFontOfSize:19];
        label.textColor = [UIColor blackColor];
        label.numberOfLines = 2;
        label.textAlignment = NSTextAlignmentCenter;
        
        _nameLabel = label;
    }
    
    return _nameLabel;
}

@end
