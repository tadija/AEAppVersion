//
//  ViewController.swift
//  iOS Example
//
//  Created by Marko Tadic on 1/31/16.
//  Copyright © 2016 AE. All rights reserved.
//

import UIKit
import AEAppVersionManager

class ViewController: UIViewController {
    
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    func configureUI() {
        versionLabel.text = AEAppVersionManager.versionAndBuild

        var stateDescription: String

        switch AEAppVersionManager.sharedInstance.state {
        case .New:
            stateDescription = "Clean Install"
        case .Equal:
            stateDescription = "Not Changed"
        case .Update(let previousVersion):
            stateDescription = "Update from: \(previousVersion)"
        case .Rollback(let previousVersion):
            stateDescription = "Rollback from: \(previousVersion)"
        }
        
        stateLabel.text = stateDescription
    }

}

