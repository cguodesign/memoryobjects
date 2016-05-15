//
//  ListHeaderViewController.swift
//  MOswift
//
//  Created by Chong Guo on 4/1/16.
//  Copyright © 2016 Chong Guo. All rights reserved.
//

import UIKit
import Hakuba
import Firebase

enum SectionIndex: Int, SectionIndexType {
    case Top
    case Center
    
    static let count = 2
}



class ListHeaderViewController: UIViewController {
    
    //all entries
    var objid = ""
    var entries = [dataEntry]()
    var etitles = [String]()
    var etitles_back = [String]()
    var passedString = NSString()
    var entriesNumber = Int()

    @IBOutlet weak var tableView: UITableView!
    @IBAction func AddEntry(sender: AnyObject) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vca = storyboard.instantiateViewControllerWithIdentifier("AddEntryViewController") as! AddEntryViewController
        self.navigationController?.pushViewController(vca, animated: true)
    }
    
    
    private lazy var hakuba: Hakuba = Hakuba(tableView: self.tableView)
    
    override func viewWillAppear(animated: Bool) {
        hakuba.deselectAllCells(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hakuba.registerCellByNib(CustomCell)
        
        
        // Testing Data Retriver
        let fireURL = "https://moswift.firebaseio.com/objects/" + objid + "/history"
        let fireRef = Firebase(url: fireURL);
        fireRef.observeEventType(.Value, withBlock: {snapshot in
            //print(snapshot.value)
            
            self.entries = []
            self.etitles = []
            
            if let snapshots = snapshot.children.allObjects as? [FDataSnapshot]{
                self.entriesNumber = Int(snapshot.childrenCount)
                for snap in snapshots {
                    if let postDictionary = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        let singleEntry = dataEntry(key: key, dictionary: postDictionary)
                        
                        print(singleEntry.entryTime + "by" + singleEntry.entryUser)
                        // Items are returned chronologically, but it's more fun with the newest jokes first.
                        self.entries.insert(singleEntry, atIndex: 0)
                        let dateFormatter = NSDateFormatter()
                        dateFormatter.dateFormat = "ddMMyyyyHHmmss"
                        let dateFromString = dateFormatter.dateFromString(singleEntry.entryTime);
                        var typeFromString = ""
                        if (singleEntry.entryType == 1){
                            typeFromString = "Text, "
                        } else if (singleEntry.entryType == 2){
                            typeFromString = "Image, "
                        } else if (singleEntry.entryType == 3){
                            typeFromString = "Voice, "
                        }
                        let insertedTitle = typeFromString + self.timeAgoSinceDate(dateFromString!, numericDates: true)
                        self.etitles.insert(insertedTitle, atIndex:0)
                        self.etitles_back.insert(singleEntry.entryTime, atIndex: 0)
                        self.insertNewLists()
                    }
                }
            }
        })
        
        hakuba
            .reset(SectionIndex)
            .bump()
    }
    
    func insertNewLists(){
        let centerSection = hakuba[SectionIndex.Top]
        
        print ("etitles: " + String(self.etitles))
        // Center section
        if (self.entries.count == self.entriesNumber){
            let centerCellmodels = etitles.map { [weak self] title -> CellModel in
                let data = CustomCellModel(title: title) { _ in
                    print("Did select cell with title = \(title)")
                    let indexTitile = self!.etitles.indexOf(title)
                    print(indexTitile)
                    self?.passedString = (self?.etitles_back[indexTitile!])!
                    self?.pushChildViewController()
                }
                data.dynamicHeightEnabled = true
                return data
            }
            
            
            centerSection
                .append(centerCellmodels)
                .bump(.Left)
        }
    }
        
    /*
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let DestViewController: ChildViewController = segue.destinationViewController as! ChildViewController
        DestViewController.eventNumber = self.passedString as String
    }*/
    
    func pushChildViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("ChildViewController") as! ChildViewController
        vc.eventNumber = self.passedString as String
        //let singleEntry = self.entries(key: self.passedString, dictionary: Dictionary<String, AnyObject>)
        for singleEntry in self.entries{
            if (singleEntry.entryTime == self.passedString){
                vc.eventType = singleEntry.entryType
                vc.eventLink = singleEntry.entryLink
            }
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func timeAgoSinceDate(date:NSDate, numericDates:Bool) -> String {
        let calendar = NSCalendar.currentCalendar()
        let now = NSDate()
        let earliest = now.earlierDate(date)
        let latest = (earliest == now) ? date : now
        let components:NSDateComponents = calendar.components([NSCalendarUnit.Minute , NSCalendarUnit.Hour , NSCalendarUnit.Day , NSCalendarUnit.WeekOfYear , NSCalendarUnit.Month , NSCalendarUnit.Year , NSCalendarUnit.Second], fromDate: earliest, toDate: latest, options: NSCalendarOptions())
        
        if (components.year >= 2) {
            return "\(components.year) years ago"
        } else if (components.year >= 1){
            if (numericDates){
                return "1 year ago"
            } else {
                return "Last year"
            }
        } else if (components.month >= 2) {
            return "\(components.month) months ago"
        } else if (components.month >= 1){
            if (numericDates){
                return "1 month ago"
            } else {
                return "Last month"
            }
        } else if (components.weekOfYear >= 2) {
            return "\(components.weekOfYear) weeks ago"
        } else if (components.weekOfYear >= 1){
            if (numericDates){
                return "1 week ago"
            } else {
                return "Last week"
            }
        } else if (components.day >= 2) {
            return "\(components.day) days ago"
        } else if (components.day >= 1){
            if (numericDates){
                return "1 day ago"
            } else {
                return "Yesterday"
            }
        } else if (components.hour >= 2) {
            return "\(components.hour) hours ago"
        } else if (components.hour >= 1){
            if (numericDates){
                return "1 hour ago"
            } else {
                return "An hour ago"
            }
        } else if (components.minute >= 2) {
            return "\(components.minute) minutes ago"
        } else if (components.minute >= 1){
            if (numericDates){
                return "1 minute ago"
            } else {
                return "A minute ago"
            }
        } else if (components.second >= 3) {
            return "\(components.second) seconds ago"
        } else {
            return "Just now"
        }
        
    }
}
