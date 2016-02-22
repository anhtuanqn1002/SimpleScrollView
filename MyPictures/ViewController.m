//
//  ViewController.m
//  MyPictures
//
//  Created by Nguyen Van Anh Tuan on 11/23/15.
//  Copyright © 2015 Nguyen Van Anh Tuan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UIScrollView *scroller;
@property (strong, nonatomic) UIPageControl *pageControl;
@property (strong, nonatomic) NSMutableArray *listImages;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.listImages = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < 9; i++) {
        [self.listImages addObject:[UIImage imageNamed:[NSString stringWithFormat:@"25%ld.jpg", (long)i]]];
    }
    
    //init pagecontrol
    self.pageControl = [[UIPageControl alloc] init];
    self.pageControl.frame = CGRectMake(100, self.view.frame.size.height - 70, self.view.frame.size.width - 200, 100);
    self.pageControl.numberOfPages = [self.listImages count];
    self.pageControl.currentPage = 0;
    //add event when has changed value (clicked on pagecontrol)
    [self.pageControl addTarget:self action:@selector(clickPageControl:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.pageControl];
    
    //cho phep scroll theo tung page
    self.scroller.pagingEnabled = YES;
    //set mau thanh truot scrollview
    [self.scroller setIndicatorStyle:UIScrollViewIndicatorStyleDefault];
    
    self.scroller.delegate = self;
    
    NSInteger width = self.scroller.frame.size.width;
    NSInteger height = self.scroller.frame.size.height;
    
    NSInteger numberOfView = [self.listImages count];
    
    for (NSInteger i = 0; i < numberOfView; i++) {
        CGFloat xOrigin = i * width;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(xOrigin, 0, width, height)];
        [imageView setImage:[self.listImages objectAtIndex:i]];
        [self.scroller addSubview:imageView];
    }
    
    self.scroller.contentSize = CGSizeMake(numberOfView * width, height);
}

- (void)clickPageControl:(id)sender {
    //contentOffset is current content's position
    UIPageControl *pageControl = sender;
    [self.scroller setContentOffset:CGPointMake(pageControl.currentPage * (self.scroller.contentSize.width / [self.listImages count]), self.scroller.contentOffset.y) animated:NO];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat pageWidth = self.scroller.frame.size.width;
//    CGFloat pageWidth = self.view.frame.size.width;
    NSLog(@"%f - %f", self.scroller.contentOffset.x, self.scroller.contentOffset.x - pageWidth/2);
    NSInteger page = floor(self.scroller.contentOffset.x / pageWidth);
    self.pageControl.currentPage = page;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
