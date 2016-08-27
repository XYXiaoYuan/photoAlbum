//
//  XYPhotoCell.m
//  photoAlbum
//
//  Created by 袁小荣 on 16/8/28.
//  Copyright © 2016年 bruceyuan. All rights reserved.
//

#import "XYPhotoCell.h"

@interface XYPhotoCell ()
/** 图片的imageView */
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@end

@implementation XYPhotoCell


- (void)setImage:(NSString *)image
{
    _image = image;
    _photoImageView.image = [UIImage imageNamed:image];
}

@end
