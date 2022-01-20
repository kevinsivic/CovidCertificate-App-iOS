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
    public override func initializeSDK() {
        
    }
}

public class AppDelegateTests: XCTestCase {
    
    public func testShouldDefaultFirstLaunchIsFalse() {
        let appDelegate = TestableAppDelegate()

        XCTAssertFalse(appDelegate.isFirstLaunch)
    }

    public func testApplicationFinishedLaunchingShouldSucceed() {
        let appDelegate = TestableAppDelegate()
        appDelegate.isFirstLaunch = true

        appDelegate.application(UIApplication.shared, didFinishLaunchingWithOptions: [:])

        XCTAssertFalse(appDelegate.isFirstLaunch)
    }
    
    public func testShouldInitializeCovidCertificateSDK() {
        // arrange.
        let appDelegate = AppDelegate()
        
        // act.
        appDelegate.application(UIApplication.shared, didFinishLaunchingWithOptions: [:])
        
        // assert.
        XCTAssertTrue(CovidCertificateSDK.isInitialized)
    }
}
