//
//  ViewController.m
//  MultipleViewControllers
//
//  Created by Коноплев Андрей on 09/11/2018.
//  Copyright © 2018 Коноплев Андрей. All rights reserved.
//

#import "ViewController.h"
#import "FirstChildVC.h"
#import "SecondChildVC.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpChilds];
}


-(void)setUpChilds {
    FirstChildVC *firstVC = (FirstChildVC *)[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"firstChildVC"];
    SecondChildVC *secondVC = (SecondChildVC *)[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"secondChildVC"];
    
    [self addChildViewController: firstVC];
    [self.view addSubview: firstVC.view];
    firstVC.view.frame = CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height);
    [firstVC didMoveToParentViewController: self];
    
    
    [self addChildViewController: secondVC];
    [self.view addSubview: secondVC.view];
    secondVC.view.frame = CGRectMake(0 ,UIScreen.mainScreen.bounds.size.height / 2, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height / 2);
    [secondVC didMoveToParentViewController: self];
    
}


@end
