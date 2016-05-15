//
//  ImageInputViewController.swift
//  MOswift
//
//  Created by Chong Guo on 4/12/16.
//  Copyright © 2016 Chong Guo. All rights reserved.
//

import Foundation
import UIKit
import ALCameraViewController
import Firebase

class ImageInputViewController: UIViewController {
    
    var croppingEnabled: Bool = false
    var libraryEnabled: Bool = true
    
    @IBOutlet weak var imageHolder: UIImageView!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var addButton: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.whiteColor()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ImageInputViewController.tappedImage))
        imageHolder.addGestureRecognizer(tap)
        imageHolder.userInteractionEnabled = true
        
        let add = UITapGestureRecognizer(target: self, action: #selector(ImageInputViewController.addToFirebase))
        addButton.addGestureRecognizer(add)
        addButton.userInteractionEnabled = true
    }
    
    func tappedImage()
    {
        let libraryViewController = CameraViewController.imagePickerViewController(croppingEnabled) { image, asset in
            self.imageHolder.image = image
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        
        presentViewController(libraryViewController, animated: true, completion: nil)
    }
    
    func addToFirebase() {
        let currentDateTime = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "ddMMyyyyHHmmss"
        let clickedDateandTime = formatter.stringFromDate(currentDateTime)
        
        let todoimage : UIImage = self.imageHolder.image!
        let imageData = UIImageJPEGRepresentation(todoimage, 0.8)
        let base64String = imageData!.base64EncodedStringWithOptions(.Encoding64CharacterLineLength)
        
        let updatedURLOBJ = "https://moswift.firebaseio.com/objects/" + readbleid + "/history"
        //let updatedURLLOC = "https://moswift.firebaseio.com/locations/" + readbleid + "/history"
        let refOBJ = Firebase(url: updatedURLOBJ)
        //let refLOC = Firebase(url: updatedURLLOC)
        
        let event = ["data_link": base64String, "data_type": 2, "primary_user": globalUserName, "time":clickedDateandTime]
        let usersRef = refOBJ.childByAppendingPath(clickedDateandTime)
        usersRef.setValue(event)
        
        infoLabel.text = "uploaded"
    }
}