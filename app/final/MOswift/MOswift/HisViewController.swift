//
//  HisViewController.swift
//  MOswift
//
//  Created by Chong Guo on 4/1/16.
//  Copyright © 2016 Chong Guo. All rights reserved.
//

import UIKit
import Hakuba
import Firebase

class HisViewController: UIViewController {
    
    var atitles = [String]()
    var cms = [CustomCellModel]()
    //var passedString = NSString()
    var aentriesNumber = Int()
    
    @IBOutlet weak var tableView: UITableView!
    private lazy var hakuba: Hakuba = Hakuba(tableView: self.tableView)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hakuba.registerCellByNib(CustomCell)
        
        print("hello")
        
        let topSection = Section()

        hakuba
            .reset([topSection])
            .bump()
        /*
        topSection
            .reset(cms)
            .bump()
        */
        DataService.dataService.ALLOBJ_REF.queryOrderedByKey().observeEventType(.ChildAdded, withBlock: {snapshot in
            print(snapshot.key)
            self.atitles.append(snapshot.key)
            
            let cm = CustomCellModel(title: snapshot.key) { [weak self] _ in
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewControllerWithIdentifier("ListHeaderViewController") as! ListHeaderViewController
                vc.objid = snapshot.key
                self?.navigationController?.pushViewController(vc, animated: true)
            }
            
            topSection
                .append(cm)
                .bump(.Fade)
            //self.cms.append(cm)
        })
    
        /*
        let cm1 = CustomCellModel(title: "Piano") { [weak self] _ in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("ListHeaderViewController") as! ListHeaderViewController
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        
        
        let cm2 = CustomCellModel(title: "Starbuck City Collection: Atlanta") { [weak self] _ in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("DetailedList") as! DetailedListViewController
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        */
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        hakuba.deselectAllCells(animated: true)
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
