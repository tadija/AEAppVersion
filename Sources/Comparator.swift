//
// Comparator.swift
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
    Base class for comparing given version strings via `compare` with `NSString.CompareOptions.numeric` option.
    It resolves version comparation state (`State`) inside its `state` property.
*/
open class Comparator {
    
    // MARK: Properties
    
    /// Version comparation state
    open let state: State
    
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
