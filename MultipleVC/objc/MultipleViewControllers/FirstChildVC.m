//
//  FirstChildVC.m
//  MultipleViewControllers
//
//  Created by Коноплев Андрей on 09/11/2018.
//  Copyright © 2018 Коноплев Андрей. All rights reserved.
//

#import "FirstChildVC.h"

@interface FirstChildVC () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation FirstChildVC

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10000;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier:@""];
    cell.textLabel.text = [NSString stringWithFormat:@"number %ld", (long)indexPath.row];
    return cell;
}



@end


