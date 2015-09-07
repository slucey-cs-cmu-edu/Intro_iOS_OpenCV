//
//  ViewController.m
//  Intro_iOS_OpenCV
//
//  Created by Simon Lucey on 9/7/15.
//  Copyright (c) 2015 CMU_16432. All rights reserved.
//

#import "ViewController.h"

#ifdef __cplusplus
#import <opencv2/opencv.hpp>
#import "opencv2/highgui/ios.h"
#endif

// Include iostream and std namespace so we can mix C++ code in here
#include <iostream>
using namespace std;

@interface ViewController () {
    // Setup the view
    UIImageView *imageView_;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 1. Setup the your imageView_ view, so it takes up the entire App screen......
    imageView_ = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.height)];
    
    // 2. Important: add OpenCV_View as a subview
    [self.view addSubview:imageView_];
    
    // 3.Read in the image (of the famous Lena)
    UIImage *image = [UIImage imageNamed:@"lena.png"];
    if(image != nil) imageView_.image = image; // Display the image if it is there....
    else cout << "Cannot read in the file" << endl;
    
    // 4. Next convert to a cv::Mat
    cv::Mat cvImage; UIImageToMat(image, cvImage);
    
    // 5. Now apply some OpenCV operations
    cv::Mat gray; cv::cvtColor(cvImage, gray, CV_RGBA2GRAY); // Convert to grayscale
    cv::GaussianBlur(gray, gray, cv::Size(5,5), 1.2, 1.2); // Apply Gaussian blur
    cv::Mat edges; cv::Canny(gray, edges, 0, 50); // Estimate edge map using Canny edge detector
    
    // 6. Finally display the result
    imageView_.image = MatToUIImage(edges);
    
    // ALL DONE :)
}
@end