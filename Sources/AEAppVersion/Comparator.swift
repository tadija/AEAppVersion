/**
 *  https://github.com/tadija/AEAppVersion
 *  Copyright (c) Marko Tadić 2016-2018
 *  Licensed under the MIT license. See LICENSE file.
 */

import Foundation

/**
    Base class for comparing given version strings via `compare` with `NSString.CompareOptions.numeric` option.
    It resolves version comparation state (`State`) inside its `state` property.
*/
open class Comparator {
    
    // MARK: Properties
    
    /// Version comparation state
    public let state: State
    
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
            state = Comparator.stateForComparingVersions(old: oldVersion, new: new)
        } else {
            state = .new
        }
    }
    
    // MARK: Helpers
    
    /**
        Compares given version strings with `NSString.CompareOptions.numeric`.

        - parameter old: Old (previous) version string for comparation
        - parameter new: New (current) version string for comparation

        - returns: Proper `State` after comparing given versions.
    */
    open class func stateForComparingVersions(old: String, new: String) -> State {
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
