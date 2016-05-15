//
//  AddEntryViewController.swift
//  MOswift
//
//  Created by Chong Guo on 4/12/16.
//  Copyright © 2016 Chong Guo. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import PagingMenuController

var readbleid = "0002"

class AddEntryViewController: UIViewController, PagingMenuControllerDelegate{
    /*
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = UIColor.whiteColor()
        
        let viewController = TextInputViewController()
        viewController.title = "Text"
        
        let viewController2 = VoiceInputViewController()
        viewController2.title = "Voice"
        
        let viewController3 = ImageInputViewController()
        viewController3.title = "Gallery"
        
        let viewController4 = CameraInputViewController()
        viewController4.title = "Camera"
        
        
        let viewControllers = [viewController, viewController2, viewController3, viewController4]
        
        let options = PagingMenuOptions()
        options.menuItemMargin = 5
        options.menuHeight = 60
        options.menuDisplayMode = .SegmentedControl
        let pagingMenuController = PagingMenuController(viewControllers: viewControllers, options: options)
        pagingMenuController.view.frame.origin.y += 64
        pagingMenuController.view.frame.size.height -= 64
        
        addChildViewController(pagingMenuController)
        view.addSubview(pagingMenuController.view)
        pagingMenuController.didMoveToParentViewController(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let textInputViewController = self.storyboard?.instantiateViewControllerWithIdentifier("TextInputViewController") as! TextInputViewController
        textInputViewController.title = "Text"
        let voiceInputViewController = self.storyboard?.instantiateViewControllerWithIdentifier("VoiceInputViewController") as! VoiceInputViewController
        voiceInputViewController.title = "Voice"
        let imageInputViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ImageInputViewController") as! ImageInputViewController
        imageInputViewController.title = "Gallery"
        let cameraInputViewController = self.storyboard?.instantiateViewControllerWithIdentifier("CameraInputViewController") as! CameraInputViewController
        cameraInputViewController.title = "Camera"
        
        let viewControllers = [textInputViewController, voiceInputViewController, imageInputViewController, cameraInputViewController]
        
        let options = PagingMenuOptions()
        options.menuItemMargin = 5
        options.menuHeight = 50
        options.backgroundColor = UIColor(red: 34.0/255, green: 186.0/255, blue: 181.0/255, alpha: 1.0)
        options.selectedBackgroundColor = UIColor(red: 34.0/255, green: 165.0/255, blue: 181.0/255, alpha: 1.0)
        options.textColor = UIColor.whiteColor()
        options.selectedTextColor = UIColor.whiteColor()
        options.menuDisplayMode = .SegmentedControl
        options.menuItemMode = .Underline(height: 2, color: UIColor.whiteColor(), horizontalPadding: 0, verticalPadding: 0)
        
        let pagingMenuController = self.childViewControllers.first as! PagingMenuController
        pagingMenuController.delegate = self
        pagingMenuController.setup(viewControllers: viewControllers, options: options)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - PagingMenuControllerDelegate
    
    func willMoveToPageMenuController(menuController: UIViewController, previousMenuController: UIViewController) {
        
    }
    
    func didMoveToPageMenuController(menuController: UIViewController, previousMenuController: UIViewController) {
        
    }
}
