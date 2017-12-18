//
//  ImageWatermarkViewController.m
//  FileLibraryDemo
//
//  Created by 肖兆强 on 2017/6/10.
//  Copyright © 2017年 jwzt. All rights reserved.
//
#import "ZQImageWatermarkController.h"
#import "ImageWaterMarkView.h"
#import "EditOperatingToolBar.h"
#import "WaterMarkControl.h"
#import "WaterMarkControl.h"
#import "TZImagePickerController.h"
#import "ZQUtil.h"


@interface ZQImageWatermarkController ()<TZImagePickerControllerDelegate,UIActionSheetDelegate>
{
    ImageBlock _block;
    UIImageView *_imageView;
    UIImageView *_markView;
    BOOL _isDragingMarkView;
    
    ImageWaterMarkView *_warterMarkView;
}
@end

@implementation ZQImageWatermarkController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildLayout];
}

-(void)buildLayout
{
    self.view.backgroundColor = [UIColor blackColor];
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - operaBarHeight - waterViewHeight)];
    _imageView.image = self.image;
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    _imageView.userInteractionEnabled = true;
    [self.view addSubview:_imageView];
    
    _markView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 50)];
    _markView.center = CGPointMake(_imageView.width/2.0f, _imageView.height/2.0f);
    _markView.userInteractionEnabled = true;
    _markView.layer.cornerRadius = 5.0f;
    _markView.layer.masksToBounds = true;
    _markView.hidden = true;
    [_imageView addSubview:_markView];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(markPanMethod:)];
    [_imageView addGestureRecognizer:pan];
    
    _warterMarkView = [[ImageWaterMarkView alloc] initWithFrame:CGRectMake(0, self.view.height - waterViewHeight - operaBarHeight, self.view.width, waterViewHeight)];
    _warterMarkView.imagePthes = [WaterMarkControl shareControl].waterMarkPathes;
    [_warterMarkView addWaterMarkSelected:^(UIImage *image) {
        _markView.image = image;
        _markView.hidden = false;
    } addBlock:^{
        [self addNewMark];
    }];
    [self.view addSubview:_warterMarkView];
    
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
                _markView.hidden = true;
                _markView.center = CGPointMake(_imageView.width/2.0f, _imageView.height/2.0f);
                break;
            case 2:
                NSLog(@"保存");
                if (_block) {
                    _block([ZQUtil screenShotsOfView:_imageView]);
                }
                [self dismissViewControllerAnimated:true completion:nil];
                break;
                
            default:
                break;
        }
    }];
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    CGSize size = _image.size;
    CGFloat imageScale = size.width/size.height;
    CGPoint center = _imageView.center;
    if (imageScale > _imageView.width/_imageView.height) {
        _imageView.frame = CGRectMake(0, 0, _imageView.bounds.size.width, _imageView.bounds.size.width/imageScale);
    }else{
        _imageView.frame = CGRectMake(0, 0, _imageView.bounds.size.height * imageScale, _imageView.bounds.size.height);
    }
    _imageView.center = center;
    
    _markView.centerX = _imageView.width/2.0f;
    _markView.centerY = _imageView.height/2.0f;
}

-(void)markPanMethod:(UIPanGestureRecognizer*)gesture
{
    CGPoint point = [gesture locationInView:_imageView];
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
            _isDragingMarkView = [self isDragingWaterMark:point];
            break;
        case UIGestureRecognizerStateChanged:
        {
            if (!_isDragingMarkView) {return;}
            _markView.center = point;
            if (_markView.left <= 0) {
                _markView.left = 0;
            }
            if (_markView.right >= _imageView.width) {
                _markView.right = _imageView.width;
            }
            if (_markView.top <=0) {
                _markView.top = 0;
            }
            if (_markView.bottom >= _imageView.height) {
                _markView.bottom = _imageView.height;
            }
        }
            break;
        case UIGestureRecognizerStateEnded:
            
            break;
            
        default:
            break;
    }
}

-(void)addFinishBlock:(ImageBlock)block
{
    _block = block;
}

//判断手指是否在拖拽水印图片
-(BOOL)isDragingWaterMark:(CGPoint)point
{
    BOOL isDraging = false;
    CGRect checkRect = CGRectMake(point.x, point.y, 1, 1);
    if (CGRectIntersectsRect(_markView.frame, checkRect)) {
        isDraging = true;
    }
    return isDraging;
}

-(void)addNewMark
{
    [self getImageFromeAlbum];

}



-(void)getImageFromeAlbum{
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        
        UIImage *image = photos.firstObject;
        [[WaterMarkControl shareControl] addNewWaterMark:image];
        _warterMarkView.imagePthes = [WaterMarkControl shareControl].waterMarkPathes;
    }];
    imagePickerVc.navigationBar.barTintColor = [ZQUtil R:68 G:170 B:240 A:1];
    imagePickerVc.maxImagesCount = 1;
    imagePickerVc.allowPickingVideo = NO;
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
