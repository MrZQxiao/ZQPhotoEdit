//
//  ImageCropViewController.m
//  FileLibraryDemo
//
//  Created by 肖兆强 on 2017/6/10.
//  Copyright © 2017年 jwzt. All rights reserved.
//

#import "ZQImageCropController.h"
#import "EditOperatingToolBar.h"
#import "ImageCropRatioChooseView.h"
#import "PECropView.h"

@interface ZQImageCropController ()
{
    PECropView *_cropView;
    ImageBlock _block;
    
    ImageCropRatioChooseView *_ratioChooseView;
}
@end

@implementation ZQImageCropController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildLayout];
}

-(void)buildLayout
{
    
    _cropView = [[PECropView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - operaBarHeight - ratioChooseHeight)];
    _cropView.image = self.image;
//    _cropView.rotationGestureRecognizer.enabled = false;
//    _cropView.keepingCropAspectRatio = true;
    _cropView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_cropView];
    
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
                [_cropView resetCropRect];
                [_ratioChooseView reset];
                break;
            case 2:
                NSLog(@"保存");
                if (_block) {
                    _block(_cropView.croppedImage);
                }
                [self dismissViewControllerAnimated:true completion:nil];
                break;
                
            default:
                break;
        }
    }];
    
    _ratioChooseView = [[ImageCropRatioChooseView alloc] initWithFrame:CGRectMake(0, self.view.height - ratioChooseHeight - operaBarHeight, self.view.width, ratioChooseHeight)];
    __weak __typeof(self)weekSelf = self;
    [_ratioChooseView addRatioChoiceBlock:^(CGFloat ratio) {
        [weekSelf changeRatio:ratio];
    }];
    [self.view addSubview:_ratioChooseView];
}

-(void)changeRatio:(CGFloat)ratio
{
    [_cropView resetCropRect];
    _cropView.cropAspectRatio = ratio;
}

-(void)addFinishBlock:(ImageBlock)block
{
    _block = block;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
