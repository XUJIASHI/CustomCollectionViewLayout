//
//  CircleFlowLayout.m
//  11-collectionView自定义封面
//
//  Created by vera on 16/4/7.
//  Copyright © 2016年 vera. All rights reserved.
//

#import "CircleFlowLayout.h"


@implementation CircleFlowLayout

/**
 *  当collectionView的坐标发生改变的时候是否需要重新布局
 *
 *  @param newBounds <#newBounds description#>
 *
 *  @return <#return value description#>
 */
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}


//- (void)prepareLayout
//{
//    [super prepareLayout];
//    
//    NSLog(@"重新布局");
//}

/**
 *   返回指定大小的item的详细信息
 *
 *  @param rect <#rect description#>
 *
 *  @return <#return value description#>
 */
#if 1
- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    //获取指定
    NSArray *attributes = [super layoutAttributesForElementsInRect:rect];
    
    //获取collectionView的中心点
    CGFloat xOffsetForCollectionView = self.collectionView.contentOffset.x + self.collectionView.frame.size.width/2;
    

    //对每一个item的大小处理
    for (UICollectionViewLayoutAttributes *attribute in attributes)
    {
        //collectionView的中心点分别到各个item的中心点的差
        CGFloat x = ABS(xOffsetForCollectionView - attribute.center.x);
        
        //比例
        CGFloat scale = 1 - x/self.collectionView.frame.size.width;
        
        //修改比例
        attribute.transform = CGAffineTransformMakeScale(scale, scale);
    }
    
    return attributes;
}
#endif

@end
