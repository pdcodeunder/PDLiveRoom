//
//  PDChatTableViewCell.m
//  PDLiveRoom
//
//  Created by 彭懂 on 16/9/6.
//  Copyright © 2016年 彭懂. All rights reserved.
//

#import "PDChatTableViewCell.h"

@interface PDChatTableViewCell ()

/**
 *  此处可以用lable直接使用
 */
@property (nonatomic, strong) UIView *mainView;

@end

@implementation PDChatTableViewCell

+ (instancetype)createChatTableViewCellWithTableView:(UITableView *)tableView
{
    PDChatTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PDChatTableViewCell"];
    if (!cell) {
        cell = [[PDChatTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PDChatTableViewCell"];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.textLabel.font = [UIFont systemFontOfSize:14.0];
        self.textLabel.transform = CGAffineTransformMakeScale(1, -1);
        [self setUpCellUI];
    }
    return self;
}

- (void)setUpCellUI {
    UIView *cornerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    cornerView.backgroundColor = [UIColor whiteColor];
    cornerView.layer.cornerRadius = 3.0;
    cornerView.layer.masksToBounds = YES;
    [self.contentView insertSubview:cornerView belowSubview:self.textLabel];
    self.mainView = cornerView;
}

- (void)setCellAttributTitle:(NSAttributedString *)str
{
    // 这里就不考虑多行的情况了，可以根据具体需求具体对待
    self.textLabel.attributedText = str;
    CGRect rect = [str.string boundingRectWithSize:CGSizeMake(0, 18) options: NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0]} context:nil];
    self.mainView.frame = CGRectMake(0, 0, 30 + rect.size.width, 30);
}

@end
