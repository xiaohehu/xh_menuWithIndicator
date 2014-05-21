//
//  menuWithLevels.m
//  xh_menuWithIndicator
//
//  Created by Xiaohe Hu on 5/20/14.
//  Copyright (c) 2014 Xiaohe Hu. All rights reserved.
//

#import "menuWithLevels.h"

static float buttonSpace = 20.0;
@interface menuWithLevels()
@property (nonatomic)         int               numOfLevels;
@property (nonatomic)         int               preMainButton;
@property (nonatomic)         int               preSubButton;
@property (nonatomic)         CGRect            originalRect;
@property (nonatomic, strong) NSMutableArray    *arr_buttons;
@property (nonatomic, strong) NSMutableArray    *arr_subButtons;
@property (nonatomic, strong) UIView            *uiv_mainNavContainer;
@property (nonatomic, strong) UIView            *uiv_subNavContainer;
@property (nonatomic, strong) UIView            *uiv_mainNavIndicator;
@property (nonatomic, strong) UIView            *uiv_subNavIndicator;
@end

@implementation menuWithLevels
@synthesize arr_buttonTitles, arr_buttonImages, arr_buttonSelectImage;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _originalRect = frame;
        _preMainButton = -1;
        _preSubButton = -1;
        self.backgroundColor = [UIColor clearColor];
        self.arr_buttonImages = [[NSMutableArray alloc] init];
        self.arr_buttonTitles = [[NSMutableArray alloc] init];
        self.arr_buttonSelectImage = [[NSMutableArray alloc] init];
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height*2);
        _arr_buttons = [[NSMutableArray alloc] init];
        _arr_subButtons = [[NSMutableArray alloc] init];
        _uiv_mainNavContainer = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, _originalRect.size.width,_originalRect.size.height)];
        _uiv_mainNavContainer.backgroundColor = [UIColor yellowColor];
    }
    return self;
}
#pragma mark - Get Data
-(void)setDataSource:(id<levelMenuDataSource>)dataSource {
    _dataSource = dataSource;
    [self reloadData];
}

-(void) reloadData {
    NSLog(@"Load the data");
    [self.arr_buttonTitles removeAllObjects];
    [self.arr_buttonImages removeAllObjects];
    [self.arr_buttonSelectImage removeAllObjects];
    
    _numOfLevels = (int)[self.dataSource numberOfMenuLevels];
    if (_numOfLevels == 0) {
        return;
    }
    else {
        if (self.dataSource != nil) {
            //Add Button Titles
            if ([self.dataSource buttonTitleOfMenuItem] != nil) {
                [self.arr_buttonTitles setArray:[self.dataSource buttonTitleOfMenuItem]];
            }
            //Add Button Images
            if ([self.dataSource buttonImageOfMenuItem] != nil) {
                [self.arr_buttonImages setArray:[self.dataSource buttonImageOfMenuItem]];
            }
            //Add Button Selected Images
            if ([self.dataSource buttonSelectedImage] != nil) {
                [self.arr_buttonSelectImage setArray:[self.dataSource buttonSelectedImage]];
            }
            //Set Indicators
            if ([self.dataSource indicatorViews] != nil) {
                _uiv_mainNavIndicator = [self.dataSource indicatorViews][0];
                _uiv_subNavIndicator = [self.dataSource indicatorViews][1];
                _uiv_mainNavIndicator.hidden = YES;
                _uiv_subNavContainer.hidden = YES;
            }
        }
    }
    [self initMenuItems];
}

