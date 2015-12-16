//
//  CustomTableViewController.m
//  tableViewheaderDropDown
//
//  Created by ios1 on 15/12/16.
//  Copyright © 2015年 zp. All rights reserved.
//


typedef enum : int {
    //当前状态是向下划还是向上划
    directionTop,
    directionDown,
} direction;

#import "CustomTableViewController.h"
#import "CustomTableViewCell.h"

@interface CustomTableViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,assign)direction cusDirection;

@end

@implementation CustomTableViewController
{
    UIImageView *header;
    UIView *view;
    float cacheOffsetY; //当前状态下tableView 的位移
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray=[[NSMutableArray alloc]init];
    NSArray *nameArray=[NSArray arrayWithObjects:@"张三", @"李四",@"王五",@"赵六",@"杨七",nil];
    for ( int i=0; i<15; i++) {
        NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
        [dict setValue:[UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",(int)random()%5]] forKey:@"image"];
        [dict setValue:nameArray[random()%5] forKey:@"name"];
        [dict setValue:[NSString stringWithFormat:@"%d",(int)random()%20] forKey:@"age"];
        [self.dataArray addObject:dict];
    }
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;

    //个人的理解是 header 的位置大小一直不变 所以要做成该效果 改变的是header 上图片的y坐标 
    view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 250)];
    header=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 250)];
    [header setImage:[UIImage imageNamed:@"header.jpg"]];
    header.clipsToBounds=YES;
    [view addSubview:header];
    
    self.tableView.tableHeaderView=view;
    
    self.cusDirection=directionDown;
    // Do any additional setup after loading the view from its nib.
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    
    CGFloat yOffset  = scrollView.contentOffset.y;
    NSLog(@"%.f",yOffset);
    if (yOffset<0) {
        
        header.frame=CGRectMake(0, yOffset, [UIScreen mainScreen].bounds.size.width, (250-yOffset));
        NSLog(@"yyy :%.f",header.frame.origin.y);
    }
    cacheOffsetY=scrollView.contentOffset.y;

}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{    CGFloat yOffset  = scrollView.contentOffset.y;

    if (yOffset>cacheOffsetY) {
        //手指向上滑动
        self.cusDirection=directionDown;
    }
    else
    {
        self.cusDirection=directionTop;

    }
}
-(void)awakeFromNib
{
    NSLog(@"%.f",self.tableView.tableHeaderView.frame.origin.y);
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static  NSString  *CellIdentiferId = @"CustomTableViewCell";
    CustomTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentiferId];
    if (cell == nil) {
        [tableView registerNib:[UINib nibWithNibName:@"CustomTableViewCell" bundle:nil] forCellReuseIdentifier:@"CustomTableViewCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"CustomTableViewCell"];
    };
    [cell.headImage setImage:self.dataArray[indexPath.row][@"image"]];
    cell.nameLB.text= self.dataArray[indexPath.row][@"name"];
    cell.ageLB.text= self.dataArray[indexPath.row][@"age"];
    return cell;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row>0) {
        CATransition *transition=[CATransition animation];
        transition.duration=3;
        transition.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        transition.type=@"cube";
        transition.subtype=kCATransitionFromTop;
        transition.removedOnCompletion=YES;
        if (self.cusDirection ==directionDown) {
            transition.subtype=kCATransitionFromTop;

        }
        else
        {
            transition.subtype=kCATransitionFromBottom;

        }
        [cell.layer addAnimation:transition forKey:@"11"];

    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.dataArray.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
