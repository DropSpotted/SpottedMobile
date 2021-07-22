import UIKit
import Flutter
import MapKit

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    var span: CLLocationDegrees = 0.01
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        let batteryChannel = FlutterMethodChannel(name: "samples.flutter.dev/battery",
                                                  binaryMessenger: controller.binaryMessenger)
        batteryChannel.setMethodCallHandler({
            [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            // Note: this method is invoked on the UI thread.
            guard call.method == "getBatteryLevel" else {
                result(FlutterMethodNotImplemented)
                return
            }
            
            if let args = call.arguments as? Dictionary<String, Any>,
                let imgWidth = args["imgWidth"] as? Double,
                let lat = args["lat"] as? Double,
               let lon = args["lon"] as? Double {
                DispatchQueue.main.async {
                    self?.receiveBatteryLevel(result: result, lat: lat, lon: lon, imgWidth: imgWidth)
                    //                    self.imageView.image = image
                }
            } else {
                result(FlutterError.init(code: "bad args", message: nil, details: nil))
            }
            
            var args = call.arguments as? Dictionary<String, Any>
            
            //            DispatchQueue.main.async {
            //                self?.receiveBatteryLevel(result: result)
            ////                    self.imageView.image = image
            //                }
            //            self?.receiveBatteryLevel(result: result)
        })
        
        
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    private func receiveBatteryLevel(result: @escaping FlutterResult, lat: Double, lon: Double, imgWidth: Double?) {
        let coordinates = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        let region = MKCoordinateRegion(
            center:coordinates,
            span: MKCoordinateSpan(
                latitudeDelta: self.span,
                longitudeDelta: self.span
            )
        )
        
        // Map options.
        let mapOptions = MKMapSnapshotter.Options()
        mapOptions.region = region
        mapOptions.showsBuildings = true
        mapOptions.showsPointsOfInterest = true
        if let unwrappedWidth = imgWidth {
            mapOptions.size = CGSize(width: unwrappedWidth, height: unwrappedWidth * 1/2)
        }
        
        //        mapOptions.size = CGSize(width: 300, height: 300)
        //        mapSnapshotOptions.showsBuildings = true
        
        // Create the snapshotter and run it.
        let snapshotter = MKMapSnapshotter(options: mapOptions)
        
        snapshotter.start {  (snapshotOrNil, errorOrNil)  in
            if let error = errorOrNil {
                print(error)
                //                result(nil)
                return
            }
            if let snapshot = snapshotOrNil {
                var xd = snapshot.image;
                var imageData = xd.jpegData(compressionQuality: 1.0)
                print("ass")
                if let imageFromData =  imageData {
                    var flutterType = FlutterStandardTypedData(bytes: imageFromData)
                    result(flutterType) // (719.0, 808.0)
                }
                
                
                
                //                self.snapshotImage = snapshot.image
            }
        }
        
        
        //        result(Int(666))
        //        let device = UIDevice.current
        //        device.isBatteryMonitoringEnabled = true
        //        if device.batteryState == UIDevice.BatteryState.unknown {
        //            result(Int(666))
        //        } else {
        //            result(Int(device.batteryLevel * 100))
        //        }
    }
    
    
}
