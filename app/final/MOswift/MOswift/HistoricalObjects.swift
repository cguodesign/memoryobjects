//
//  HistoricalObjects.swift
//  MOswift
//
//  Created by Chong Guo on 4/1/16.
//  Copyright © 2016 Chong Guo. All rights reserved.
//

import Foundation
import UIKit

class HistoricalObjects {
    // MARK: Properties
    
    var name: String
    var owner: String
    var lastActivity: Int
    
    // MARK: Initialization
    
    init?(name: String, photo: String, rating: Int) {
        // Initialize stored properties.
        self.name = name
        self.owner = photo
        self.lastActivity = rating
        
        // Initialization should fail if there is no name or if the rating is negative.
        if name.isEmpty || rating < 0 {
            return nil
        }
    }
    
}