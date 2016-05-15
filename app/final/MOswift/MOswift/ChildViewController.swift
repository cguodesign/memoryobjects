//
//  ChildViewController.swift
//  MOswift
//
//  Created by Chong Guo on 4/1/16.
//  Copyright © 2016 Chong Guo. All rights reserved.
//

import UIKit
import AVFoundation

class ChildViewController: UIViewController{
    var eventNumber: String?
    var eventType: Int?
    var eventLink: String?
    var objectNumber: String?
    
    var detailedAudioRecorder: AVAudioRecorder!
    var detailedAudioPlayer: AVAudioPlayer!

    @IBOutlet weak var detailedImageView: UIImageView!
    @IBOutlet weak var eventString: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print (eventNumber)
        eventString.text = eventNumber
        // Do any additional setup after loading the view.
        if (eventType == 1){
            print("DataType: Text")
            eventString.text = eventLink
            detailedImageView.image = nil
        }else if (eventType == 2){
            eventString.text = ""
            print("DataType: Image")
            let imageData = NSData(base64EncodedString: eventLink!, options: NSDataBase64DecodingOptions.IgnoreUnknownCharacters)
            /*
            print(eventLink)
            print("to")
            print(imageData)
            */
            let presentImage = UIImage(data: imageData!)
            detailedImageView.image = presentImage
        }else if (eventType == 3){
            eventString.text = ""
            detailedImageView.image = nil
            print("DataType: Voice")
            let voiceURL = NSURL(fileURLWithPath: eventLink!)
            var voiceError:NSError?
            let folderExists = voiceURL.checkResourceIsReachableAndReturnError(&voiceError)
            print("error is :" + String(voiceError))
            if (folderExists == true){
                
                    do {
                        try detailedAudioPlayer = AVAudioPlayer(contentsOfURL: voiceURL)
                        detailedAudioPlayer.play()
                        print("play!!")
                    } catch {
                    }
                
            }else{
                print ("something wrong with URL")
            }
        }else{
            print("Error: Wrong Firebase Data Type")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
