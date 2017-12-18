//
//  ZQPhotoListController.m
//  ZQPhotoEdit
//
//  Created by 肖兆强 on 2017/11/8.
//  Copyright © 2017年 ZQDemo. All rights reserved.
//

#import "ZQPhotoListController.h"
#import "UIBarButtonItem+Extension.h"
#import "TZImagePickerController.h"
#import "ZQUtil.h"
#import "SqliteControl+Recording.h"
#import "RecordingSQLModel.h"
#import "PhotoListCell.h"
#import "ImageEditViewController.h"



@interface ZQPhotoListController ()<TZImagePickerControllerDelegate,SWTableViewCellDelegate,UIActionSheetDelegate>
{
    
    NSIndexPath *_selectedPath;
    NSIndexPath *_curPlayingPath;
    NSIndexPath *_lastPlayingPath;
}

@property (nonatomic,strong) NSMutableArray *listArr;

@property(nonatomic,strong)  UIButton *editButton;


@property (nonatomic,strong,readonly) NSArray *selectFilePathArr;
@end

@implementation ZQPhotoListController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self refreshTableView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"全部照片";
    [self buildRightItem];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
}

- (void)buildRightItem
{
    UIBarButtonItem *addItem = [UIBarButtonItem barButtonItemWithImage:@"add" target:self selector:@selector(addImage)];
    
    _editButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 35, 25)];
    _editButton.titleLabel.font = ZQFont(16);
    [_editButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _editButton.imageView.contentMode = UIViewContentModeCenter;
    [_editButton setTitle:@"保存" forState:UIControlStateSelected];
    //    [_editButton setImage:[UIImage imageNamed:@"library_editBtn"] forState:UIControlStateNormal];
    [_editButton setTitle:@"排序" forState:UIControlStateNormal];
    [_editButton setImage:[UIImage new] forState:UIControlStateSelected];
    [_editButton addTarget:self action:@selector(editMethod:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *editItem = [[UIBarButtonItem alloc] initWithCustomView:_editButton];
    
    self.navigationItem.rightBarButtonItems = @[addItem,editItem];
}

-(void)editMethod:(UIButton*)button
{
    
   
    
    if (_listArr.count == 0) {
        return;
    }
    button.selected = !button.selected;
    if (button.selected) {
        [self startEditing];
    }else{
        
        [self endEditing];
    }
}



- (NSMutableArray *)listArr
{
    if (_listArr == nil) {
        _listArr = [NSMutableArray array];
    }
    return _listArr;
}

-(void)refreshTableView
{
    _listArr = [NSMutableArray arrayWithArray:[[SqliteControl shareControl] readAllRecordingModel]];
    [self.tableView reloadData];
}

-(NSArray *)selectFilePathArr
{
    NSMutableArray *arr = [NSMutableArray new];
    for (NSIndexPath *indexPath in self.tableView.indexPathsForSelectedRows) {
        RecordingSQLModel *model = _listArr[indexPath.row];
        [arr addObject:model.filePath];
    }
    return [NSArray arrayWithArray:arr];
}

- (void)buildUI
{
    
}



- (void)addImage
{
    __weak __typeof(self)weekSelf = self;
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:10 delegate:self];


    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        for (UIImage *image in photos) {
            NSData *imageData = UIImagePNGRepresentation(image);
            NSString *fileDic = [NSString stringWithFormat:@"%@/Documents/capturepng", NSHomeDirectory()];
            NSString *imagePath = [NSString stringWithFormat:@"%@/%@.png",fileDic,[ZQUtil generateBoundaryString]];
            [imageData writeToFile:imagePath atomically:YES];
            
            RecordingSQLModel *model = [[RecordingSQLModel alloc] init];
            model.fileID = imagePath.lastPathComponent;
            model.filePath = imagePath;
            [[SqliteControl shareControl] insertOneRecordingModel:model];
            
        }
        [self refreshTableView];
    }];
    imagePickerVc.navigationBar.barTintColor = [ZQUtil R:68 G:170 B:240 A:1];
    // 设置是否可以选择视频/图片/原图
    imagePickerVc.allowPickingVideo = true;
    imagePickerVc.maxImagesCount = 10;
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
    
}

#pragma mark TableViewDelegate&DataSource

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _listArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* cellIdentifier = @"cell";
    PhotoListCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[PhotoListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.rightUtilityButtons = [self rightButtons];
        cell.delegate = self;
    }
    
    RecordingSQLModel *model = _listArr[indexPath.row];

    cell.model = model;
   
    _lastPlayingPath = _curPlayingPath;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (![self.tableView isEditing]) {
        
       
        
        ImageEditViewController*editVC = [[ImageEditViewController alloc] init];
        editVC.title = @"图片编辑";
        RecordingSQLModel *model = _listArr[indexPath.row];
        editVC.imagePath = model.filePath;
        [self.navigationController pushViewController:editVC animated:true];
        
    }
    
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleNone;
}

//编辑状态下，只要实现这个方法，就能实现拖动排序
-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    [_listArr exchangeObjectAtIndex:sourceIndexPath.row withObjectAtIndex:destinationIndexPath.row];
    [[SqliteControl shareControl] insertFileWithModelArr:_listArr];
}

- (NSArray *)rightButtons
{
    NSMutableArray *rightButtons = [NSMutableArray new];
    
    [rightButtons sw_addUtilityButtonWithColor:[UIColor whiteColor]
                                          icon:[UIImage imageNamed:@"camer_bottom_delet"]];
    return rightButtons;
}

#pragma mark -
#pragma mark CellDelegate
-(BOOL)swipeableTableViewCellShouldHideUtilityButtonsOnSwipe:(SWTableViewCell *)cell
{
    return true;
}


-(void)removeFileOfModel:(RecordingSQLModel*)model
{
    [[SqliteControl shareControl] deleteWithFileID:model.fileID];
    [[NSFileManager defaultManager] removeItemAtPath:model.filePath error:nil];
    
}

-(void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    _selectedPath = indexPath;
            
            UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"确定删除？" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"删除" otherButtonTitles:nil];
            [sheet showInView:self.view];
    
      
     
}


#pragma mark -
#pragma mark 功能方法
-(void)startEditing
{
    [self.tableView setEditing:true animated:true];
    [CenterControl shareControl].isTableEditing = YES;
}

-(void)endEditing
{
    [self.tableView setEditing:false animated:true];
    [CenterControl shareControl].isTableEditing = NO;
}

-(void)deleteData
{
    NSArray *indexPathes = self.tableView.indexPathsForSelectedRows;
    NSMutableArray *arr = [NSMutableArray new];
    for (NSIndexPath *indexPath in indexPathes) {
        [arr addObject:_listArr[indexPath.row]];
        [self removeFileOfModel:_listArr[indexPath.row]];
    }
    [_listArr removeObjectsInArray:arr];
    [self.tableView deleteRowsAtIndexPaths:indexPathes withRowAnimation:UITableViewRowAnimationLeft];
}



#pragma mark -
#pragma mark ActionSheetDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSLog(@"buttonIndex = %zd",buttonIndex);
    if (buttonIndex == 0) {
        NSLog(@"删除");
        [self removeFileOfModel:_listArr[_selectedPath.row]];
        [_listArr removeObjectAtIndex:_selectedPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[_selectedPath] withRowAnimation:UITableViewRowAnimationLeft];
    }
}


@end
