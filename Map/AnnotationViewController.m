//
//  ViewController.m
//  Map
//
//  Created by GG on 16/3/9.
//  Copyright © 2016年 GG. All rights reserved.
//

#import "AnnotationViewController.h"
#import <MapKit/MapKit.h>
#import "DetailViewController.h"
@interface AnnotationViewController ()<MKMapViewDelegate,CLLocationManagerDelegate>
{
    
    MKMapView *_mapView;
    
    
}

@property (nonatomic,retain) CLGeocoder *geocoder;
@property (nonatomic,retain) CLLocationManager *locationManager;
@end

@implementation AnnotationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"大头针";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _locationManager = [[CLLocationManager alloc]init];
    [_locationManager requestAlwaysAuthorization];
    [_locationManager requestWhenInUseAuthorization];
    
    
    _mapView = [[MKMapView alloc]initWithFrame:self.view.frame];
    
    _mapView.delegate = self;
    
    _mapView.userTrackingMode = MKUserTrackingModeFollowWithHeading;
    
    _mapView.mapType = MKMapTypeStandard;
    
    //    显示标尺
    _mapView.showsScale = YES;
    //    显示交通状态
    _mapView.showsTraffic = YES;
    //    显示罗盘
    _mapView.showsCompass = YES;
    
    _mapView.delegate = self;
    
    _mapView.showsUserLocation = YES;
    
    [self.view addSubview:_mapView];
    
    
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressClick:)];
    
    [_mapView addGestureRecognizer:longPressGesture];
    
    
    
}




- (void)longPressClick:(UIGestureRecognizer *)sender{
    
    if (sender.state != UIGestureRecognizerStateBegan) {
        
        return;
        
    }

    //根据在试图上点击的位置获取到所点的坐标位置
    CLLocationCoordinate2D coordinate = [_mapView convertPoint:[sender locationInView:self.view] toCoordinateFromView:sender.view];
    

    CLLocation *location = [[CLLocation alloc]initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    
    
    // 反编码
    [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        MKPointAnnotation *annotation = [[MKPointAnnotation alloc]init];
        
        annotation.coordinate = coordinate;
        
        annotation.title = placemarks.firstObject.name;
        
        [_mapView addAnnotation:annotation];
    }];
    
    
}


- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    
    
    MKCoordinateSpan span = MKCoordinateSpanMake(0.1, 0.1);//跨度越大，地图所显示的区域越大
    MKCoordinateRegion regoin = MKCoordinateRegionMake(userLocation.location.coordinate, span);
    [mapView setRegion:regoin animated:YES];
    
    
    
}

- (void)mapView:(MKMapView *)mapView didFailToLocateUserWithError:(NSError *)error {
    
    NSLog(@"定位失败：%@",error);
    
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view{
    
    DetailViewController *detailVC = [DetailViewController new];
    
    detailVC.view.backgroundColor = [UIColor whiteColor];
    
    //获取到该大头针试图的数据模型
    MKPointAnnotation *annotation = view.annotation;
    
    detailVC.title = annotation.title;
    
    //判断当前点击的大头针是不是显示当前用户位置的大头针，如果是就让他变色
    /*
     * MKPinAnnotationView是MKAnnotationView的子类，相比MKAnnotationView而言，他能够设置大头针颜色和显示大头针时的动画
    
     */
    if (![view.annotation isKindOfClass:[MKUserLocation class]]) {
        
        MKPinAnnotationView *pinView = (MKPinAnnotationView *)view;
        
        pinView.pinTintColor = [UIColor yellowColor];
    }
    
    [self.navigationController pushViewController:detailVC animated:YES];
    
}

- (nullable MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    
    //查看MKUserLocation后可以发现,MKUserLocation实现了MKAnnotation协议，所以MKUserLocation也是一个大头针模型，只不过这个模型比较特殊，用来表示用户当前位置
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        
        MKAnnotationView *userAnnotationView = [[MKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"userAnnotation"];
        
        userAnnotationView.image = [UIImage imageNamed:@"person.png"];
        
        //如果将大头针给自定义会变成不可交互，将canShowCallout设为YES便可恢复交互
        userAnnotationView.canShowCallout = YES;
        
        //仅仅实现了让用户大头针在地图试图上往右偏了100
        //userAnnotationView.centerOffset = CGPointMake(100, 0);
        
        //让大头针的详情试图在地图试图上偏移，默认是在用户大头针的顶部
        //userAnnotationView.calloutOffset = CGPointMake(100, 0);
        
        //是否可以移动大头针
        userAnnotationView.draggable = YES;
        
        UIImageView *imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"person.png"]];
        imgView.backgroundColor = [UIColor redColor];
        imgView.frame = CGRectMake(0, 0, 5, 200);
        
        //leftCalloutAccessoryView的试图只有高度能够设置
        userAnnotationView.leftCalloutAccessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"person.png"]];
        userAnnotationView.rightCalloutAccessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"person.png"]];
        
        
        return userAnnotationView;
    }
    
    return nil;
    
}

- (CLGeocoder *)geocoder{
    
    if (_geocoder == nil) {
        
        _geocoder = [[CLGeocoder alloc]init];
        
    }
    
    return _geocoder;
}

@end
