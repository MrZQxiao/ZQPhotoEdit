//
//  ImageEditViewController.m
//  FileLibraryDemo
//
//  Created by 肖兆强 on 2017/6/10.
//  Copyright © 2017年 ZQDemo. All rights reserved.
//

#import "ImageEditViewController.h"
#import "ZQImageEdit.h"
#import "ImageEditTitleView.h"
#import "RecordingSQLModel.h"
#import "SqliteControl+Recording.h"
#import "ImageEditToolBar.h"

@interface ImageEditViewController ()<ImageEditToolBarDelegate>
{
    UIImageView *_imageView;
    
    UIImage *_image;
    
}
@end

@implementation ImageEditViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildUI];
//    [self.view addTestBorderToSubviews];
}

-(void)buildUI
{
    self.view.backgroundColor = [UIColor blackColor];
    
    
    UIButton *saveButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [saveButton setImage:[UIImage imageNamed:@"imageEdit_save"] forState:UIControlStateNormal];
    saveButton.centerY = 42;
    [saveButton addTarget:self action:@selector(saveMethod) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:saveButton];

    _image = [UIImage imageWithContentsOfFile:_imagePath];
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    _imageView.image = _image;
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:_imageView];
    
    ImageEditToolBar *toolBar = [[ImageEditToolBar alloc] initWithFrame:CGRectMake(0, self.view.height - toolBarHeight, self.view.width, toolBarHeight)];
    toolBar.delegate = self;
    [self.view addSubview:toolBar];
}

#pragma mark -
#pragma mark ImageEditToolBarDelegate
-(void)imageEditToolBarSelectedAtIndex:(NSInteger)index
{
    switch (index) {
        case 0:
            NSLog(@"裁剪");
        {
            ZQImageCropController* cropVC = [[ZQImageCropController alloc] init];
            cropVC.image = _image;
            [cropVC addFinishBlock:^(UIImage *image) {
                _imageView.image = image;
                _image = image;
            }];
            [self presentViewController:cropVC animated:true completion:nil];
        }
            break;
        case 1:
            NSLog(@"滤镜");
        {
            
            ZQFilterController *filterVC = [[ZQFilterController alloc] init];
            filterVC.image = _image;
            [filterVC addFinishBlock:^(UIImage *image) {
                
                _imageView.image = image;
                _image = image;
            }];
            [self presentViewController:filterVC animated:true completion:nil];
        }
            break;
        case 2:
            NSLog(@"亮度");
        {
            ZQBrightnessController* rotateVC = [[ZQBrightnessController alloc] init];
            rotateVC.brightnessImage = _image;
            [rotateVC addFinishBlock:^(UIImage *image) {
                _imageView.image = image;
                _image = image;
            }];
            [self presentViewController:rotateVC animated:true completion:nil];
        }
            break;
        case 3:
            NSLog(@"水印");
        {
            ZQImageWatermarkController* warterVC = [[ZQImageWatermarkController alloc] init];
            warterVC.image = _image;
            [warterVC addFinishBlock:^(UIImage *image) {
                _imageView.image = image;
                _image = image;
            }];
            [self presentViewController:warterVC animated:true completion:nil];
        }
            break;
        case 4:
            NSLog(@"马赛克");
        {
            ZQImageMosaicController* rotateVC = [[ZQImageMosaicController alloc] init];
            rotateVC.image = _image;
            [rotateVC addFinishBlock:^(UIImage *image) {
                _imageView.image = image;
                _image = image;
            }];
            [self presentViewController:rotateVC animated:true completion:nil];
        }
            break;
        case 5:
            NSLog(@"旋转");
        {
            
            
            ZQImageRotationController* rotateVC = [[ZQImageRotationController alloc] init];
            rotateVC.image = _image;
            [rotateVC addFinishBlock:^(UIImage *image) {
                _imageView.image = image;
                _image = image;
            }];
            [self presentViewController:rotateVC animated:true completion:nil];
        }
            break;
        case 6:
            NSLog(@"文字");
        {
            ZQImageTextController* textVC = [[ZQImageTextController alloc] init];
            textVC.image = _image;
            [textVC addFinishBlock:^(UIImage *image) {
                _imageView.image = image;
                _image = image;
            }];
            [self presentViewController:textVC animated:true completion:nil];
        }
            break;
        default:
            break;
    }
}

-(void)saveMethod
{
    
    NSData *imageData = UIImagePNGRepresentation(_imageView.image);
    NSString *fileDic = [NSString stringWithFormat:@"%@/Documents/capturepng", NSHomeDirectory()];
    NSString *imagePath = [NSString stringWithFormat:@"%@/%@.png",fileDic,[ZQUtil generateBoundaryString]];
    [imageData writeToFile:imagePath atomically:YES];
    
    RecordingSQLModel *model = [[RecordingSQLModel alloc] init];
    model.fileID = imagePath.lastPathComponent;
    model.filePath = imagePath;
    [[SqliteControl shareControl] insertOneRecordingModel:model];
    [self.navigationController popToRootViewControllerAnimated:true];
    [self.navigationController setNavigationBarHidden:false animated:true];
}

-(void)backMethod
{
    [self.navigationController popViewControllerAnimated:true];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
