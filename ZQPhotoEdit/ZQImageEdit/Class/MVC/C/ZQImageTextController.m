//
//  ImageTextViewController.m
//  FileLibraryDemo
//
//  Created by 肖兆强 on 2017/6/10.
//  Copyright © 2017年 jwzt. All rights reserved.
//

#import "ZQImageTextController.h"
#import "ImageTextView.h"
#import "EditOperatingToolBar.h"
#import "ZQUtil.h"


@interface ZQImageTextController ()<UITextFieldDelegate>
{
    ImageBlock _block;
    UIImageView *_imageView;
    BOOL _isDragingMarkView;
}
@property (nonatomic,strong)UITextField *textField;



@end

@implementation ZQImageTextController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildLayout];
    
    
}

-(void)buildLayout
{
    self.view.backgroundColor = [UIColor blackColor];
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - operaBarHeight - textViewHeight)];
    _imageView.image = self.image;
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    _imageView.userInteractionEnabled = true;
    [self.view addSubview:_imageView];
    
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 120, 40)];
    _textField.textAlignment = NSTextAlignmentCenter;
    _textField.placeholder = @"点击输入";
    _textField.center = CGPointMake(_imageView.width/2.0f, _imageView.height/2.0f);
    _textField.delegate = self;
    _textField.layer.borderWidth = 1.0f;
    _textField.layer.borderColor = [UIColor blackColor].CGColor;
    _textField.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
    [_imageView addSubview:_textField];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(markPanMethod:)];
    [_imageView addGestureRecognizer:pan];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapMethod)];
    [self.view addGestureRecognizer:tap];
    
    
    ImageTextView *imageTextView = [[ImageTextView alloc] initWithFrame:CGRectMake(0, self.view.height - textViewHeight - operaBarHeight, self.view.width, textViewHeight)];
    [imageTextView addBlock:^(UIColor *color) {
            _textField.textColor = color;
    } font:^(UIFont *font) {
        _textField.font = font;
    }];
    
    [self.view addSubview:imageTextView];
    
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
                [imageTextView reset];
                [self resetMethod];
                break;
            case 2:
                NSLog(@"保存");
                if (_textField.text.length == 0) {
                    _textField.hidden = true;
                }
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
    
    _textField.centerX = _imageView.width/2.0f;
    _textField.centerY = _imageView.height/2.0f;
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
            _textField.center = point;
            
            if (_textField.left <= 0) {
                _textField.left = 0;
            }
            
            if (_textField.right >= _imageView.width) {
                _textField.right = _imageView.width;
            }
            if (_textField.top <=0) {
                _textField.top = 0;
            }
            
            if (_textField.bottom >= _imageView.height) {
                _textField.bottom = _imageView.height;
            }
        }
            break;
        case UIGestureRecognizerStateEnded:
            
            break;
            
        default:
            break;
    }
}

-(void)resetMethod
{
    _textField.layer.borderWidth = 1;
    _textField.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
    [_textField resignFirstResponder];
    _textField.text = @"";
    _textField.textColor = [UIColor blackColor];
    _textField.font = [UIFont systemFontOfSize:17];
    _textField.center = CGPointMake(_imageView.width/2.0f, _imageView.height/2.0f);
}

-(void)addFinishBlock:(ImageBlock)block
{
    _block = block;
}

-(void)tapMethod
{
    [_textField resignFirstResponder];
    _textField.layer.borderWidth = 0;
    _textField.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
}

#pragma mark -
#pragma mark textFiel状态

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    _textField.layer.borderWidth = 1;
    _textField.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
    return true;
}



//判断手指是否在拖拽水印图片
-(BOOL)isDragingWaterMark:(CGPoint)point
{
    BOOL isDraging = false;
    CGRect checkRect = CGRectMake(point.x, point.y, 1, 1);
    if (CGRectIntersectsRect(_textField.frame, checkRect)) {
        isDraging = true;
    }
    return isDraging;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
