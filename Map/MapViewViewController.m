//
//  ViewController.m
//  Map
//
//  Created by GG on 16/3/9.
//  Copyright © 2016年 GG. All rights reserved.
//

#import "MapViewViewController.h"
#import <MapKit/MapKit.h>
@interface MapViewViewController ()<MKMapViewDelegate,CLLocationManagerDelegate>
{
    
    MKMapView *_mapView;
    
    
    
    
}

@property (nonatomic,retain) CLGeocoder *geocoder;
@property (nonatomic,retain) CLLocationManager *locationManager;
@end

@implementation MapViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"地图展示";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _locationManager = [[CLLocationManager alloc]init];
    [_locationManager requestAlwaysAuthorization];
    [_locationManager requestWhenInUseAuthorization];
    
    
    _mapView = [[MKMapView alloc]initWithFrame:self.view.frame];
    
    
    _mapView.userTrackingMode = MKUserTrackingModeFollowWithHeading;
    
    
    //
    _mapView.mapType = MKMapTypeStandard;
    
    //    显示标尺
    _mapView.showsScale = YES;
    //    显示交通状态
    _mapView.showsTraffic = YES;
    //    显示罗盘
    _mapView.showsCompass = YES;
    
    _mapView.delegate = self;
    
    
    //显示用户位置
    _mapView.showsUserLocation = YES;
    
    [self.view addSubview:_mapView];
    
    
    
}

// 代理方法
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    
    NSLog(@"用户位置更新");
}

- (void)mapView:(MKMapView *)mapView didFailToLocateUserWithError:(NSError *)error{
    
    NSLog(@"定位失败%@",error);
}




@end
