//
//  ScanViewController.m
//  BFGarage
//
//  Created by baiyufei on 2017/4/23.
//  Copyright © 2017年 com.autohome. All rights reserved.
//

#import "ScanViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ScanViewController ()<UIImagePickerControllerDelegate,AVCaptureVideoDataOutputSampleBufferDelegate>{
    UIImageView *readLineView;//扫描线图片
    UIImageView *coverImage;//扫描框图片
    BOOL is_Anmotion;
    
}
@property (nonatomic,strong) AVCaptureVideoPreviewLayer *captureVideoPreviewLayer;
@property (nonatomic, strong) AVCaptureSession *captureSession;
@end

@implementation ScanViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)viewDidDisappear:(BOOL)animated{
    //[self stopScan];
    [super viewDidDisappear:animated];
}

- (void)initCapture
{
    AVCaptureSession *captureSession = [[AVCaptureSession alloc] init];
    self.captureSession = captureSession;
    
    AVCaptureDevice* inputDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    NSError *error = nil;
    AVCaptureDeviceInput *captureInput = [AVCaptureDeviceInput deviceInputWithDevice:inputDevice error:&error];
    
    if(error){
        
        return;
    }
    
    [self.captureSession addInput:captureInput];
    
    AVCaptureVideoDataOutput *captureOutput = [[AVCaptureVideoDataOutput alloc] init];
    captureOutput.alwaysDiscardsLateVideoFrames = YES;
    [captureOutput setSampleBufferDelegate:self queue:dispatch_get_main_queue()];
    NSString* key = (NSString *)kCVPixelBufferPixelFormatTypeKey;
    NSNumber* value = [NSNumber numberWithUnsignedInt:kCVPixelFormatType_32BGRA];
    NSDictionary *videoSettings = [NSDictionary dictionaryWithObject:value forKey:key];
    [captureOutput setVideoSettings:videoSettings];
    [self.captureSession addOutput:captureOutput];
    
    NSString* preset = 0;
    if (NSClassFromString(@"NSOrderedSet") && // Proxy for "is this iOS 5" ...
        [UIScreen mainScreen].scale > 1 &&
        [inputDevice
         supportsAVCaptureSessionPreset:AVCaptureSessionPresetiFrame960x540]) {
            preset = AVCaptureSessionPresetiFrame960x540;
        }
    if (!preset) {
        preset = AVCaptureSessionPresetMedium;
    }
    self.captureSession.sessionPreset = preset;
    
    if (!self.captureVideoPreviewLayer) {
        self.captureVideoPreviewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.captureSession];
    }
    
    CGRect readFrame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    self.captureVideoPreviewLayer.frame = readFrame;
    self.captureVideoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.view.layer addSublayer: self.captureVideoPreviewLayer];
    
    NSLog(@"222");
}


- (void)viewDidLoad {
    [super viewDidLoad];
    coverImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
    coverImage.image = [UIImage imageNamed:(@"Sony_TVLogin_bound.png")];
    [self.view addSubview:coverImage];
    [self initCapture];
    [self startScan];
}

//循环♻️的绿色扫码条
-(void)loopDrawLine
{
    CGRect  rect = CGRectMake(68/2,126/2, 502/2, 8/2);
    if (readLineView) {
        [readLineView removeFromSuperview];
        readLineView = nil;
    }
    readLineView = [[UIImageView alloc] initWithFrame:rect];
    readLineView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:(@"Sony_TV_Login_Line.png")]];
    [UIView animateWithDuration:3.0
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         //修改fream的代码写在这里
                         readLineView.frame =CGRectMake(68/2,616/2, 502/2, 8/2);
                         [readLineView setAnimationRepeatCount:0];
                     }
                     completion:^(BOOL finished){
                         if (!is_Anmotion) {
                             [self loopDrawLine];
                         }
                     }];
    
    [self.view addSubview:readLineView];
}

//开始扫描
-(void)startScan{
    coverImage.image = [UIImage imageNamed:(@"Sony_TVLogin_bound.png")];
    [self.captureSession startRunning];
    is_Anmotion = NO;
    [self loopDrawLine];
    NSLog(@"333");
}

//扫码条停止循环
-(void)stopScan{
    is_Anmotion = YES;
    //self.isScanning = NO;
    [self.captureSession stopRunning];
    [readLineView removeFromSuperview];
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
