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
@testable import CovidCertificateVerifier

public class AppDelegateTests: XCTestCase {
    
    public func testShouldDefaultFirstLaunchIsFalse() {
        let appDelegate = AppDelegate()

        XCTAssertFalse(appDelegate.isFirstLaunch)
    }

    public func testApplicationFinishedLaunchingShouldSucceed() {
        let appDelegate = AppDelegate()
        appDelegate.isFirstLaunch = true

        appDelegate.application(UIApplication.shared, didFinishLaunchingWithOptions: [:])

        XCTAssertFalse(appDelegate.isFirstLaunch)
    }
}
