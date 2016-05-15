//
//  VoiceInputViewController.swift
//  MOswift
//
//  Created by Chong Guo on 4/12/16.
//  Copyright © 2016 Chong Guo. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import Firebase

class VoiceInputViewController: UIViewController {
    
    var audioRecorder:AVAudioRecorder!
    var tapCounter = 1;
    var soundLink = ""
    
    @IBOutlet weak var buttonHolder: UIImageView!
    @IBOutlet weak var RecordInstruction: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var addButton: UIImageView!
    
    let recordSettings = [AVSampleRateKey : NSNumber(float: Float(44100.0)),
        AVFormatIDKey : NSNumber(int: Int32(kAudioFormatMPEG4AAC)),
        AVNumberOfChannelsKey : NSNumber(int: 1),
        AVEncoderAudioQualityKey : NSNumber(int: Int32(AVAudioQuality.Medium.rawValue))]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.whiteColor()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(VoiceInputViewController.tappedMe))
        buttonHolder.addGestureRecognizer(tap)
        buttonHolder.userInteractionEnabled = true
        
        let add = UITapGestureRecognizer(target: self, action: #selector(VoiceInputViewController.addToFirebase))
        addButton.addGestureRecognizer(add)
        addButton.userInteractionEnabled = true
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try audioRecorder = AVAudioRecorder(URL: self.directoryURL()!,
                                                settings: recordSettings)
            audioRecorder.prepareToRecord()
        } catch {
        }
    }
    
    func tappedMe()
    {
        tapCounter += 1
        if tapCounter%2 == 0 { // Record
            if !audioRecorder.recording {
                buttonHolder.image = UIImage(named: "StopRecbutton")
                RecordInstruction.text = "Recording"
                RecordInstruction.textColor = UIColor.redColor()
                let audioSession = AVAudioSession.sharedInstance()
                do {
                    try audioSession.setActive(true)
                    audioRecorder.record()
                    print("record!")
                } catch {
                }
            }
        }else{ // Stoped
            buttonHolder.image = UIImage(named: "Recordbutton")
            RecordInstruction.text = "Recorded, ready to upload"
            RecordInstruction.textColor = UIColor.blackColor()
            audioRecorder.stop()
            let audioSession = AVAudioSession.sharedInstance()
            
            do {
                try audioSession.setActive(false)
                print("stop!!")
            } catch {
            }
        }
        
    }
    
    func directoryURL() -> NSURL? {
        let currentDateTime = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "ddMMyyyyHHmmss"
        let recordingName = formatter.stringFromDate(currentDateTime)+".caf"
        print(recordingName)
        
        let fileManager = NSFileManager.defaultManager()
        let urls = fileManager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        let documentDirectory = urls[0] as NSURL
        let soundURL = documentDirectory.URLByAppendingPathComponent(recordingName)
        print(soundURL)
        soundLink = soundURL.path!
        return soundURL
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
        
        let event = ["data_link": soundLink, "data_type": 3, "primary_user": globalUserName, "time":clickedDateandTime]
        let usersRef = refOBJ.childByAppendingPath(clickedDateandTime)
        
        /*
        let updatedURLOBJLastEdit = "https://moswift.firebaseio.com/objects/" + readbleid
        let refOBJLast = Firebase(url: updatedURLOBJLastEdit)
        let lastEdit = ["last_edit":clickedDateandTime]
        */
        
        //let singleEvent = [clickedDateandTime: event,]
        usersRef.setValue(event)
        //refOBJLast.setValue(lastEdit)
        
        infoLabel.text = "uploaded"
    }
}