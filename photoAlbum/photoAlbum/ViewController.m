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

@interface ViewController ()<UICollectionViewDataSource>
/** 数据 */
@property (nonatomic, strong) NSMutableArray *imageNames;
@end

@implementation ViewController
#define ScreenW [UIScreen mainScreen].bounds.size.width
static NSString * const XYPhotoCellID = @"photo";

- (NSMutableArray *)imageNames
{
    if (!_imageNames) {
        _imageNames = [NSMutableArray array];
        for (int i = 0; i < 20; i++) {
            [_imageNames addObject:[NSString stringWithFormat:@"%zd", i + 1]];
        }
    }
    return _imageNames;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.自定义流水布局
    XYLineLayout *layout = ({
        // 创建流水布局
        XYLineLayout *layout = [[XYLineLayout alloc] init];
        
        // 设置尺寸
        layout.itemSize = CGSizeMake(160, 160);
        
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        CGFloat margin = (ScreenW - 160) * 0.5;
        layout.sectionInset = UIEdgeInsetsMake(0, margin, 0, margin);
        // 设置最小行间距
        layout.minimumLineSpacing = 50;
        
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
        
        collectionView;
        
    });
    
    // 3.注册cell
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([XYPhotoCell class])  bundle:nil] forCellWithReuseIdentifier:XYPhotoCellID];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    XYPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:XYPhotoCellID forIndexPath:indexPath];
    
    cell.image = self.imageNames[indexPath.item];
    
    return cell;
}
@end
