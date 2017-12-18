//
//  ImageRotationViewController.m
//  FileLibraryDemo
//
//  Created by 肖兆强 on 2017/6/10.
//  Copyright © 2017年 jwzt. All rights reserved.
//

#import "ZQImageRotationController.h"
#import "ImageRotateToolBar.h"
#import "EditOperatingToolBar.h"
#import "UIImage+PECrop.h"
#import "UIImage+Rotate.h"

@interface ZQImageRotationController ()
{
    UIImageView *_imageView;
    ImageBlock _block;
}
@end

@implementation ZQImageRotationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildLayout];
}

-(void)buildLayout
{
    
    self.view.backgroundColor = [UIColor blackColor];
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - operaBarHeight - rotateToolBarHeight)];
    _imageView.image = self.image;
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:_imageView];
    
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
                _imageView.image = _image;
                break;
            case 2:
                NSLog(@"保存");
                if (_block) {
                    _block(_imageView.image);
                }
                [self dismissViewControllerAnimated:true completion:nil];
                break;

            default:
                break;
        }
    }];
    
    ImageRotateToolBar *roateView = [[ImageRotateToolBar alloc] initWithFrame:CGRectMake(0, self.view.height - rotateToolBarHeight - operaBarHeight, self.view.width, rotateToolBarHeight)];
    __weak __typeof(self)weekSelf = self;
    [roateView addRotateChangeBlock:^(NSInteger index) {
        [weekSelf changeImageRoate:index];
    }];
    [self.view addSubview:roateView];
}

-(void)changeImageRoate:(NSInteger)index
{
    switch (index) {
        case 0:
            NSLog(@"逆时针九十度");
            _imageView.image = [_imageView.image rotate:UIImageOrientationLeft];
            break;
        case 1:
            NSLog(@"顺时针九十度");
            _imageView.image = [_imageView.image rotate:UIImageOrientationRight];
            break;
        case 2:
            NSLog(@"水平翻转");
            _imageView.image = [_imageView.image flipHorizontal];
            break;
        case 3:
            NSLog(@"上下翻转");
            _imageView.image = [_imageView.image flipVertical];
            break;
            
        default:
            break;
    }
}

-(void)addFinishBlock:(ImageBlock)block
{
    _block = block;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
