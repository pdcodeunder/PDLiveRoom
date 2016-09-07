//
//  PDLiveRoomViewController.m
//  PDLiveRoom
//
//  Created by 彭懂 on 16/9/6.
//  Copyright © 2016年 彭懂. All rights reserved.
//

#import "PDLiveRoomViewController.h"
#import "PDBlurImageEffects.h"
#import "PDTableViewDataSource.h"
#import "PDChatModel.h"
#import "PDChatTableViewCell.h"
#import "NSAttributeString+Extent.h"
#import "PDEmitterView.h"

static const NSInteger maxCell = 7;
@interface PDLiveRoomViewController ()

@property (nonatomic, strong) PDTableViewDataSource *dataSource;
@property (nonatomic, strong) NSMutableArray *nickArr;
@property (nonatomic, strong) NSMutableArray *textArr;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) PDEmitterView *emitterView;

@end

@implementation PDLiveRoomViewController

- (PDTableViewDataSource *)dataSource
{
    if (!_dataSource) {
        _dataSource = [[PDTableViewDataSource alloc] init];
        _dataSource.isRow = NO;
    }
    return _dataSource;
}

- (NSMutableArray *)nickArr
{
    if (!_nickArr) {
        _nickArr = [[NSMutableArray alloc] init];
    }
    return _nickArr;
}

- (NSMutableArray *)textArr
{
    if (!_textArr) {
        _textArr = [[NSMutableArray alloc] init];
    }
    return _textArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
}

- (void)setUpUI {
    UIImageView *backImage = [[UIImageView alloc] initWithImage:[PDBlurImageEffects pd_imageEffectLightFromImage:[UIImage imageNamed:@"test"]]];
    backImage.frame = self.view.bounds;
    [self.view addSubview:backImage];
    [self createTableView];
    
    [self setUpDataSource];
}

- (void)createTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 100, 200, 667 - 100 - 60) style:UITableViewStylePlain];
    tableView.showsVerticalScrollIndicator = NO;
    tableView.showsHorizontalScrollIndicator = NO;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundView = [[UIView alloc] init];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.dataSource = self.dataSource;
    tableView.delegate = self.dataSource;
    self.dataSource.rowHeight = 30;
    [self.view addSubview:tableView];
    tableView.transform = CGAffineTransformMakeScale(1, -1);
    self.tableView = tableView;
    
    [self tableViewConfig];
    
    [self setUpEmitterView];
}

- (void)tableViewConfig {
    __block PDLiveRoomViewController *blockSelf = self;
    self.dataSource.tableViewCell = ^UITableViewCell *(UIColor *color, id model) {
        PDChatTableViewCell *cell = [PDChatTableViewCell createChatTableViewCellWithTableView:blockSelf.tableView];
        PDChatModel *chatModel = model;
        [cell setCellAttributTitle:[NSAttributedString attributedStringWithStr:chatModel.nickName anotherString:chatModel.chatText andColor:color]];
        return cell;
    };
}

/**
 *  设置点赞
 */
- (void)setUpEmitterView {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(300, 667.0 - 75, 40, 40);
    [btn setImage:[UIImage imageNamed:@"click"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(emitterClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    PDEmitterView *emitterVeiw = [[PDEmitterView alloc] initWithFrame:CGRectMake(300, 667.0 - 60 - 400, 60, 400)];
    [self.view addSubview:emitterVeiw];
    self.emitterView = emitterVeiw;
}

- (void)emitterClicked:(UIButton *)sender
{
    [self.emitterView sendUpEmitter];
}

/**
 *  造点假数据
 */
- (void)setUpDataSource
{
    for (NSInteger i = 0; i < 6; i++) {
        NSString *nick = [NSString stringWithFormat:@"用户%zd", i];
        NSMutableString *text = [[NSMutableString alloc] initWithString:@"哈"];
        for (NSInteger j = 0; j <= i; j++) {
            [text appendFormat:@"哈"];
        }
        [text appendFormat:@"%zd", i];
        [self.nickArr addObject:nick];
        [self.textArr addObject:text];
    }
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(sendMessage) userInfo:nil repeats:YES];
}

NSInteger number = 0;
- (void)sendMessage
{
    NSString *nick = self.nickArr[arc4random() % 6];
    NSString *text = self.textArr[arc4random() % 6];
    PDChatModel *model = [[PDChatModel alloc] init];
    model.nickName = nick;
    model.chatText = text;
    [self.dataSource.dataSourceArr insertObject:model atIndex:0];
    [self.tableView insertSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationTop];
    if (self.dataSource.dataSourceArr.count > maxCell) {
        [self.dataSource.dataSourceArr removeLastObject];
        [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:self.dataSource.dataSourceArr.count] withRowAnimation:UITableViewRowAnimationNone];
    }
    // 自动发赞
    if (number % 2 == 0) {
//        [self.emitterView sendUpEmitter];
    }
    number ++;
}

@end
