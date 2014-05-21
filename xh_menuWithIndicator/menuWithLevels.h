//
//  menuWithLevels.h
//  xh_menuWithIndicator
//
//  Created by Xiaohe Hu on 5/20/14.
//  Copyright (c) 2014 Xiaohe Hu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol levelMenuDataSource;
@protocol levelMenuDelegate;

@interface menuWithLevels : UIView {

}

@property (nonatomic, strong) id<levelMenuDataSource>   dataSource;
@property (nonatomic, strong) id<levelMenuDelegate>     delegate;

@property (nonatomic, strong)   NSMutableArray              *arr_buttonTitles;
@property (nonatomic, strong)   NSMutableArray              *arr_buttonImages;
@property (nonatomic, strong)   NSMutableArray              *arr_buttonSelectImage;

@end

@protocol levelMenuDataSource <NSObject>
-(NSInteger) numberOfMenuLevels;

@optional
//-(NSArray *) numberOfMenuEachLevel;
-(NSArray *) buttonTitleOfMenuItem;
-(NSArray *) buttonImageOfMenuItem;
-(NSArray *) buttonSelectedImage;
-(NSArray *) indicatorViews;
@end

@protocol levelMenuDelegate <NSObject>
-(void) didSelectItemAtLevel:(NSInteger) selectedLevel andIndex:(NSInteger) selectedIndex;
@optional
-(void) didSelectItemAgainAtLevel:(NSInteger) selectedLevel andIndex:(NSInteger) selectedIndex;
@end