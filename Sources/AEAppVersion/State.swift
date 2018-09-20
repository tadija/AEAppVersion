/**
 *  https://github.com/tadija/AEAppVersion
 *  Copyright (c) Marko Tadić 2016-2018
 *  Licensed under the MIT license. See LICENSE file.
 */

import Foundation

/**
    App version state

    - New: Clean install
    - Equal: Version not changed
    - Update: Update from given version
    - Rollback: Rollback from given version
*/
public enum State {
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
extension State: Equatable {}

/**
    Implementation of the `Equatable` protocol so that `State`
    can be compared for value equality using operators == and !=.
*/
public func == (lhs: State, rhs: State) -> Bool {
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
