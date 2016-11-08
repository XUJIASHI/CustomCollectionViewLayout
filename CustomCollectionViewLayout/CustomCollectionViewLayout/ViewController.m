//
//  ViewController.m
//  CustomCollectionViewLayout
//
//  Created by walter on 16/11/8.
//  Copyright © 2016年 walter. All rights reserved.
//

#import "ViewController.h"
#import "Cell.h"
#import "CircleFlowLayout.h"

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, weak) UICollectionView *collectionView;

/**
 *  图片
 */
@property (nonatomic, strong) NSMutableArray *images;
@end

@implementation ViewController
- (NSMutableArray *)images
{
    if (!_images)
    {
        _images = [NSMutableArray array];
        
        for (int i = 1; i < 9; i++)
        {
            NSString *imageName = [NSString stringWithFormat:@"%d.jpg",i];
            
            [_images addObject:[UIImage imageNamed:imageName]];
        }
    }
    
    return _images;
}
- (CGFloat)scaleForImage
{
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",arc4random()%8+1]];
    
    //比例
    return image.size.height/image.size.width;
}


- (UICollectionView *)collectionView
{
    if (!_collectionView)
    {
        CircleFlowLayout *layout = [[CircleFlowLayout alloc] init];
        //item的大小
        layout.itemSize = CGSizeMake(300, 300*[self scaleForImage]);
        //滚动方向
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = -80;
        
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        [self.view addSubview:collectionView];
        
        [collectionView registerNib:[UINib nibWithNibName:@"Cell" bundle:nil] forCellWithReuseIdentifier:@"Cell"];
        
        _collectionView = collectionView;
    }
    
    return _collectionView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self collectionView];
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.images.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    Cell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.imageView.image = self.images[indexPath.item];
    
    return cell;
}

/**
 *  点击每个item会触发
 *
 *  @param collectionView <#collectionView description#>
 *  @param indexPath      <#indexPath description#>
 */
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
