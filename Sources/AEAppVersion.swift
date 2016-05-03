//
// AEAppVersion.swift
//
// Copyright (c) 2016 Marko Tadić <tadija@me.com> http://tadija.net
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//

import Foundation

/**
    Subclass of `AEVersionComparator` with static properties for `version` and `build` from main bundle info dictionary.
    When initialized it checks if previous version exists in user defaults and set version state accordingly, 
    after which it saves current version to user defaults dictionary.
*/
public class AEAppVersion: AEVersionComparator {

    // MARK: Singleton
    
    /// Shared instance
    public static let sharedInstance = AEAppVersion()
    
    /**
        Helper method for initializing `sharedInstance` singleton object.
     
        This should be called in AppDelegate's `didFinishLaunchingWithOptions:`.
    */
    public class func launch() { AEAppVersion.sharedInstance }
    
    // MARK: - Static Properties
    
    /// Version from Main Bundle Info dictionary
    public static let version = bundle.objectForInfoDictionaryKey("CFBundleShortVersionString") as! String
    
    /// Build from Main Bundle Info dictionary
    public static let build = bundle.objectForInfoDictionaryKey(kCFBundleVersionKey as String) as! String
    
    /// Main bundle helper
    private static let bundle = NSBundle.mainBundle()
    
    /// `version` and `build` concatenated like this: "1.0.0 (1)"
    public static let versionAndBuild = "\(version) (\(build))"
    
    /// Key for saving information about previous version to user defaults
    public static let savedVersionKey = "AEAppVersion.PreviousVersionAndBuild"
    
    // MARK: Init
    
    /**
        Convenience initializer.

        Checks if saved version already exists in user defaults and set state accordingly,
        after which it saves current version as saved version under `savedVersionKey` in user defaults.

        - returns: An initialized version comparator object.
    */
    public convenience init() {
        let defaults = NSUserDefaults.standardUserDefaults()
        
        let old = defaults.stringForKey(AEAppVersion.savedVersionKey)
        let current = AEAppVersion.versionAndBuild
        
        self.init(old: old, new: current)
        
        defaults.setObject(current, forKey: AEAppVersion.savedVersionKey)
        defaults.synchronize()
    }
    
}

// MARK: - AEVersionComparator

/**
    Base class for comparing given version strings via built in compare with `NSStringCompareOptions.NumericSearch`.
    It holds `AEVersionState` inside `state` property.
*/
public class AEVersionComparator {
    
    // MARK: Properties
    
    /// Version comparation state
    public let state: AEVersionState
    
    // MARK: Init
    
    /**
        Designated initializer.
    
        Initializes and returns a newly allocated version comparator object with `state` property configured
        by calling helper method `stateForComparingVersions` with given version strings.
        
        - parameter old: Old (previous) version string for comparation
        - parameter new: New (current) version string for comparation
    
        - returns: An initialized version comparator object.
    */
    public init(old: String?, new: String) {
        if let oldVersion = old {
            state = AEVersionComparator.stateForComparingVersions(old: oldVersion, new: new)
        } else {
            state = .New
        }
    }
    
    // MARK: Helpers
    
    /**
        Compares given version strings with `NSStringCompareOptions.NumericSearch`.
    
        - parameter old: Old (previous) version string for comparation
        - parameter new: New (current) version string for comparation
    
        - returns: Proper `State` after comparing given versions.
    */
    public class func stateForComparingVersions(old old: String, new: String) -> AEVersionState {
        let comparison = old.compare(new, options: .NumericSearch)
        switch comparison {
        case .OrderedSame:
            return .Equal
        case .OrderedAscending:
            return .Update(previousVersion: old)
        case .OrderedDescending:
            return .Rollback(previousVersion: old)
        }
    }
    
}

// MARK: - AEVersionState

/**
    App version state

    - New: Clean install
    - Equal: Version not changed
    - Update: Update from given version
    - Rollback: Rollback from given version
*/
public enum AEVersionState {
    /// Clean install
    case New
    /// Version not changed
    case Equal
    /// Update from given version
    case Update(previousVersion: String)
    /// Rollback from given version
    case Rollback(previousVersion: String)
}

/// Conformance to `Equatable` protocol
extension AEVersionState: Equatable {}

/**
    Implementation of the `Equatable` protocol so that `AEVersionState` 
    can be compared for value equality using operators == and !=.
*/
public func == (lhs: AEVersionState, rhs: AEVersionState) -> Bool {
    switch (lhs, rhs) {
    case (.New, .New):
        return true
    case (.Equal, .Equal):
        return true
    case (let .Update(previous1), let .Update(previous2)):
        return previous1 == previous2
    case (let .Rollback(previous1), let .Rollback(previous2)):
        return previous1 == previous2
    default:
        return false
    }
}