#pragma mark - Init Main & Sub Nav menus
-(void) initMenuItems {
    CGSize preSize = CGSizeZero;
    CGFloat preX = 0.0;
    for (UIView *tmp in [_uiv_subNavContainer subviews]) {
        [tmp removeFromSuperview];
    }
    if ([self.arr_buttonTitles count] > 0) {
        NSArray *arr_mainNavItems = [[NSArray alloc] initWithArray:self.arr_buttonTitles[0]];
        for (int i = 0; i < arr_mainNavItems.count; i++) {
            NSString *titleString = [arr_mainNavItems objectAtIndex:i];
            CGSize stringsize = [titleString sizeWithFont:[UIFont systemFontOfSize:20]];
            UIButton *uib_menuItem = [UIButton buttonWithType:UIButtonTypeCustom];
            uib_menuItem.frame = CGRectMake((preSize.width + buttonSpace + preX), 0.0, stringsize.width, _originalRect.size.height);
            [uib_menuItem setTitle:titleString forState:UIControlStateNormal];
            [uib_menuItem setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            uib_menuItem.tag = i;
            [uib_menuItem setBackgroundColor:[UIColor blueColor]];
            [uib_menuItem addTarget:self action:@selector(mainNavButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
            preSize = stringsize;
            preX = uib_menuItem.frame.origin.x;
            [_uiv_mainNavContainer addSubview:uib_menuItem];
            [_arr_buttons addObject:uib_menuItem];
        }
    }
    [self addSubview: _uiv_mainNavContainer];
}

-(void)initSubMenuItems:(int)index {
    _uiv_subNavContainer = [[UIView alloc] initWithFrame:CGRectMake(0.0, _originalRect.size.height, _originalRect.size.width, _originalRect.size.height)];
    _uiv_subNavContainer.backgroundColor = [UIColor redColor];
    [_arr_subButtons removeAllObjects];
    
    [self createSubMenuItems:[self.arr_buttonTitles objectAtIndex:index]];
}
-(void)createSubMenuItems:(NSArray *)arr_subMenuItems {
    CGSize preSize = CGSizeZero;
    CGFloat preX = 0.0;
    for (int i = 0; i < arr_subMenuItems.count; i++) {
        NSString *titleString = [arr_subMenuItems objectAtIndex:i];
        CGSize stringsize = [titleString sizeWithFont:[UIFont systemFontOfSize:20]];
        UIButton *uib_menuItem = [UIButton buttonWithType:UIButtonTypeCustom];
        uib_menuItem.frame = CGRectMake((preSize.width + buttonSpace + preX), 0.0, stringsize.width, _originalRect.size.height);
        [uib_menuItem setTitle:titleString forState:UIControlStateNormal];
        [uib_menuItem setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        uib_menuItem.tag = i;
        [uib_menuItem setBackgroundColor:[UIColor greenColor]];
        [uib_menuItem addTarget:self action:@selector(subNavButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        preSize = stringsize;
        preX = uib_menuItem.frame.origin.x;
        [_uiv_subNavContainer addSubview:uib_menuItem];
        [_arr_subButtons addObject: uib_menuItem];
    }
    _uiv_subNavContainer.hidden = NO;
    [self addSubview: _uiv_subNavContainer];
}
#pragma mark Handle Button Tapped
-(void)mainNavButtonTapped:(id)sender {
    UIButton *tmpBtn = sender;
    [self addSubview:_uiv_mainNavIndicator];
    [_uiv_subNavContainer removeFromSuperview];
    [_uiv_subNavIndicator removeFromSuperview];
    _uiv_subNavIndicator.hidden = YES;
    // Tap the button again
    if (_preMainButton == tmpBtn.tag) {
        if (self.arr_buttonTitles.count > 0) {
            [tmpBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            _uiv_mainNavIndicator.hidden = YES;
        }
        [self didSelectItemAgainAtLevel:0  andIndex:_preMainButton];
        _preMainButton = -1;
    }
    // Tap the button first time
    else {
        for (UIButton *tmp in _arr_buttons) {
            [tmp setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        if (self.arr_buttonTitles.count > 0) {
            [tmpBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            if (_uiv_mainNavIndicator.hidden) {
                _uiv_mainNavIndicator.frame = CGRectMake(tmpBtn.frame.origin.x+(tmpBtn.frame.size.width - _uiv_mainNavIndicator.frame.size.width)/2, 0.0, _uiv_mainNavIndicator.frame.size.width, _uiv_mainNavIndicator.frame.size.height);
                _uiv_mainNavIndicator.hidden = NO;
            }
            else {
                [UIView animateWithDuration:0.6 animations:^{
                    _uiv_mainNavIndicator.frame = CGRectMake(tmpBtn.frame.origin.x+(tmpBtn.frame.size.width - _uiv_mainNavIndicator.frame.size.width)/2, 0.0, _uiv_mainNavIndicator.frame.size.width, _uiv_mainNavIndicator.frame.size.height);
                }];
            }
            
        }
        int index = tmpBtn.tag;
        switch (index) {
            case 0: {
                [self initSubMenuItems:1];
                break;
            }
            case 1: {
                [self initSubMenuItems:2];
                break;
            }
            case 2: {
                [self initSubMenuItems:3];
                break;
            }
            case 3: {
                [self initSubMenuItems:4];
                break;
            }
            case 4: {
                [self initSubMenuItems:5];
                break;
            }
            default:
                break;
        }
        [self didSelectItemAtLevel:0 andIndex:tmpBtn.tag];
        _preMainButton = (int)tmpBtn.tag;
    }
}

-(void)subNavButtonTapped:(id)sender {
    UIButton *tmpBtn = sender;
    [_uiv_subNavContainer addSubview: _uiv_subNavIndicator];
    // Tap the button again
    if (_preSubButton == tmpBtn.tag) {
        if (self.arr_subButtons.count > 0) {
            [tmpBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            _uiv_subNavIndicator.hidden = YES;
        }
        [self didSelectItemAgainAtLevel:1  andIndex:tmpBtn.tag];
        _preSubButton = -1;
    }
    // Tap the button first time
    else {
        for (UIButton *tmp in _arr_subButtons) {
            [tmp setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        if (self.arr_subButtons.count > 0) {
            [tmpBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            if (_uiv_subNavIndicator.hidden) {
                _uiv_subNavIndicator.frame = CGRectMake(tmpBtn.frame.origin.x+(tmpBtn.frame.size.width - _uiv_subNavIndicator.frame.size.width)/2, 0.0, _uiv_subNavIndicator.frame.size.width, _uiv_subNavIndicator.frame.size.height);
                _uiv_subNavIndicator.hidden = NO;
                NSLog(@"The sub menu indicator is %@",[_uiv_subNavIndicator description]);
            }
            else {
                [UIView animateWithDuration:0.6 animations:^{
                    _uiv_subNavIndicator.frame = CGRectMake(tmpBtn.frame.origin.x+(tmpBtn.frame.size.width - _uiv_subNavIndicator.frame.size.width)/2, 0.0, _uiv_subNavIndicator.frame.size.width, _uiv_subNavIndicator.frame.size.height);
                }];
            }
            
        }
        [self didSelectItemAtLevel:1 andIndex:tmpBtn.tag];
        _preSubButton = (int)tmpBtn.tag;
    }


}

#pragma mark- Button Tapped Delegate Methods
-(void) didSelectItemAtLevel:(NSInteger) selectedLevel andIndex:(NSInteger) selectedIndex{
    [self.delegate didSelectItemAtLevel:selectedLevel andIndex:selectedIndex];
}

-(void) didSelectItemAgainAtLevel:(NSInteger) selectedLevel  andIndex:(NSInteger) selectedIndex{
    [self.delegate didSelectItemAgainAtLevel: selectedLevel  andIndex: selectedIndex];
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
