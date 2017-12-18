//
//  ImageMosaicViewController.m
//  FileLibraryDemo
//
//  Created by 肖兆强 on 2017/6/10.
//  Copyright © 2017年 jwzt. All rights reserved.
//

#import "ZQImageMosaicController.h"
#import "EditOperatingToolBar.h"
#import "ImageMosaicToolBar.h"
#import "XLMosaicView.h"

@interface ZQImageMosaicController ()
{
    ImageBlock _block;
    XLMosaicView *_mosaicView;
}
@end

@implementation ZQImageMosaicController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildUI];
//    [self.view addTestBorderToSubviews];
}

-(void)buildUI
{
    self.view.backgroundColor = [UIColor blackColor];
    _mosaicView = [[XLMosaicView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - operaBarHeight - mosaicToolBarHeight)];
    _mosaicView.image = _image;
    [self.view addSubview:_mosaicView];
    
    EditOperatingToolBar *bar = [[EditOperatingToolBar alloc] initWithFrame:CGRectMake(0, self.view.height - operaBarHeight, self.view.width, operaBarHeight)];
    [self.view addSubview:bar];
    [bar addTapBlock:^(NSInteger index) {
        switch (index) {
            case 0:
                NSLog(@"取消");
                [self dismissViewControllerAnimated:true completion:nil];
                break;
            case 1:
                NSLog(@"撤销");
                [_mosaicView resetImage];
                break;
            case 2:
                NSLog(@"保存");
                if (_block) {
                    _block(_mosaicView.finisedImage);
                }
                [self dismissViewControllerAnimated:true completion:nil];
                break;
                
            default:
                break;
        }
    }];
    
    ImageMosaicToolBar *mosaicBar = [[ImageMosaicToolBar alloc] initWithFrame:CGRectMake(0, self.view.height - mosaicToolBarHeight - operaBarHeight, self.view.width, mosaicToolBarHeight)];
    [mosaicBar addLineWidthChangeBlock:^(CGFloat lineWidth) {
        _mosaicView.mosaicWidth = lineWidth;
    }];
    [self.view addSubview:mosaicBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)addFinishBlock:(ImageBlock)block
{
    _block = block;
}


@end
