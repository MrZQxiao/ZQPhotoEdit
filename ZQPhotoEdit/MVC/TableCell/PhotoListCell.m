//
//  FileLibraryCell.m
//  FileLibraryDemo
//
//  Created by 肖兆强 on 2017/6/10.
//  Copyright © 2017年 jwzt. All rights reserved.
//

#import "PhotoListCell.h"
#import "ZQUtil.h"


@interface PhotoListCell ()
{
    UILabel *_titleLabel;
    UILabel *_subTitleLabel;
    UIImageView *_imageView;
    UIButton *_moreButton;
}
@end

@implementation PhotoListCell
/**
 *  addTapBlock
 */




-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self buildUI];
//        [self addTestBorderToSubviews];
    }
    return self;
}

-(void)buildUI
{
    self.tintColor = [ZQUtil R:88 G:104 B:151 A:1];
    
   
    _imageView = [UIImageView new];
    _imageView.image = [UIImage imageNamed:@"library_cell_image"];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    _imageView.layer.masksToBounds = true;
    _imageView.userInteractionEnabled = true;
    [self.contentView addSubview:_imageView];
    
    _moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_moreButton setImage:[UIImage imageNamed:@"library_cell_more"] forState:UIControlStateNormal];
    [self.contentView addSubview:_moreButton];
    
    _titleLabel = [UILabel new];
    _titleLabel.textColor = [ZQUtil R:51 G:51 B:51 A:1];
    _titleLabel.userInteractionEnabled = true;
    [self.contentView addSubview:_titleLabel];
    
    _subTitleLabel = [UILabel new];
    _subTitleLabel.textColor = [ZQUtil R:153 G:153 B:153 A:1];
    _subTitleLabel.font = [UIFont systemFontOfSize:15.0f];
    _subTitleLabel.userInteractionEnabled = true;
    [self.contentView addSubview:_subTitleLabel];
   
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat btnHeight = 25.0f;
    CGFloat margin = 8.0f;
    CGFloat imageWidth = 70.0f;
    CGFloat imageHeight = self.bounds.size.height - 2*margin;
    
   
    _imageView.frame = CGRectMake(margin, margin, imageWidth, imageHeight);
    
    _moreButton.frame = CGRectMake(self.bounds.size.width - margin - btnHeight, 0, btnHeight, btnHeight);
    _moreButton.centerY = _imageView.centerY;
    
    CGFloat labelHeight = (self.bounds.size.height - 2*margin)/2.0f;
    CGFloat labelWidth = CGRectGetMinX(_moreButton.frame) - CGRectGetMaxX(_imageView.frame) - 2*margin;
    CGFloat labelX = CGRectGetMaxX(_imageView.frame) + margin;
   
   
    CGFloat markWidth = 60.0f;
    _titleLabel.frame = CGRectMake(labelX, margin, labelWidth, labelHeight);
    _subTitleLabel.frame = CGRectMake(labelX, CGRectGetMaxY(_titleLabel.frame), labelWidth - markWidth, labelHeight);
   
}

-(void)setModel:(RecordingSQLModel *)model
{
    _model = model;
    _imageView.image = [UIImage imageNamed:@"library_cell_image"];
    NSString *fileName = [self fileNameWithPath:model.filePath];
    if (model.fileDetil.length > 0) {
        fileName = model.fileDetil;
    }

            _titleLabel.text = fileName;
            _subTitleLabel.text = [[CenterControl shareControl] fileReviseDate:model.filePath];
            _imageView.image = [UIImage imageWithContentsOfFile:model.filePath];
    

}

-(NSString*)fileNameWithPath:(NSString*)path
{
    NSString *fileName = path.lastPathComponent;
    NSInteger index = fileName.length > 20 ? fileName.length - 20 : 0;
    fileName = [fileName substringFromIndex:index];
    return fileName;
}


- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
