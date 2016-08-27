//
//  ViewController.m
//  photoAlbum
//
//  Created by 袁小荣 on 16/8/28.
//  Copyright © 2016年 bruceyuan. All rights reserved.
//

#import "ViewController.h"
#import "XYPhotoCell.h"
#import "XYLineLayout.h"
#import "XYCircleLayout.h"

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
/** collectionView */
@property (nonatomic, weak) UICollectionView *collectionView;
/** 数据 */
@property (nonatomic, strong) NSMutableArray *imageNames;
@end

@implementation ViewController
#define ScreenW [UIScreen mainScreen].bounds.size.width
static NSString * const XYPhotoCellID = @"photo";
static NSInteger const photoImagesCount = 20;

- (NSMutableArray *)imageNames
{
    if (!_imageNames) {
        _imageNames = [NSMutableArray array];
        for (int i = 0; i < photoImagesCount; i++) {
            [_imageNames addObject:[NSString stringWithFormat:@"%zd", i + 1]];
        }
    }
    return _imageNames;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.自定义流水布局
    XYCircleLayout *layout = ({
        // 创建流水布局
        XYCircleLayout *layout = [[XYCircleLayout alloc] init];
        
        layout;
    });
    
    // 2.创建UICollectionView:黑色
    UICollectionView *collectionView = ({
        
        UICollectionView *collectionView =  [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        collectionView.backgroundColor = [UIColor brownColor];
        collectionView.center = self.view.center;
        collectionView.bounds = CGRectMake(0, 0, self.view.bounds.size.width, 200);
        collectionView.showsHorizontalScrollIndicator = NO;
        [self.view addSubview:collectionView];
        
        // 设置数据源
        collectionView.dataSource = self;
        // 设置代理
        collectionView.delegate = self;
        
        collectionView;
        
    });
    self.collectionView = collectionView;
    
    // 3.注册cell
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([XYPhotoCell class])  bundle:nil] forCellWithReuseIdentifier:XYPhotoCellID];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([self.collectionView.collectionViewLayout isKindOfClass:[XYLineLayout class]]) {
        [self.collectionView setCollectionViewLayout:[[XYCircleLayout alloc] init] animated:YES];
    } else {
        XYLineLayout *layout = [[XYLineLayout alloc] init];
        layout.itemSize = CGSizeMake(160, 160);
        [self.collectionView setCollectionViewLayout:layout animated:YES];
    }
}



#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imageNames.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    XYPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:XYPhotoCellID forIndexPath:indexPath];
    
    cell.image = self.imageNames[indexPath.item];
    
    return cell;
}

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.imageNames removeObjectAtIndex:indexPath.item];
    [self.collectionView deleteItemsAtIndexPaths:@[indexPath]];
}
@end
