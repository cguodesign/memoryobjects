//
//  DataService.swift
//  MOswift
//
//  Created by Chong Guo on 4/2/16.
//  Copyright © 2016 Chong Guo. All rights reserved.
//

import Foundation
import Firebase

let BASE_URL = "https://moswift.firebaseio.com/"

class DataService {
    static let dataService = DataService()
    
    private var _BASE_REF = Firebase(url: "\(BASE_URL)")
    private var _HIS_REF = Firebase(url: "\(BASE_URL)/objects/0001/history")
    private var _OBJ_REF = Firebase(url: "\(BASE_URL)/objects/0001")
    private var _ALLOBJ_REF = Firebase(url: "\(BASE_URL)/objects")
    
    var BASE_REF: Firebase{
        return _BASE_REF
    }
    
    var HIS_REF: Firebase{
        return _HIS_REF
    }
    
    var OBJ_REF: Firebase{
        return _OBJ_REF
    }
    
    var ALLOBJ_REF: Firebase{
        return _ALLOBJ_REF
    }
}