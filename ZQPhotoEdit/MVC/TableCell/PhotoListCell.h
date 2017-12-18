//
//  FileLibraryCell.h
//  FileLibraryDemo
//
//  Created by 肖兆强 on 2017/6/10.
//  Copyright © 2017年 jwzt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWTableViewCell.h"
#import "RecordingSQLModel.h"



@interface PhotoListCell : SWTableViewCell



@property (strong,nonatomic) RecordingSQLModel *model;

@end
