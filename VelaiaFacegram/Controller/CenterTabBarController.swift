//
//  CenterTabBarController.swift
//  VelaiaFacegram
//
//  Created by Daniel N Lang on 24.04.16.
//  Copyright © 2016 Daniel N Lang. All rights reserved.
//

import UIKit

class CenterTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = UIColor.whiteColor()
        tabBar.barTintColor = UIColor(white: 0.25, alpha: 1)
        tabBar.translucent = false
        
        let centerButton = UIButton(type: .Custom)
        let buttonImage = UIImage(named: "camera")
        let numTabs = self.viewControllers!.count
        
        if buttonImage != nil {
            let screenWidth = UIScreen.mainScreen().bounds.size.width
            centerButton.frame = CGRectMake(0, 0, screenWidth / CGFloat(numTabs), self.tabBar.frame.size.height)
            centerButton.setImage(buttonImage, forState: .Normal)
            centerButton.tintColor = UIColor.whiteColor()
            centerButton.backgroundColor = UIColor(red: 18/255.0, green: 86/255.0, blue: 136/255.0, alpha: 1.0)
            
            centerButton.center = self.tabBar.center
            
            centerButton.addTarget(self, action: #selector(CenterTabBarController.showCamera(_:)), forControlEvents: .TouchUpInside)
            self.view.addSubview(centerButton)
        }
    }
    
    func showCamera(sender: UIButton!) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let cameraPicker = mainStoryboard.instantiateViewControllerWithIdentifier("CameraPopup")
        self.presentViewController(cameraPicker, animated: true, completion: nil)
    }
}
