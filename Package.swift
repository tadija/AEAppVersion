// swift-tools-version:5.0

/**
 *  https://github.com/tadija/AEAppVersion
 *  Copyright (c) Marko Tadić 2016-2019
 *  Licensed under the MIT license. See LICENSE file.
 */

import PackageDescription

let package = Package(
    name: "AEAppVersion",
    platforms: [
        .iOS(.v9)
    ],
    products: [
        .library(
            name: "AEAppVersion",
            targets: ["AEAppVersion"]
        )
    ],
    targets: [
        .target(
            name: "AEAppVersion"
        ),
        .testTarget(
            name: "AEAppVersionTests",
            dependencies: ["AEAppVersion"]
        )
    ]
)
