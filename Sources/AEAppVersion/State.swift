//
// State.swift
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
