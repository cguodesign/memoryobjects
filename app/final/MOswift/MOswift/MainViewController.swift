//
//  MainViewController.swift
//  MOswift
//
//  Created by Chong Guo on 3/31/16.
//  Copyright © 2016 Chong Guo. All rights reserved.
//

import Foundation
import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var scanButton: UIButton!
    @IBOutlet weak var homepageNameTag: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let welcomeString = "Welcome, " + globalUserName
        homepageNameTag.text = welcomeString;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

