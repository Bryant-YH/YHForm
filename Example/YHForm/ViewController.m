//
//  ViewController.m
//  YHForm
//
//  Created by Bryant_YH on 2020/8/25.
//  Copyright © 2020 Bryant_YH. All rights reserved.
//

#import "ViewController.h"
#import "YHFormHeader.h"
#import "YHFormTestTableCell.h"
@interface ViewController ()< YHTFormViewDataSource, YHTFormViewDelegate>
@property (nonatomic, strong)YHTFormView *formView;
@property (nonatomic, copy)NSArray *array;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.array = @[@"qwe", @"asd", @"ww", @"asda", @"wqe", @"asd",@"qwe", @"asd", @"ww", @"asda", @"wqe", @"asd"];
    self.formView = [[YHTFormView alloc] initWithFrame:CGRectMake(10, 20, 300, 300) withHeaderHeight:50 withTitleWidth:100 withType:YHTFormViewDirectionY withLineType:FormViewLineALL];
//    self.formView.bounces=NO;
    self.formView.array=self.array;
    self.formView.dataSource=self;
    self.formView.delegate=self;
    self.formView.invariantTitle = @"哈哈奥术大师大阿斯蒂芬撒旦法撒旦法sad飞洒发士大夫撒旦所大哈";
    [self.formView registerLeftHeaderFormClass:[YHFormTestTableCell class] forCellWithReuseIdentifier:@"YHFormTestTableCell"];
    [self.formView registerFormClass:[YHFormTestTableCell class] forCellWithReuseIdentifier:@"YHFormTestTableCell"];

    [self.view addSubview:self.formView];
}

- (CGFloat )formView:(YHTFormView *)formView heightForHeaderInSection:(NSInteger)ySection
{
    return ySection==1? 5*60 : 60;
}
-(CGFloat)formView:(YHTFormView *)formView widthForHeaderInSection:(NSInteger)xSection
{
    return xSection==0?100:120;
}
-(CGFloat)formView:(YHTFormView *)formView heightForIndexPath:(YHTIndexPath *)indexPath
{
    return 60;
}
-(NSInteger)formViewOfTableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}
-(NSInteger)formViewOfContentTableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger )section
{
    if (section==1)
    {
        return 5;
    }
    return section+1;
}
-(YHFormBaseTableViewCell *)formViewOfTableView:(UITableView *)tableView withFormViewIndexPath:(NSIndexPath *)indexPath
{
    YHFormTestTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YHFormTestTableCell"];
    [cell setCellWithTxt:[NSString stringWithFormat:@"%ld", indexPath.row]];
    return cell;
}
-(YHFormBaseTableViewCell *)formViewOfContentTableView:(UITableView *)tableView withFormViewIndexPath:(YHTIndexPath *)indexPath
{
    YHFormTestTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YHFormTestTableCell"];
    [cell setCellWithTxt:[NSString stringWithFormat:@"%ld，%ld，%ld", indexPath.xSection, indexPath.ySection,indexPath.form]];
    return cell;
}
@end
