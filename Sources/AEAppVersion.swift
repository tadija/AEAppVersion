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
    Subclass of `AEVersionComparator` with properties for `version` and `build` from main bundle info dictionary.
    Call `launch` in AppDelegate's `didFinishLaunchingWithOptions:` then check its `state` property when needed.
*/
open class AEAppVersion: AEVersionComparator {
    
    // MARK: Properties
    
    /// Shared instance
    open static let shared = AEAppVersion()
    
    /// Version from Main Bundle Info dictionary
    open static let version = Bundle.main.version ?? "0.0.0"
    
    /// Build from Main Bundle Info dictionary
    open static let build = Bundle.main.build ?? "0"
    
    /// `version` and `build` concatenated like this: "1.0.0 (1)"
    open static let versionAndBuild = "\(version) (\(build))"
    
    /// Key for saving information about previous version to user defaults
    open static let savedVersionKey = "AEAppVersion.PreviousVersionAndBuild"
    
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

// MARK: - AEVersionComparator

/**
    Base class for comparing given version strings via `compare` with `NSString.CompareOptions.numeric` option.
    It resolves version comparation state (`AEVersionState`) inside its `state` property.
*/
open class AEVersionComparator {
    
    // MARK: Properties
    
    /// Version comparation state
    open let state: AEVersionState
    
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
            state = .new
        }
    }
    
    // MARK: Helpers
    
    /**
        Compares given version strings with `NSStringCompareOptions.NumericSearch`.
    
        - parameter old: Old (previous) version string for comparation
        - parameter new: New (current) version string for comparation
    
        - returns: Proper `State` after comparing given versions.
    */
    open class func stateForComparingVersions(old: String, new: String) -> AEVersionState {
        let comparison = old.compare(new, options: .numeric)
        switch comparison {
        case .orderedSame:
            return .equal
        case .orderedAscending:
            return .update(previousVersion: old)
        case .orderedDescending:
            return .rollback(previousVersion: old)
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
    case new
    
    /// Version not changed
    case equal
    
    /// Update from given version
    case update(previousVersion: String)
    
    /// Rollback from given version
    case rollback(previousVersion: String)
}

/// Conformance to `Equatable` protocol
extension AEVersionState: Equatable {}

/**
    Implementation of the `Equatable` protocol so that `AEVersionState` 
    can be compared for value equality using operators == and !=.
*/
public func == (lhs: AEVersionState, rhs: AEVersionState) -> Bool {
    switch (lhs, rhs) {
    case (.new, .new):
        return true
    case (.equal, .equal):
        return true
    case (let .update(previous1), let .update(previous2)):
        return previous1 == previous2
    case (let .rollback(previous1), let .rollback(previous2)):
        return previous1 == previous2
    default:
        return false
    }
}
