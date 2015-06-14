//
//  ViewController.swift
//  Maps
//
//  Created by Segun Konibire on 12/06/2015.
//  Copyright (c) 2015 Segun Konibire. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet var map: MKMapView!
    
    
    @IBOutlet var textLongitude: UILabel!
    
    @IBOutlet var textLaitude: UILabel!
    
    @IBOutlet var textAltitude: UILabel!
    
    @IBOutlet var textSpeed: UILabel!
    
    @IBOutlet var textLocation: UILabel!
    
    
    var locationManager = CLLocationManager();
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locationManager.delegate = self
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        locationManager.requestWhenInUseAuthorization()
        
        locationManager.startUpdatingLocation()
        
        
//        var longitude: CLLocationDegrees = -0.09387
//        
//        var latitude: CLLocationDegrees = 51.515656
//        
//        var latDelta: CLLocationDegrees = 0.01
//        
//        var lonDelta: CLLocationDegrees = 0.01
//        
//        var span: MKCoordinateSpan = MKCoordinateSpanMake(latDelta, latDelta)
//        
//        var location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
//        
//        var region: MKCoordinateRegion = MKCoordinateRegionMake(location, span)
//        
//        self.map.setRegion(region, animated: true);
        
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        var userLocation: CLLocation = locations[0] as! CLLocation
    
        var latitude = userLocation.coordinate.latitude
        
        var longitude = userLocation.coordinate.longitude
        
        var latDelta: CLLocationDegrees = 0.01
        
        var lonDelta: CLLocationDegrees = 0.01
        
        var span: MKCoordinateSpan = MKCoordinateSpanMake(latDelta, latDelta)
        
        var location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        
        var region: MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        self.map.setRegion(region, animated: true)
        
        //println(userLocation.altitude)
        
        self.textAltitude.text = String(stringInterpolationSegment: userLocation.altitude)
        
        self.textLongitude.text = String(stringInterpolationSegment: longitude)
        
        self.textLaitude.text = String(stringInterpolationSegment: latitude)
        
        self.textSpeed.text = "\(userLocation.speed)";
        
        self.textLocation.text = "\(userLocation.altitude)";
        
        CLGeocoder().reverseGeocodeLocation(manager.location, completionHandler: {
            
            (placemarks, error)->Void in
            
            dispatch_async(dispatch_get_main_queue()){
            
            if (error != nil) {
                println("Reverse geocoder failed with error" + error.localizedDescription)
                return
            }
            
            if placemarks.count > 0 {
                let pm = placemarks[0] as! CLPlacemark
                self.displayLocationInfo(pm)
                } else {
                    println("Problem with the data received from geocoder")
                }
            }
            
            }
            
            
        )
        
    }
    

    
    
    func displayLocationInfo(placemark: CLPlacemark) {
        
            //stop updating location to save battery life
            //locationManager.stopUpdatingLocation()
        
        var locationString = placemark.thoroughfare + "\n" + placemark.locality + "\n" + placemark.postalCode + "\n" + placemark.administrativeArea + "\n" + placemark.country
        
        self.textLocation.text = locationString;
        
//            println(placemark.locality)
//            println(placemark.postalCode)
//            println(placemark.administrativeArea)
//            println(placemark.country)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

