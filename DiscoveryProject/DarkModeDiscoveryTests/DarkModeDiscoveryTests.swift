//
//  DarkModeDiscoveryTests.swift
//  DarkModeDiscoveryTests
//
//  Created by Mikhail A. Zhigulin of Novosibirsk.
//
//  Unlicensed Free Software.
//

import XCTest
import ConsolePerseusLogger

@testable import TheOneRing

class DarkModeDiscoveryTests: XCTestCase {

    override static func setUp() {
        super.setUp()

        log.message("[\(type(of: self))].\(#function)")

        log.marks = true
        log.directives = true
        log.time = true
        log.owner = true
    }

    override static func tearDown() {
        super.tearDown()

        log.message("[\(type(of: self))].\(#function)")
    }

    /*

    func test_zero() { XCTFail("Tests not yet implemented in \(type(of: self)).") }

     */

    func test_the_first_success() {
        log.message("[\(type(of: self))].\(#function)")

        let isReseted = log.loadConfig(.defaultDebug)
        let result = isReseted ? "CPL options loaded." : "Failed to load options!"

        log.message(result)
    }
}
