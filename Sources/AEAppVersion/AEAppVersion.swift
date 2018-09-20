/**
 *  https://github.com/tadija/AEAppVersion
 *  Copyright (c) Marko Tadić 2016-2018
 *  Licensed under the MIT license. See LICENSE file.
 */

import Foundation

/**
    Subclass of `Comparator` with properties for `version` and `build` from main bundle info dictionary.
    Call `launch` in AppDelegate's `didFinishLaunchingWithOptions:` then check its `state` property when needed.
*/
open class AEAppVersion: Comparator {
    
    // MARK: Properties
    
    /// Shared instance
    public static let shared = AEAppVersion()
    
    /// Version from Main Bundle Info dictionary
    public static let version = Bundle.main.version ?? "0.0.0"
    
    /// Build from Main Bundle Info dictionary
    public static let build = Bundle.main.build ?? "0"
    
    /// `version` and `build` concatenated like this: "1.0.0 (1)"
    public static let versionAndBuild = "\(version) (\(build))"
    
    /// Key for saving information about previous version to user defaults
    public static let savedVersionKey = "AEAppVersion.PreviousVersionAndBuild"
    
    // MARK: API
    
    /**
        Helper method for initializing `shared` singleton object.
     
        This should be called in AppDelegate's `didFinishLaunchingWithOptions:`.
     
        It will check if saved version already exists in user defaults and set its `state` property accordingly.
        After that it will save current version as saved version under `savedVersionKey` in user defaults.
    */
    open class func launch() { let _ = AEAppVersion.shared }
    
    // MARK: Init
    
    private convenience init() {
        let defaults = UserDefaults.standard
        
        let old = defaults.string(forKey: AEAppVersion.savedVersionKey)
        let current = AEAppVersion.versionAndBuild
        
        self.init(old: old, new: current)
        
        defaults.set(current, forKey: AEAppVersion.savedVersionKey)
        defaults.synchronize()
    }
    
}

// MARK: - Bundle helper extension

extension Bundle {
    
    var version: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    
    var build: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
    
}
