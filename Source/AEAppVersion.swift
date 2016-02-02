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

public class AEAppVersion: AEVersionComparator {

    // MARK: Static Properties
    
    /// Shared instance
    public static let sharedInstance = AEAppVersion()
    
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
        This should be called on each app launch.

        Implementation of this method is empty, it's just calling its `convenience init` method.
    */
    public func initialize() {}
    
    /**
        Convenience initializer.

        Checks if saved version already exists in user defaults and set state accordingly,
        after which it saves current version as saved version under `savedVersionKey` in user defaults.

        :returns: An initialized version comparator object.
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

public class AEVersionComparator {
    
    // MARK: Properties
    
    public enum State {
        case New
        case Equal
        case Update(previousVersion: String)
        case Rollback(previousVersion: String)
    }
    
    /// Version comparation state
    public let state: State
    
    // MARK: Init
    
    /**
        Designated initializer.
    
        Initializes and returns a newly allocated version comparator object with `state` property configured
        by calling helper method `stateForComparingVersions` with given version strings.
        
        :param: old Old (previous) version string for comparation
        :param: new New (current) version string for comparation
    
        :returns: An initialized version comparator object.
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
    
        :param: old Old (previous) version string for comparation
        :param: new New (current) version string for comparation
    
        :returns: Proper `State` after comparing given versions.
    */
    public class func stateForComparingVersions(old old: String, new: String) -> State {
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

public typealias AEVersionState = AEVersionComparator.State

extension AEVersionState: Equatable {}

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
