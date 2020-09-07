//
//  TestXVC.m
//  YHForm
//
//  Created by Bryant_YH on 2020/9/4.
//  Copyright © 2020 Bryant_YH. All rights reserved.
//

#import "TestXVC.h"
#import "YHFormHeader.h"
#import "YHFormTestTableCell.h"
#import "TestCollectionViewCell.h"
@interface TestXVC ()< YHTFormViewDataSource, YHTFormViewDelegate>
@property (nonatomic, strong)YHTFormView *formView;
@property (nonatomic, copy)NSArray *array;
@end

@implementation TestXVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.array = @[@"qwe", @"asd", @"ww", @"asda", @"wqe", @"asd",@"qwe", @"asd", @"ww", @"asda", @"wqe", @"asd"];
    self.formView = [[YHTFormView alloc] initWithFrame:CGRectMake(10, 20, self.view.bounds.size.width-20, 300) withHeaderHeight:50 withTitleWidth:100 withType:YHTFormViewDirectionX withLineType:FormViewLineNoneBorder];
    self.formView.array=self.array;
    self.formView.dataSource=self;
    self.formView.delegate=self;
    self.formView.invariantTitle = @"哈哈奥术大师大阿斯蒂芬撒旦法撒旦法sad飞洒发士大夫撒旦所大哈";
    [self.formView registerFormClass:[TestCollectionViewCell class] forCellWithReuseIdentifier:@"TestCollectionViewCell"];
    [self.formView registerLeftHeaderFormClass:[YHFormTestTableCell class] forCellWithReuseIdentifier:@"YHFormTestTableCell"];
    [self.view addSubview:self.formView];
}
-(CGFloat)formView:(YHTFormView *)formView widthForHeaderInSection:(NSInteger)xSection
{
    return 100;
}
-(NSInteger)formViewOfTableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger )section
{
    return 8;
}
///表格内容的行数 YHTFormViewDirectionY时候为行数； YHTFormViewDirectionX时候section为YSection左表头下标
-(NSInteger)formViewOfContentTableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger )section
{
    return section==1 ? 5 : 1;
}
- (CGFloat )formView:(YHTFormView *)formView heightForHeaderInSection:(NSInteger)ySection
{
    return ySection==1? 5*60 : 60;
}
-(CGFloat)formView:(YHTFormView *)formView heightForIndexPath:(YHTIndexPath *)indexPath
{
    return 60;
}
///自定义左表头
-(UITableViewCell *)formViewOfTableView:(UITableView *)tableView withFormViewIndexPath:(NSIndexPath *)indexPath
{
    YHFormTestTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YHFormTestTableCell"];
    [cell setCellWithTxt:[NSString stringWithFormat:@"%ld", indexPath.row]];
    return cell;
}

- (YHFormBaseCollectionViewCell *)formViewOfCollectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(YHTIndexPath *)indexPath
{
    TestCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TestCollectionViewCell" forIndexPath:[NSIndexPath indexPathForRow:indexPath.xSection inSection:0]];
    [cell setCellWithTxt:[NSString stringWithFormat:@"%ld，%ld，%ld", indexPath.ySection, indexPath.xSection,indexPath.form]];

    return cell;
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
