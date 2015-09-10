//
//  ViewController.swift
//  BusBeta
//
//  Created by Rahul Patel on 8/11/15.
//  Copyright (c) 2015 Rahul Patel. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    @IBOutlet weak var BusRoute: UITextField!
    
    
    @IBOutlet weak var Station: UITextField!
    
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pickerView.dataSource = self
        self.pickerView.delegate = self
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "santaCruz1.png")!)
        // Do any additional setup after loading the view, typically from a nib.
        
       /* let testObject: PFObject = PFObject(className: "TestClass")
        testObject["SomeProperty"] = "SomeValue"
        testObject.saveInBackgroundWithBlock(nil)
        */
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var DestViewController: ViewMap = segue.destinationViewController as! ViewMap
        var DestViewController1: ViewMap = segue.destinationViewController as! ViewMap
        
        DestViewController.LabelText = BusRoute.text
        DestViewController1.StationText = Station.text
    
         //DestViewController.LabelText = Station.text
    
    
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
    "Santa Cruz Metro Center"]
    
    
    //var bay
    
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
              Station.text = bay
        }
   
    
    
    
    


}

