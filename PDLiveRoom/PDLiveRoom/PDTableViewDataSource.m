//
//  PDTableViewModel.m
//  PDLiveRoom
//
//  Created by 彭懂 on 16/9/6.
//  Copyright © 2016年 彭懂. All rights reserved.
//

#import "PDTableViewDataSource.h"
#import "PDChatModel.h"

@interface PDTableViewDataSource ()

@property (nonatomic, strong) NSMutableDictionary *nickColorDic;

@end

@implementation PDTableViewDataSource

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.isRow = YES;
        self.dataSourceArr = [[NSMutableArray alloc] init];
        self.nickColorDic = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableVie
{
    if (self.isRow) {
        return 1;
    } else {
        return self.dataSourceArr.count;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.isRow) {
        return self.dataSourceArr.count;
    } else {
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.rowHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.headView) {
        return self.headView;
    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PDChatModel *model = self.dataSourceArr[indexPath.section];
    UITableViewCell *cell = nil;
    if (self.tableViewCell) {
        UIColor *color = self.nickColorDic[model.nickName];
        if (!color) {
            NSArray *colors = kCColorZuHe;
            color = (UIColor *)colors[arc4random() % 10];
            [self.nickColorDic setObject:color forKey:model.nickName];
        }
        cell = self.tableViewCell(color, model);
    } else {
        cell = [[UITableViewCell alloc] init];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.headView) {
        return self.headView.bounds.size.height;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc] init];
}

@end
