//
//  WaterMarkControl.h
//  移动采编
//
//  Created by Apple on 2017/2/23.
//  Copyright © 2017年 jwzt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WaterMarkControl : NSObject

+(WaterMarkControl*)shareControl;

@property (nonatomic,strong) NSArray *waterMarkPathes;

-(void)addNewWaterMark:(UIImage*)image;

@end
