//
//  ZQBrightnessController.m
//  ZQPhotoEdit
//
//  Created by 肖兆强 on 2017/6/10.
//  Copyright © 2017年 jwzt. All rights reserved.
//

#import "ZQBrightnessController.h"
#import "EditOperatingToolBar.h"
#import "ImageBrightnessView.h"
#import <CoreImage/CIFilter.h>

@interface ZQBrightnessController ()<ImageBrightnessViewDelegate>

{
    UIImageView *_imageView;
    ImageBlock _block;
    CIContext *_context;//Core Image上下文
    CIImage *_image;//我们要编辑的图像
    CIImage *_outputImage;//处理后的图像
    CIFilter *_colorControlsFilter;//色彩滤镜
}



@end

@implementation ZQBrightnessController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildLayout];
    _context=[CIContext contextWithOptions:nil];//使用GPU渲染，推荐,但注意GPU的CIContext无法跨应用访问，例如直接在UIImagePickerController的完成方法中调用上下文处理就会自动降级为CPU渲染，所以推荐现在完成方法中保存图像，然后在主程序中调用
    
    //取得滤镜
    _colorControlsFilter=[CIFilter filterWithName:@"CIColorControls"];
    
    //初始化CIImage源图像
    _image=[CIImage imageWithCGImage:_brightnessImage.CGImage];
    [_colorControlsFilter setValue:_image forKey:@"inputImage"];//设置滤镜的输入图片
    
}


-(void)setImage{
    CIImage *outputImage= [_colorControlsFilter outputImage];//取得输出图像
    CGImageRef temp=[_context createCGImage:outputImage fromRect:[outputImage extent]];
    _imageView.image=[UIImage imageWithCGImage:temp];//转化为CGImage显示在界面中
    
    CGImageRelease(temp);//释放CGImage对象
}

-(void)buildLayout
{
    
    self.view.backgroundColor = [UIColor blackColor];
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - operaBarHeight - BrightnessToolBarHeight)];
    _imageView.image = self.brightnessImage;
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
                _imageView.image = _brightnessImage;
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
    
    ImageBrightnessView *BrightnessView = [[ImageBrightnessView alloc] initWithFrame:CGRectMake(0, self.view.height - BrightnessToolBarHeight - operaBarHeight, self.view.width, BrightnessToolBarHeight)];
    BrightnessView.delegate = self;
    [self.view addSubview:BrightnessView];
}



-(void)addFinishBlock:(ImageBlock)block
{
    _block = block;
}

-(void)brightnessChangeWithTag:(NSInteger)tag Value:(CGFloat)value
{
    switch (tag) {
        case 105:
            [_colorControlsFilter setValue:[NSNumber numberWithFloat:value] forKey:@"inputBrightness"];
            
            
            break;
        case 106:
            [_colorControlsFilter setValue:[NSNumber numberWithFloat:value] forKey:@"inputSaturation"];//设置滤镜参数
            break;
        case 107:
            [_colorControlsFilter setValue:[NSNumber numberWithFloat:value] forKey:@"inputContrast"];
            break;
            
        default:
            break;
    }
    [self setImage];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
