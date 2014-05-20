//
//  menuWithIndicator.m
//  xh_menuWithIndicator
//
//  Created by Xiaohe Hu on 5/19/14.
//  Copyright (c) 2014 Xiaohe Hu. All rights reserved.
//

#import "menuWithIndicator.h"

static float buttonSpace = 20.0;
@interface menuWithIndicator ()

@property (nonatomic, strong) NSMutableArray    *arr_buttons;
@property (nonatomic)         int               preBtnTag;
@end
@implementation menuWithIndicator
@synthesize arr_buttonImages, arr_buttonSelectImage, arr_buttonTitles;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.arr_buttonImages = [[NSMutableArray alloc] init];
        self.arr_buttonTitles = [[NSMutableArray alloc] init];
        self.arr_buttonSelectImage = [[NSMutableArray alloc] init];
        _arr_buttons = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)setDataSource:(id<indicatorMenuDataSource>)dataSource {
    _dataSource = dataSource;
    [self reloadData];
}

-(void) reloadData {
    [self.arr_buttonTitles removeAllObjects];
    [self.arr_buttonImages removeAllObjects];
    [self.arr_buttonSelectImage removeAllObjects];
    
    if (self.dataSource != nil) {
        NSInteger count = [self.dataSource numberOfMenuItems];
        
        //Add button Title
        if ([self.dataSource titleOfButtonsAtIndex:0] != nil) {
            for (int i = 0; i < count; i++) {
                NSString *buttonTitle = [self.dataSource titleOfButtonsAtIndex:i];
                [self.arr_buttonTitles addObject:buttonTitle];
            }
        }
        //Add Button Background Image
        if ([self.dataSource imageOfButtonsAtIndex:0] != nil) {
            for (int j = 0; j < count; j++) {
                UIImage *buttonBgImg = [self.dataSource imageOfButtonsAtIndex:j];
                [self.arr_buttonImages addObject:buttonBgImg];
            }
        }
        //Add Selected Button's Background Image
        if ([self.dataSource imageOfSelectedButtonAtIndex:0] != nil) {
            for (int k = 0; k < count; k++) {
                UIImage *selectedBtnImg = [self.dataSource imageOfSelectedButtonAtIndex:k];
                [self.arr_buttonSelectImage addObject:selectedBtnImg];
            }
        }
    }
}

-(void) initMenuItems {
    CGSize preSize = CGSizeZero;
    if ([self.arr_buttonTitles count] > 0) {
        for (int i = 0; i < self.arr_buttonTitles.count; i++) {
            NSString *titleString = [self.arr_buttonTitles objectAtIndex:i];
            CGSize stringsize = [titleString sizeWithFont:[UIFont systemFontOfSize:14]];
            UIButton *uib_menuItem = [UIButton buttonWithType:UIButtonTypeCustom];
            uib_menuItem.frame = CGRectMake((preSize.width + buttonSpace)*i, 0.0, stringsize.width, self.frame.size.height);
            [uib_menuItem setTintColor:[UIColor blackColor]];
            uib_menuItem.tag = i;
            [uib_menuItem addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
            [_arr_buttons addObject:uib_menuItem];
        }
    }
}

-(void)buttonTapped:(id)sender {
    UIButton *tmpButton = sender;
    if (_preBtnTag == tmpButton.tag) {
        //添加怎么处理按键显示
        if (self.arr_buttonTitles.count > 0) {
            [tmpButton setTintColor:[UIColor redColor]];
        }
        [self didSelectItemAgainInMenu:self];
        _preBtnTag = -1;
    }
    else {
        //添加怎么处理按键显示
        [self didSelectItemAtIndex:tmpButton.tag inMenu:self];
        _preBtnTag = (int)tmpButton.tag;
    }
}

#pragma mark- Delegate Method
-(void) didSelectItemAtIndex:(NSInteger) selectedIndex inMenu:(menuWithIndicator *)indicatorMenu{
    [self.delegate didSelectItemAtIndex:selectedIndex inMenu:indicatorMenu];
}
-(void) didSelectItemAgainInMenu:(menuWithIndicator *)indicatorMenu {
    [self.delegate didSelectItemAgainInMenu:indicatorMenu];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
