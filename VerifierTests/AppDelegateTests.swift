//
/*
 * Copyright (c) 2021 Ubique Innovation AG <https://www.ubique.ch>
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 *
 * SPDX-License-Identifier: MPL-2.0
 */

import Foundation
import XCTest
import CovidCertificateSDK
@testable import CovidCertificateVerifier

public class TestableAppDelegate: AppDelegate {
    var initializedSDK = false

    private var keychain: KeychainProtocol!

    public override func initializeCovidCertificateSDK() {
        initializedSDK = true
        guard CovidCertificateSDK.isInitialized else {
            CovidCertificateSDK.initialize(environment: Environment.current.sdkEnvironment, apiKey: Environment.current.appToken)
            return
        }
    }

    public override func getKeychain() -> KeychainProtocol {
        guard keychain != nil else {
            return Keychain()
        }

        return keychain
    }

    func setKeychainSpy(_ spy: KeychainProtocol) {
        keychain = spy
    }
}

class KeychainSpy : Keychain {
    var calledDelete = false

    override func deleteAll() -> Result<(), KeychainError> {
        calledDelete = true
        return .success(())
    }
}

public class AppDelegateTests: XCTestCase {
    var appDelegate: TestableAppDelegate!

    public override func setUpWithError() throws {
        if let bundleID = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: bundleID)
        }

        try super.setUpWithError()

        appDelegate = TestableAppDelegate()
    }

    public override func tearDownWithError() throws {
        try super.tearDownWithError()
        appDelegate = nil
    }

    public func testShouldDefaultFirstLaunchIsTrue() {
        XCTAssertTrue(appDelegate.isFirstLaunch)
    }

    public func testApplicationShouldSetFirstLaunchToFalse() {
        appDelegate.application(UIApplication.shared, didFinishLaunchingWithOptions: [:])

        XCTAssertFalse(appDelegate.isFirstLaunch)
    }
    
    public func testShouldInitializeCovidCertificateSDKOnLaunch() {
        // arrange.

        // act.
        appDelegate.application(UIApplication.shared, didFinishLaunchingWithOptions: [:])
        
        // assert.
        XCTAssertTrue(appDelegate.initializedSDK)
    }

    public func testShouldDeleteKeychainOnFirstLaunch() {
        let keychainSpy = KeychainSpy()
        appDelegate.setKeychainSpy(keychainSpy)

        appDelegate.application(UIApplication.shared, didFinishLaunchingWithOptions: [:])
        
        XCTAssertTrue(keychainSpy.calledDelete)
    }
}
