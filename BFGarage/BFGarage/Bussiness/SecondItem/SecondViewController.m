//
//  SecondViewController.m
//  BFGarage
//
//  Created by baiyufei on 2017/4/23.
//  Copyright © 2017年 com.autohome. All rights reserved.
//

#import "SecondViewController.h"
#import "DeviceTableViewCell.h"

@interface SecondViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, weak) IBOutlet UIButton *linkButton;
@property(nonatomic, weak) IBOutlet UIButton *scanButton;

@property(nonatomic, weak) IBOutlet UITableView *rootTableView;

//列表数据
@property (nonatomic, strong) NSMutableArray *rootTableArray;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UINib *UserCenterLeftContentCellNib = [UINib nibWithNibName:@"DeviceTableViewCell" bundle:nil];
    [self.rootTableView registerNib:UserCenterLeftContentCellNib forCellReuseIdentifier:@"DeviceTableViewCell"];
    
    self.navigationItem.title = @"Setting";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate & UITableViewDatasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.rootTableArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndentifierStr = @"DeviceTableViewCellIdentifier";
    DeviceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifierStr forIndexPath:indexPath];
    
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
