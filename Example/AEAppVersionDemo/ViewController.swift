/**
 *  https://github.com/tadija/AEAppVersion
 *  Copyright (c) Marko Tadić 2016-2019
 *  Licensed under the MIT license. See LICENSE file.
 */

import UIKit
import AEAppVersion

class ViewController: UIViewController {
    
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    func configureUI() {
        versionLabel.text = AEAppVersion.versionAndBuild
        stateLabel.text = versionStatedDescription
    }
    
    var versionStatedDescription: String {
        switch AEAppVersion.shared.state {
        case .new:
            return "Clean Install"
        case .equal:
            return "Not Changed"
        case .update(let previousVersion):
            return "Update from: \(previousVersion)"
        case .rollback(let previousVersion):
            return "Rollback from: \(previousVersion)"
        }
    }

}
