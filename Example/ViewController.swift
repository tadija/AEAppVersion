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
        stateLabel.text = versionStatedDescription
    }
    
    var versionStatedDescription: String {
        switch AEAppVersionManager.sharedInstance.state {
        case .New:
            return "Clean Install"
        case .Equal:
            return "Not Changed"
        case .Update(let previousVersion):
            return "Update from: \(previousVersion)"
        case .Rollback(let previousVersion):
            return "Rollback from: \(previousVersion)"
        }
    }

}
