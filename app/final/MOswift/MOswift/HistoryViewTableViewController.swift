//
//  HistoryViewTableViewController.swift
//  MOswift
//
//  Created by Chong Guo on 4/1/16.
//  Copyright © 2016 Chong Guo. All rights reserved.
//

import UIKit
import Firebase


class HistoryViewTableViewController: UITableViewController {
    
    var objects = [HistoricalObjects]()
    var ref = Firebase(url:"https://memoryobjects.firebaseio.com/objects")
    var snaplength = 0
    
    // MARK: Properties
    
    //var currentNames: [String] = [String]()
    //var currentOwners: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref.observeEventType(.Value, withBlock: {(snapshot: FDataSnapshot!)  in
            print(snapshot.value)
            //self.currentNames.append(snapshot.value.objectForKey("name") as! String)
            //self.currentOwners.append(snapshot.value.objectForKey("owner") as! String)
            
            //print(self.currentNames)
            //print(self.currentOwners)
            
            self.snaplength = Int(snapshot.childrenCount)
            print(self.snaplength)
            self.fakeData()
            }, withCancelBlock: { error in
                print(error.description)
        })
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    func fakeData(){
        let meal1 = HistoricalObjects(name: "Piano", photo: "Chester", rating: 4)!
        let meal2 = HistoricalObjects(name: "Chicken and Potatoes", photo: "Chester", rating: 12)!
        let meal3 = HistoricalObjects(name: "Pasta with Meatballs", photo: "Chester", rating: 15)!
        
        objects += [meal1, meal2, meal3]
        print(objects)
    }
    

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print(self.objects.count)
        return self.objects.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "HistoryEntryTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! HistoryEntryTableViewCell
        
        // Fetches the appropriate meal for the data source layout.
        let meal = objects[indexPath.row]
        
        cell.HistoryEntryNameLabel.text = meal.name
        cell.HistoryEntryDesLabel.text = meal.owner
        cell.HistoryEntryTimeLabel.text = String(meal.lastActivity)
        
        return cell
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
