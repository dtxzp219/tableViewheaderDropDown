//
//  CustomTableViewCell.h
//  tableViewheaderDropDown
//
//  Created by ios1 on 15/12/16.
//  Copyright © 2015年 zp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *ageLB;

@property (weak, nonatomic) IBOutlet UILabel *nameLB;
@end
