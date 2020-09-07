//
//  MainVC.m
//  YHForm
//
//  Created by Bryant_YH on 2020/8/28.
//  Copyright © 2020 Bryant_YH. All rights reserved.
//

#import "MainVC.h"
#import "YHFormHeader.h"
#import "YHFormTestCell.h"
#import "YHFormTestTableCell.h"
@interface MainVC ()<YHFormViewDelegate, YHFormViewDataSource>
@property (nonatomic, strong)YHFormView *formView;

@property (nonatomic, copy)NSArray *array;
@end

@implementation MainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.array = @[@"qwe", @"asd", @"qwe", @"asda", @"wqe"];
    
    self.formView = [[YHFormView alloc] initWithFrame:CGRectMake(10, 20, self.view.bounds.size.width-20, 300) withHeaderHeight:60 withLineType:FormViewLineALL];
//    self.formView.bounces=NO;
    [self.formView registerHeaderFormClass:[YHFormTestCell class] forCellWithReuseIdentifier:@"YHFormTestCell"];
    [self.formView registerFormClass:[YHFormTestTableCell class] forCellWithReuseIdentifier:@"YHFormTestTableCell"];
    [self.formView registerHeaderFormClass:[YHFormTestCell class] forCellWithReuseIdentifier:@"YHFormTestCell"];
    self.formView.delegate=self;
    self.formView.dataSource=self;
    self.formView.array = self.array;
    [self.view addSubview:self.formView];

}
-(CGFloat )formView:(YHFormView *)formView heightInIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.section%2==0? 60 : 80;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger )section
{
    return section%2==0 ? 5 : 3;
}
-(NSInteger)numberOfSectionsInFromView:(YHFormView *)formView
{
    return self.array.count;
}
-(YHFormBaseCollectionViewCell *)formView:(YHFormView *)formView withCollectionView:(UICollectionView *)collectionView viewForHeaderInIndexPath:(NSIndexPath *)indexPath
{
    YHFormTestCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YHFormTestCell" forIndexPath:indexPath];
    [cell setCellWithModel:self.array[indexPath.row]];
    return cell;
}
-(YHFormBaseTableViewCell *)tableView:(UITableView *)tableView withFormViewIndexPath:(NSIndexPath *)indexPath
{
    YHFormTestTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YHFormTestTableCell"];
    [cell setCellWithTxt:[NSString stringWithFormat:@"%ld，%ld", indexPath.section, indexPath.row]];
    return cell;
}
-(CGFloat)formView:(YHFormView *)formView widthForHeaderInSection:(NSInteger)section
{
    return section==0?100:120;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
