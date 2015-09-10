//
//  Map.swift
//  BusBeta
//
//  Created by Rahul Patel on 8/11/15.
//  Copyright (c) 2015 Rahul Patel. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class ViewMap: UIViewController, MKMapViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource{
    
    
    @IBOutlet weak var Label: UILabel!
    
    @IBOutlet weak var toChatRoom: UIButton!
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var stationLabel:UILabel!
    
    @IBOutlet weak var pinSlider: UISwitch!
   
    @IBOutlet weak var pickerView: UIPickerView!
    
   // @IBOutlet weak var pickerView: UIPickerView!
    
    
    
    
    var StationText = String()
    
    var LabelText = String() 
    
    override func viewDidLoad(){
        self.pickerView.dataSource = self
        self.pickerView.delegate = self

        
        Label.text = LabelText
        
        stationLabel.text = StationText
        
         mapView.delegate = self
        
        zoomToRegion()
        
        pinSlider.addTarget(self, action: Selector("sliderAnnotations: "), forControlEvents: UIControlEvents.ValueChanged)
        
        sliderAnnotations(pinSlider)
       
        /*let annotations = getMapAnnotations()
        
        //mapView.addAnnotations(annotations)
        
        
        mapView.delegate = self
        
        // Connect all the mappoints using Poly line.
        
        var points: [CLLocationCoordinate2D] = [CLLocationCoordinate2D]()
        
        for annotation in annotations {
            points.append(annotation.coordinate)
        }
        
        
        var polyline = MKPolyline(coordinates: &points, count: points.count)
        
        mapView.addOverlay(polyline)*/
        
        var stations: NSArray?
        let path = NSBundle.mainBundle().pathForResource("Route16", ofType: "plist")
        stations = NSArray(contentsOfFile: path!)
        if let stations = NSArray (contentsOfFile: path!){
            for item in stations {
                let lat = item.valueForKey("lat") as! Double
                let long = item.valueForKey("long")as! Double
                let annotation = Station(latitude: lat, longitude: long)
                annotation.title = item.valueForKey("title") as? String
                if(annotation.title == stationLabel.text){
                    mapView.addAnnotation(annotation)
                }
            }
        }

        
    }
    
    
    @IBAction func clicked(sender: UIButton) {
        if pinSlider.on {
            println("Switch is on")
            pinSlider.setOn(false, animated:true)
            
            let annotations = getMapAnnotations()
            
            mapView.addAnnotations(annotations)
            
            
            mapView.delegate = self
            
            // Connect all the mappoints using Poly line.
            
            var points: [CLLocationCoordinate2D] = [CLLocationCoordinate2D]()
            
            for annotation in annotations {
                points.append(annotation.coordinate)
            }
            
            
            var polyline = MKPolyline(coordinates: &points, count: points.count)
            
        } else {
            pinSlider.setOn(true, animated:true)
            mapView.removeAnnotations(mapView.annotations)
        }
    }
    
    
    
    
    func sliderAnnotations(sender: UISwitch) {
        let annotations = getMapAnnotations()
        if(sender.on){
            println("bad")
            //mapView.addAnnotations(annotations)
            mapView.delegate = self
            
            // Connect all the mappoints using Poly line.
            
            var points: [CLLocationCoordinate2D] = [CLLocationCoordinate2D]()
            
            for annotation in annotations {
                points.append(annotation.coordinate)
            }
            
            
            var polyline = MKPolyline(coordinates: &points, count: points.count)
            
            mapView.addOverlay(polyline)

            
        }else{
        
        }
    }

    
    
    
    func zoomToRegion(){
        let location = CLLocationCoordinate2DMake(36.967318, -122.039102)
        let region = MKCoordinateRegionMakeWithDistance(location, 5000.0, 7000.0)
        mapView.setRegion(region, animated: true)
    }
    
    func getMapAnnotations() -> [Station] {
        var annotations:Array = [Station]()
        
        //load plist file
        
        var stations: NSArray?
        
        if(Label.text == "10"){
        if let path = NSBundle.mainBundle().pathForResource("Route10", ofType: "plist") {
            stations = NSArray(contentsOfFile: path)
            }
        }else if(Label.text == "16"){
            if let path = NSBundle.mainBundle().pathForResource("Route16", ofType: "plist") {
                stations = NSArray(contentsOfFile: path)
            }
        }else if(Label.text == "19"){
            if let path = NSBundle.mainBundle().pathForResource("Route19", ofType: "plist") {
                stations = NSArray(contentsOfFile: path)
            }
        }else if(Label.text == "20"){
            if let path = NSBundle.mainBundle().pathForResource("Route20", ofType: "plist") {
                stations = NSArray(contentsOfFile: path)
            }
        }


        
        
        if let items = stations {
            for item in items {
                let lat = item.valueForKey("lat") as! Double
                let long = item.valueForKey("long")as! Double
                let annotation = Station(latitude: lat, longitude: long)
                annotation.title = item.valueForKey("title") as? String
                annotations.append(annotation)
            }
        }
        
        return annotations
    }
    
    func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer! {
        if overlay is MKPolyline {
            var polylineRenderer = MKPolylineRenderer(overlay: overlay)
            polylineRenderer.strokeColor = UIColor.blueColor()
            polylineRenderer.lineWidth = 2
            return polylineRenderer
        }
        
        return nil
    }
    
    
    @IBAction func toChat(sender: AnyObject) {
        if(Label.text == "10"){
        let chatRoom = self.storyboard?.instantiateViewControllerWithIdentifier("chatRoom") as! ChatRoom
            self.navigationController?.pushViewController(chatRoom, animated: true)
        } else if(Label.text == "16"){
        let chatRoom = self.storyboard?.instantiateViewControllerWithIdentifier("chatRoom16") as! ChatRoom16
            self.navigationController?.pushViewController(chatRoom, animated: true)
            
        }
    }
    
    
    
    
    @IBAction func locationTapped(sender: UIButton) {
       //  if(stationLabel.text == "Bay & Meder"){
            
            var stations: NSArray?
            let path = NSBundle.mainBundle().pathForResource("Route16", ofType: "plist")
            stations = NSArray(contentsOfFile: path!)
            if let stations = NSArray (contentsOfFile: path!){
          //  if let items = stations{
            for item in stations {
                let lat = item.valueForKey("lat") as! Double
                let long = item.valueForKey("long")as! Double
                let annotation = Station(latitude: lat, longitude: long)
                annotation.title = item.valueForKey("title") as? String
                if(annotation.title == stationLabel.text){
                  //  let dropPin = MKPointAnnotation()
                    //let location = CLLocationCoordinate2DMake(36.976975, -122.053695)
                    //dropPin.coordinate = location
                   // mapPin(mapView, viewforAnnotation: dropPin)
                  //  mapS(mapView, viewForAnnotation: annotation)
                    mapView.addAnnotation(annotation)
                  //  mapView.addAnnotation(dropPin)
                    
              // }
             //   }
                }
            }
            
        /*var ann:Array = [Station]()
        println("test")
        let lat = 36.965488 as Double
        let long = -122.046100 as Double
        let annotation = Station(latitude: lat, longitude: long)
        annotation.title = "Bus is here"
       // ann.append(annotation)
        mapView.addAnnotation(annotation)*/
        }
    }

    func mapPin(mapView: MKMapView!, viewforAnnotation annotation: MKPointAnnotation!) ->MKAnnotationView!{
        /*if annotation is MKUserLocation{
            return nil
        }*/
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId) as? MKPinAnnotationView
       if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.animatesDrop = true
            pinView!.pinColor = .Purple
        } else {
            pinView!.annotation = annotation
        }
        return pinView
    }
    
    
    func mapS(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        
        
        
            let pinAnnotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "myPin")
            
            pinAnnotationView.pinColor = .Purple
            pinAnnotationView.draggable = true
            pinAnnotationView.canShowCallout = true
            pinAnnotationView.animatesDrop = true
            
            
            return pinAnnotationView
    }
    var pickerDataSource = ["Bay & Meder",
        "Laurel & Washington/Center",
        "Laurel & Blackburn",
        "Mission & Laurel",
        "Bay & Mission",
        "Bay & King",
        "Bay & Escalona",
        "Bay & Iowa",
        "Bay & Meder",
        "Coolidge & Main Entrance",
        "Coolidge & Hagar",
        "Hagar & Lower Quarry Rd",
        "Hagar & East Remote",
        "Hagar & Field House East",
        "Hagar & Bookstore-Stevenson College",
        "McLaughlin & Crown College",
        "McLaughlin & College 9 & 10",
        "McLaughlin & Science Hill",
        "Heller & Kresge College",
        "Heller & College 8/Porter",
        "Heller & Family Student Housing",
        "Heller & Oakes College",
        "Empire Grade & Arboretum",
        "Empire Grade & Tosca Terrace",
        "High & Western Dr",
        "Bay & High",
        "Bay & Nobel",
        "Bay & King to MS",
        "Bay & Mission to MS",
        "Mission & Laurel to MS",
        "Laurel & Blackburn to MS",
        "Laurel & Chestnut",
        "Laurel & Washington/Center to MS",
        "Santa Cruz Metro Center"] ;
   
    
   /* func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count;
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return pickerDataSource[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        var bay = pickerDataSource[row]
        stationLabel.text = bay
    }*/
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count;
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return pickerDataSource[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        var bay = pickerDataSource[row]
        stationLabel.text = bay
    }

    
    
}
