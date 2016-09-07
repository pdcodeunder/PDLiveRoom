//
//  PDChatTableViewCell.h
//  PDLiveRoom
//
//  Created by 彭懂 on 16/9/6.
//  Copyright © 2016年 彭懂. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PDChatTableViewCell : UITableViewCell

+ (instancetype)createChatTableViewCellWithTableView:(UITableView *)tableView;

- (void)setCellAttributTitle:(NSAttributedString *)str;

@end
