//
//  ViewController.m
//  xh_menuWithIndicator
//
//  Created by Xiaohe Hu on 5/19/14.
//  Copyright (c) 2014 Xiaohe Hu. All rights reserved.
//

#import "ViewController.h"
#import "menuWithIndicator.h"
#import "menuWithLevels.h"
@interface ViewController () <indicatorMenuDataSource, indicatorMenuDelegate, levelMenuDataSource, levelMenuDelegate>
@property (nonatomic, strong) menuWithIndicator     *theMenu;
@property (nonatomic, strong) menuWithLevels        *levelMenu;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self initMenu];
}

-(void)initMenu {
    _theMenu = [[menuWithIndicator alloc] initWithFrame:CGRectMake(0.0, 40.0, 1024, 50.0)];
    _theMenu.dataSource = self;
    _theMenu.delegate = self;
    [self.view addSubview: _theMenu];
    
    _levelMenu = [[menuWithLevels alloc] initWithFrame:CGRectMake(0.0, 200.0, 1024.0, 50.0)];
    _levelMenu.delegate = self;
    _levelMenu.dataSource = self;
    [self.view addSubview: _levelMenu];
}

#pragma mark Indicator Menu Delegate
-(NSInteger) numberOfMenuItems {
    return 5;
}
-(NSString *) titleOfButtonsAtIndex:(NSInteger) index {
    NSString *buttonTitle = nil;
    
    switch (index) {
        case 0:
            buttonTitle = @"Button 1";
            break;
        case 1:
            buttonTitle = @"Button 2";
            break;
        case 2:
            buttonTitle = @"Button 34567890";
            break;
        case 3:
            buttonTitle = @"Button 4";
            break;
        case 4:
            buttonTitle = @"Button 5";
            break;
        default:
            break;
    }
    return buttonTitle;
}

-(UIImage *)  imageOfButtonsAtIndex:(NSInteger) index {
    return nil;
}
-(UIImage *)  imageOfSelectedButtonAtIndex:(NSInteger) index {
    return nil;
}
-(UIView *)indicatorForMenu {
    UIView *uiv_indicator = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 20.0, 20.0)];
    uiv_indicator.backgroundColor = [UIColor brownColor];
    return uiv_indicator;
}
-(void) didSelectItemAtIndex:(NSInteger) selectedIndex inMenu:(menuWithIndicator *)indicatorMenu {
    NSLog(@"\n\n No.%i  Tap first time", (int)selectedIndex);
}
-(void) didSelectItemAgainInMenu:(menuWithIndicator *)indicatorMenu {
    NSLog(@"\n\nTap again!");
}

#pragma mark - Levle Menu Delegate
-(NSInteger ) numberOfMenuLevels {
    return 2;
}

-(NSArray *) buttonTitleOfMenuItem {
    NSArray *arr_level_1_title = [[NSArray alloc] initWithObjects:@"level1_1", @"level1_2", @"level1_3", @"level1_4", @"level1_5", nil];
    NSArray *arr_level_2_1_title =[[NSArray alloc] initWithObjects:@"level2_1_1", @"level2_1_2", @"level2_1_3", @"level2_1_4", @"level2_1_5", nil];
    NSArray *arr_level_2_2_title =[[NSArray alloc] initWithObjects:@"level2_2_1", @"level2_2_2", @"level2_2_3", @"level2_2_4", @"level2_2_5", nil];
    NSArray *arr_level_2_3_title =[[NSArray alloc] initWithObjects:@"level2_3_1", @"level2_3_2", @"level2_3_3", @"level2_3_4", @"level2_3_5", nil];
    NSArray *arr_level_2_4_title =[[NSArray alloc] initWithObjects:@"level2_4_1", @"level2_4_2", @"level2_4_3", @"level2_4_4", @"level2_4_5", nil];
    NSArray *arr_level_2_5_title =[[NSArray alloc] initWithObjects:@"level2_5_1", @"level2_5_2", @"level2_5_3", @"level2_5_4", @"level2_5_5", nil];
    
    NSArray *arr_buttonTitles = [[NSArray alloc] initWithObjects:arr_level_1_title, arr_level_2_1_title, arr_level_2_2_title, arr_level_2_3_title, arr_level_2_4_title, arr_level_2_5_title, nil];
    
    return arr_buttonTitles;
}

-(NSArray *) buttonImageOfMenuItem {
    return nil;
}
-(NSArray *) buttonSelectedImage {
    return nil;
}
-(NSArray *) indicatorViews {
    UIView *uiv_mainIndicator = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 20.0, 20.0)];
    uiv_mainIndicator.backgroundColor = [UIColor brownColor];
    
    UIView *uiv_subIndicator = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 20.0, 20.0)];
    uiv_subIndicator.backgroundColor = [UIColor blackColor];
    
    NSArray *arr_indicators = [[NSArray alloc] initWithObjects:uiv_mainIndicator, uiv_subIndicator, nil];
    
    return arr_indicators;
}

-(void) didSelectItemAtLevel:(NSInteger) selectedLevel andIndex:(NSInteger) selectedIndex {
    NSLog(@"\n\n Tapped Level%i and item %i", selectedLevel, selectedIndex);
}

-(void) didSelectItemAgainAtLevel:(NSInteger) selectedLevel andIndex:(NSInteger) selectedIndex {
    NSLog(@"\n\n Retapped button in level %i and item %i", selectedLevel, selectedIndex);
}
#pragma mark
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
