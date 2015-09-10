//
//  ChatRoom.swift
//  BusBeta
//
//  Created by Rahul Patel on 8/12/15.
//  Copyright (c) 2015 Rahul Patel. All rights reserved.
//

import UIKit
import Foundation
import Parse

class ChatRoom16: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate{
    
    
    /*@IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var messageTableView: UITableView!
    
    @IBOutlet weak var messageTextField: UITextField!
    
    @IBOutlet weak var sendButton: UIButton!*/
    
    @IBOutlet weak var messageTableView: UITableView!
    
    @IBOutlet weak var messageTextField: UITextField!
    
    @IBOutlet weak var sendButton: UIButton!
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
   /* @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var messageTableView: UITableView!
    
    @IBOutlet weak var messageTextField: UITextField!
    
    @IBOutlet weak var sendButton: UIButton!*/
    
    var messagesArray: [String] = [String]()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        
        self.messageTextField.delegate = self
        
        self.messageTableView.delegate = self
        self.messageTableView.dataSource = self
        
        
        //add tap gesture
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "tableViewTapped")
        self.messageTableView.addGestureRecognizer(tapGesture)
        
        //retrieve messages from parse
        
        self.retrieveMessages()
        
    }
    
    
    @IBAction func sendButtonTapped(sender: UIButton) {
    
    
    //@IBAction func sendButtonTapped(sender: UIButton) {
    
        //send button is tapped
        self.messageTextField.endEditing(true)
        
        //disable send button and text field
        self.messageTextField.enabled = false
        self.sendButton.enabled = false
        
        
        
        //Create a PF object
        var newMessageObject: PFObject = PFObject(className: "Message16")
        
        //set the text key to the text of the messsageTextField
        newMessageObject["Text"] = self.messageTextField.text
        
        
        //save the PFOject
        newMessageObject.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                self.retrieveMessages()
                // The object has been saved.
            } else {
                // There was a problem, check error.description
            }
            
            dispatch_async(dispatch_get_main_queue()){
                //enable the text field and send button
                self.sendButton.enabled = true
                self.messageTextField.enabled = true
                self.messageTextField.text = ""
                self.messageTableView.reloadData()
                
            }
            
            
        }
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        self.view.layoutIfNeeded()
        
        UIView.animateWithDuration(0.5, animations: {
            self.heightConstraint.constant = 350
            self.view.layoutIfNeeded()
            
            }, completion: nil)
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        self.view.layoutIfNeeded()
        
        UIView.animateWithDuration(0.5, animations: {
            self.heightConstraint.constant = 60
            self.view.layoutIfNeeded()
            
            }, completion: nil)
    }
    
    
    func tableViewTapped(){
        //force text field to end editing
        self.messageTextField.endEditing(true)
    }
    
    func retrieveMessages(){
        //create a new PFQuery
        
        var query:PFQuery = PFQuery(className: "Message16")
        //call find objects in backgroud
        // query.findObjectsInBackgroundWithBlock { (objects:[AnyObject], error:NSError!) -> Void in
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            
            if error == nil {
                //clear message array
                self.messagesArray = [String]()
                
                //loop through objects array
                for messageObject in objects as! [PFObject] {
                    //retrieve the text column value of each PFobject
                    let messageText:String? = (messageObject as PFObject)["Text"] as? String
                    //assign it into our messagesArray
                    if messageText != nil {
                        self.messagesArray.append(messageText!)
                    }
                    
                }
                
                dispatch_async(dispatch_get_main_queue()){
                    //reload the tableview
                    self.messageTableView.reloadData()
                    
                }
                
                
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //create table cell
        let cell = self.messageTableView.dequeueReusableCellWithIdentifier("MessageCell") as! UITableViewCell
        //customize cell
        cell.textLabel?.text = self.messagesArray[indexPath.row]
        //return cell
        return cell
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messagesArray.count
    }
    
    
}