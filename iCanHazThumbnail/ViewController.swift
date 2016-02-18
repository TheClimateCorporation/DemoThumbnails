//
//  ViewController.swift
//  iCanHazThumbnail
//
//  Created by Aditya Rao on 2/16/16.
//  Copyright © 2016 Aditya Rao. All rights reserved.
//

import UIKit
import LoginWithClimate

class ViewController : UINavigationController, LoginWithClimateDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Loaded the view controller ")
        // Do any additional setup after loading the view, typically from a nib.
        let loginViewController = LoginWithClimateButton(clientId: "CLIENT ID GOES HERE", clientSecret: "CLIENT SECRET GOES HERE")
        loginViewController.delegate = self
      
        if let image = UIImage(named: "2.jpg") {
            view.backgroundColor = UIColor(patternImage: image)
        }
        
        view.addSubview(loginViewController.view)
        
        loginViewController.view.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[view]-|",
            options: NSLayoutFormatOptions.AlignAllCenterY,
            metrics: nil,
            views: ["view":loginViewController.view]))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[view]-30-|",
            options: NSLayoutFormatOptions(rawValue: 0),
            metrics: nil,
            views: ["view":loginViewController.view]))
        self.addChildViewController(loginViewController)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func didLoginWithClimate(session: Session) {
        // Navigate to the TableView
        let tableViewController = self.storyboard?.instantiateViewControllerWithIdentifier("TableViewController") as! TableViewController
        tableViewController.fieldStore = FieldStore(session: session)
        self.presentViewController(tableViewController, animated: true, completion: nil)
        //self.pushViewController(tableViewController, animated: true)
    }
    
    func didFailLoginWithClimateWithError(error: ErrorType) {
        
    }

}

