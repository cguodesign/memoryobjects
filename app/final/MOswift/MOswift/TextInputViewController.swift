//
//  TextInputViewController.swift
//  MOswift
//
//  Created by Chong Guo on 4/12/16.
//  Copyright © 2016 Chong Guo. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class TextInputViewController: UIViewController {
    
    @IBOutlet weak var TextBox: UITextView!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var addButton: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.whiteColor()
        self.TextBox.layer.borderWidth = 1
        self.TextBox.layer.borderColor = UIColor.lightGrayColor().CGColor
        
        let add = UITapGestureRecognizer(target: self, action: #selector(TextInputViewController.addToFirebase))
        addButton.addGestureRecognizer(add)
        addButton.userInteractionEnabled = true
    }
    
    func addToFirebase() {
        let currentDateTime = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "ddMMyyyyHHmmss"
        
        let clickedDateandTime = formatter.stringFromDate(currentDateTime)
        
        let updatedURLOBJ = "https://moswift.firebaseio.com/objects/" + readbleid + "/history"
        //let updatedURLLOC = "https://moswift.firebaseio.com/locations/" + readbleid + "/history"
        let refOBJ = Firebase(url: updatedURLOBJ)
        //let refLOC = Firebase(url: updatedURLLOC)
        
        let event = ["data_link": TextBox.text, "data_type": 1, "primary_user": globalUserName, "time":clickedDateandTime]
        let usersRef = refOBJ.childByAppendingPath(clickedDateandTime)
        usersRef.setValue(event)
        
        infoLabel.text = "uploaded"
    }
}