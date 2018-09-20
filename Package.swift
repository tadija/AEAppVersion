// swift-tools-version:4.2

/**
 *  https://github.com/tadija/AEAppVersion
 *  Copyright (c) Marko Tadić 2016-2018
 *  Licensed under the MIT license. See LICENSE file.
 */

import PackageDescription

let package = Package(
    name: "AEAppVersion",
    products: [
        .library(name: "AEAppVersion", targets: ["AEAppVersion"])
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
