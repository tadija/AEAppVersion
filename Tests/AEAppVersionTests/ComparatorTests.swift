/**
 *  https://github.com/tadija/AEAppVersion
 *  Copyright (c) Marko Tadić 2016-2019
 *  Licensed under the MIT license. See LICENSE file.
 */

import XCTest
@testable import AEAppVersion

class ComparatorTests: XCTestCase {
    
    func testVersionState() {
        let newVersion = Comparator(old: nil, new: "1.0.0 (1)")
        XCTAssertEqual(newVersion.state, State.new)
        
        let equalVersion = Comparator(old: "1.0.0 (1)", new: "1.0.0 (1)")
        XCTAssertEqual(equalVersion.state, State.equal)
        
        let update = Comparator(old: "1.0.0 (1)", new: "2.0.0 (1)")
        XCTAssertEqual(update.state, State.update(previousVersion: "1.0.0 (1)"))
        
        let rollback = Comparator(old: "2.0.0 (1)", new: "1.0.0 (1)")
        XCTAssertEqual(rollback.state, State.rollback(previousVersion: "2.0.0 (1)"))
    }
    
    func testVersionComparation() {
        var old: String, new: String, state: State
        
        old = "1.0.0"
        new = "1.0.1"
        state = Comparator.stateForComparingVersions(old: old, new: new)
        XCTAssertEqual(state, State.update(previousVersion: old))
        
        old = "1.0.0"
        new = "1.1.0"
        state = Comparator.stateForComparingVersions(old: old, new: new)
        XCTAssertEqual(state, State.update(previousVersion: old))
        
        old = "1.0.0"
        new = "2.0.0"
        state = Comparator.stateForComparingVersions(old: old, new: new)
        XCTAssertEqual(state, State.update(previousVersion: old))
        
        old = "1.0.11"
        new = "1.0.101"
        state = Comparator.stateForComparingVersions(old: old, new: new)
        XCTAssertEqual(state, State.update(previousVersion: old))

        old = "1.0.1 (101.2)"
        new = "1.1 (11.1)"
        state = Comparator.stateForComparingVersions(old: old, new: new)
        XCTAssertEqual(state, State.update(previousVersion: old))

        old = "1.1 (11.1)"
        new = "1.2.1 (121.1)"
        state = Comparator.stateForComparingVersions(old: old, new: new)
        XCTAssertEqual(state, State.update(previousVersion: old))
        
        old = "1.0.0.1A"
        new = "1.0.0.1B"
        state = Comparator.stateForComparingVersions(old: old, new: new)
        XCTAssertEqual(state, State.update(previousVersion: old))
        
        old = "1.0.0 (A21)"
        new = "1.0.0 (A1984)"
        state = Comparator.stateForComparingVersions(old: old, new: new)
        XCTAssertEqual(state, State.update(previousVersion: old))
        
        old = "1.0.0 (B21)"
        new = "1.0.0 (A1984)"
        state = Comparator.stateForComparingVersions(old: old, new: new)
        XCTAssertEqual(state, State.rollback(previousVersion: old))
        
        old = "1.0.0.8A21"
        new = "1.0.0.8A192"
        state = Comparator.stateForComparingVersions(old: old, new: new)
        XCTAssertEqual(state, State.update(previousVersion: old))
        
        old = "1.0.0 (C1)"
        new = "1.0.0 (A1984)"
        state = Comparator.stateForComparingVersions(old: old, new: new)
        XCTAssertEqual(state, State.rollback(previousVersion: old))
        
        // prelease not working as expected, sorry if you need that
        old = "1.0.0 (8A21)"
        new = "1.0.0-alpha (8A21)"
        state = Comparator.stateForComparingVersions(old: old, new: new)
        XCTAssertEqual(state, State.update(previousVersion: old))
    }
    
}
