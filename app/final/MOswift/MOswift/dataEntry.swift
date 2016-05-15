//
//  dataEntry.swift
//  MOswift
//
//  Created by Chong Guo on 4/2/16.
//  Copyright © 2016 Chong Guo. All rights reserved.
//

import Foundation
import Firebase

class dataEntry {
    private var _entryRef: Firebase!
    
    private var _entryType:Int!
    private var _entryTime:String!
    private var _entryLink:String!
    private var _entryUser:String!
    
    var entryType: Int{
        return _entryType
    }
    
    var entryTime: String{
        return _entryTime
    }
    
    var entryLink: String{
        return _entryLink
    }
    
    var entryUser: String{
        return _entryUser
    }
    
    //Initialize the new dataEntry
    init(key:String, dictionary: Dictionary<String, AnyObject>){
        self._entryTime = key
        
        if let eType = dictionary["data_type"] as? Int{
            self._entryType = eType
        }
        
        if let eUser = dictionary["primary_user"] as? String{
            self._entryUser = eUser
        }
        
        if let eLink = dictionary["data_link"] as? String{
            self._entryLink = eLink
        }
        
        self._entryRef = DataService.dataService.HIS_REF.childByAppendingPath(self._entryTime)
    }
}