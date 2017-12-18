//
//  XLMosaicView.m
//  FileLibraryDemo
//
//  Created by Apple on 2017/1/16.
//  Copyright © 2017年 Apple. All rights reserved.
//

#define kBitsPerComponent (8)
#define kPixelChannelCount (4)
#define kBitsPerPixel (32)


#import "XLMosaicView.h"
#import "ZQUtil.h"

@interface XLMosaicView ()

@property (nonatomic, strong) UIImageView *surfaceImageView;

@property (nonatomic, strong) CALayer *imageLayer;

@property (nonatomic, strong) CAShapeLayer *shapeLayer;

@property (nonatomic, assign) CGMutablePathRef path;


@end

@implementation XLMosaicView

- (void)dealloc
{
    if (self.path) {
        CGPathRelease(self.path);
    }
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self buildUI];
        
        [self buildData];
    }
    return self;
}

-(void)buildUI
{
    //添加imageview（surfaceImageView）到self上
    self.surfaceImageView = [UIImageView new];
    self.surfaceImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.surfaceImageView.userInteractionEnabled = true;
    [self addSubview:self.surfaceImageView];
    
    //添加layer（imageLayer）到self上
    self.imageLayer = [CALayer layer];
    [self.layer addSublayer:self.imageLayer];
    
    self.shapeLayer = [CAShapeLayer layer];
    self.shapeLayer.lineCap = kCALineCapRound;
    self.shapeLayer.lineJoin = kCALineJoinRound;
    self.shapeLayer.lineWidth = 10.f;
    self.shapeLayer.strokeColor = [UIColor blueColor].CGColor;
    self.shapeLayer.fillColor = nil;//此处设置颜色有异常效果，可以自己试试
    [self.layer addSublayer:self.shapeLayer];
    self.imageLayer.mask = self.shapeLayer;
}

-(void)buildData
{
    self.path = CGPathCreateMutable();
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panMethod:)];
    [self addGestureRecognizer:pan];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize size = _image.size;
    CGFloat imageScale = size.width/size.height;
    CGPoint center = self.center;
    if (imageScale > self.width/self.height) {
        self.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.width/imageScale);
    }else{
        self.frame = CGRectMake(0, 0, self.bounds.size.height * imageScale, self.bounds.size.height);
    }
    self.center = center;
    
    self.surfaceImageView.frame = self.bounds;
    self.imageLayer.frame = self.bounds;
    self.shapeLayer.frame = self.bounds;
}

-(void)panMethod:(UIPanGestureRecognizer*)gesture
{
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
        {
            CGPoint point = [gesture locationInView:self];
            CGPathMoveToPoint(self.path, NULL, point.x, point.y);
            CGMutablePathRef path = CGPathCreateMutableCopy(self.path);
            self.shapeLayer.path = path;
            CGPathRelease(path);
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            CGPoint point = [gesture locationInView:self];
            CGPathAddLineToPoint(self.path, NULL, point.x, point.y);
            CGMutablePathRef path = CGPathCreateMutableCopy(self.path);
            self.shapeLayer.path = path;
            CGPathRelease(path);
        }
            break;
        case UIGestureRecognizerStateEnded:
            
            break;
            
        default:
            break;
    }
}

-(void)setImage:(UIImage *)image
{
    _image = image;
    
    self.surfaceImageView.image = image;
    
    UIImage *mosaicImage = [self transToMosaicImage:_image blockLevel:50];
    self.imageLayer.contents = (id)mosaicImage.CGImage;
}

-(void)setMosaicWidth:(CGFloat)mosaicWidth
{
    self.shapeLayer.lineWidth = mosaicWidth;
}

//重置
-(void)resetImage
{
    self.path = CGPathCreateMutable();
    CGMutablePathRef path = CGPathCreateMutableCopy(self.path);
    self.shapeLayer.path = path;
}

//获取马赛克图层
- (UIImage *)transToMosaicImage:(UIImage*)orginImage blockLevel:(NSUInteger)level
{
    //获取BitmapData
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGImageRef imgRef = orginImage.CGImage;
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    CGContextRef context = CGBitmapContextCreate (nil,
                                                  width,
                                                  height,
                                                  kBitsPerComponent,        //每个颜色值8bit
                                                  width*kPixelChannelCount, //每一行的像素点占用的字节数，每个像素点的ARGB四个通道各占8个bit
                                                  colorSpace,
                                                  kCGImageAlphaPremultipliedLast);
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imgRef);
    unsigned char *bitmapData = CGBitmapContextGetData (context);
    
    //这里把BitmapData进行马赛克转换,就是用一个点的颜色填充一个level*level的正方形
    unsigned char pixel[kPixelChannelCount] = {0};
    NSUInteger index,preIndex;
    for (NSUInteger i = 0; i < height - 1 ; i++) {
        for (NSUInteger j = 0; j < width - 1; j++) {
            index = i * width + j;
            if (i % level == 0) {
                if (j % level == 0) {
                    memcpy(pixel, bitmapData + kPixelChannelCount*index, kPixelChannelCount);
                }else{
                    memcpy(bitmapData + kPixelChannelCount*index, pixel, kPixelChannelCount);
                }
            } else {
                preIndex = (i-1)*width +j;
                memcpy(bitmapData + kPixelChannelCount*index, bitmapData + kPixelChannelCount*preIndex, kPixelChannelCount);
            }
        }
    }
    
    NSInteger dataLength = width*height* kPixelChannelCount;
    CGDataProviderRef provider = CGDataProviderCreateWithData(NULL, bitmapData, dataLength, NULL);
    //创建要输出的图像
    CGImageRef mosaicImageRef = CGImageCreate(width, height,
                                              kBitsPerComponent,
                                              kBitsPerPixel,
                                              width*kPixelChannelCount ,
                                              colorSpace,
                                              kCGBitmapByteOrderDefault,
                                              provider,
                                              NULL, NO,
                                              kCGRenderingIntentDefault);
    CGContextRef outputContext = CGBitmapContextCreate(nil,
                                                       width,
                                                       height,
                                                       kBitsPerComponent,
                                                       width*kPixelChannelCount,
                                                       colorSpace,
                                                       kCGImageAlphaPremultipliedLast);
    CGContextDrawImage(outputContext, CGRectMake(0.0f, 0.0f, width, height), mosaicImageRef);
    CGImageRef resultImageRef = CGBitmapContextCreateImage(outputContext);
    UIImage *resultImage = nil;
    if([UIImage respondsToSelector:@selector(imageWithCGImage:scale:orientation:)]) {
        float scale = [[UIScreen mainScreen] scale];
        resultImage = [UIImage imageWithCGImage:resultImageRef scale:scale orientation:UIImageOrientationUp];
    } else {
        resultImage = [UIImage imageWithCGImage:resultImageRef];
    }
    //释放
    if(resultImageRef){
        CFRelease(resultImageRef);
    }
    if(mosaicImageRef){
        CFRelease(mosaicImageRef);
    }
    if(colorSpace){
        CGColorSpaceRelease(colorSpace);
    }
    if(provider){
        CGDataProviderRelease(provider);
    }
    if(context){
        CGContextRelease(context);
    }
    if(outputContext){
        CGContextRelease(outputContext);
    }
    return resultImage ;
}

//截屏保存
-(UIImage *)finisedImage
{
    return [ZQUtil screenShotsOfView:self];
}

@end
