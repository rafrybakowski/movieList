//
//  SnapshotHelper.swift
//  MovieListTests
//
//  Created by Rafał Rybakowski on 10/08/2020.
//  Copyright © 2020 Rafał Rybakowski. All rights reserved.
//

import UIKit
import Quick
import Nimble
@testable import Nimble_Snapshots

class SnapshotHelper {
    class func setupSnapshotTests() {
        let referenceDir = ProcessInfo.processInfo.environment["FB_REFERENCE_IMAGE_DIR"]
        FBSnapshotTest.setReferenceImagesDirectory(referenceDir)
        Nimble.AsyncDefaults.Timeout = 5  // Increase the global timeout to 5 seconds
        Nimble.AsyncDefaults.PollInterval = 0.1 // Slow the polling interval to 0.1 seconds
    }
    class func prepareViewForSnapshotTest(_ view: UIView, snapshotSize: CGSize = CGSize(width: 320, height: 750)) {
        setupSnapshotTests()
        view.bounds = CGRect(origin: CGPoint.zero, size: snapshotSize)
        view.layoutIfNeeded()
    }
}
