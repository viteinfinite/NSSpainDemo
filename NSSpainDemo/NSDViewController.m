//
//  NSDViewController.m
//  NSSpainDemo
//
//  Created by Simone Civetta on 17/09/14.
//  Copyright (c) 2014 SimoneCivetta. All rights reserved.
//

#import "NSDViewController.h"
#import "NSDLoveGenerator.h"

@interface NSDViewController ()

@end

@implementation NSDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSDLoveGenerator *generator = [[NSDLoveGenerator alloc] initWithLoveCount:5];
    self.loveLabel.text = [generator giveMeSomeLove];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
