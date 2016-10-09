//
// AEVersionComparatorTests.swift
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

import XCTest
@testable import AEAppVersion

class AEVersionComparatorTests: XCTestCase {
    
    func testVersionState() {
        let newVersion = AEVersionComparator(old: nil, new: "1.0.0 (1)")
        XCTAssertEqual(newVersion.state, AEVersionState.new)
        
        let equalVersion = AEVersionComparator(old: "1.0.0 (1)", new: "1.0.0 (1)")
        XCTAssertEqual(equalVersion.state, AEVersionState.equal)
        
        let update = AEVersionComparator(old: "1.0.0 (1)", new: "2.0.0 (1)")
        XCTAssertEqual(update.state, AEVersionState.update(previousVersion: "1.0.0 (1)"))
        
        let rollback = AEVersionComparator(old: "2.0.0 (1)", new: "1.0.0 (1)")
        XCTAssertEqual(rollback.state, AEVersionState.rollback(previousVersion: "2.0.0 (1)"))
    }
    
    func testVersionComparation() {
        var old: String, new: String, state: AEVersionState
        
        old = "1.0.0"
        new = "1.0.1"
        state = AEVersionComparator.stateForComparingVersions(old: old, new: new)
        XCTAssertEqual(state, AEVersionState.update(previousVersion: old))
        
        old = "1.0.0"
        new = "1.1.0"
        state = AEVersionComparator.stateForComparingVersions(old: old, new: new)
        XCTAssertEqual(state, AEVersionState.update(previousVersion: old))
        
        old = "1.0.0"
        new = "2.0.0"
        state = AEVersionComparator.stateForComparingVersions(old: old, new: new)
        XCTAssertEqual(state, AEVersionState.update(previousVersion: old))
        
        old = "1.0.11"
        new = "1.0.101"
        state = AEVersionComparator.stateForComparingVersions(old: old, new: new)
        XCTAssertEqual(state, AEVersionState.update(previousVersion: old))
        
        old = "1.0.0.1A"
        new = "1.0.0.1B"
        state = AEVersionComparator.stateForComparingVersions(old: old, new: new)
        XCTAssertEqual(state, AEVersionState.update(previousVersion: old))
        
        old = "1.0.0 (A21)"
        new = "1.0.0 (A1984)"
        state = AEVersionComparator.stateForComparingVersions(old: old, new: new)
        XCTAssertEqual(state, AEVersionState.update(previousVersion: old))
        
        old = "1.0.0 (B21)"
        new = "1.0.0 (A1984)"
        state = AEVersionComparator.stateForComparingVersions(old: old, new: new)
        XCTAssertEqual(state, AEVersionState.rollback(previousVersion: old))
        
        old = "1.0.0.8A21"
        new = "1.0.0.8A192"
        state = AEVersionComparator.stateForComparingVersions(old: old, new: new)
        XCTAssertEqual(state, AEVersionState.update(previousVersion: old))
        
        old = "1.0.0 (C1)"
        new = "1.0.0 (A1984)"
        state = AEVersionComparator.stateForComparingVersions(old: old, new: new)
        XCTAssertEqual(state, AEVersionState.rollback(previousVersion: old))
        
        // prelease not working as expected, sorry if you need that
        old = "1.0.0 (8A21)"
        new = "1.0.0-alpha (8A21)"
        state = AEVersionComparator.stateForComparingVersions(old: old, new: new)
        XCTAssertEqual(state, AEVersionState.update(previousVersion: old))
    }
    
}
