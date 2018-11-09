//
//  SecondChildVC.m
//  MultipleViewControllers
//
//  Created by Коноплев Андрей on 09/11/2018.
//  Copyright © 2018 Коноплев Андрей. All rights reserved.
//

#import "SecondChildVC.h"

@interface SecondChildVC ()
@property (weak, nonatomic) IBOutlet UILabel *textLabel;

@end

@implementation SecondChildVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _textLabel.text = @"Выберите страну или регион, чтобы контент и онлайн-товары соответствовали вашему местоположению.";
}



@end
