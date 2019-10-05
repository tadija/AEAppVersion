[![Swift 5.1](https://img.shields.io/badge/Swift-5.1-orange.svg?style=flat)](https://swift.org)
[![Platforms iOS](https://img.shields.io/badge/Platforms-iOS-lightgray.svg?style=flat)](http://www.apple.com)
[![CocoaPods](https://img.shields.io/cocoapods/v/AEAppVersion.svg?style=flat)](https://cocoapods.org/pods/AEAppVersion)
[![Carthage](https://img.shields.io/badge/Carthage-compatible-brightgreen.svg?style=flat)](https://github.com/Carthage/Carthage)
[![SPM](https://img.shields.io/badge/SPM-compatible-brightgreen.svg)](https://github.com/apple/swift-package-manager)
[![License MIT](https://img.shields.io/badge/License-MIT-lightgrey.svg?style=flat)](LICENSE)

# AEAppVersion

**Simple and lightweight iOS App Version Tracking written in Swift**  

> I made this for personal use, but feel free to use it or contribute.
> For more examples check out [Sources](Sources) and [Tests](Tests).

## Index
- [Intro](#intro)
- [Features](#features)
- [Usage](#usage)
- [Installation](#installation)
- [License](#license)

## Intro

Dead simple app version tracking. Add one line to your code and you're all set.

## Features
- Check **app version state** via enum property
- Get **app version information** via static properties
- Covered with **unit tests**
- Covered with [docs](http://cocoadocs.org/docsets/AEAppVersion)

## Usage
You should just initialize `AEAppVersion` from your AppDelegate's `didFinishLaunchingWithOptions:` like this:

```swift
AEAppVersion.launch()
```

Anytime later you can check version state like this:

```swift
switch AEAppVersion.shared.state {
case .new:
  return "Clean Install"
case .equal:
  return "Not Changed"
case .update(let previousVersion):
  return "Update from: \(previousVersion)"
case .rollback(let previousVersion):
  return "Rollback from: \(previousVersion)"
}
```

**Hint:** You may use helpers for app version and build number like this:

```swift
let version = AEAppVersion.version
let build = AEAppVersion.build
```

You can also check out the example project and unit tests for more information.

## Installation

- [Swift Package Manager](https://swift.org/package-manager/):

    ```swift
    .package(url: "https://github.com/tadija/AEAppVersion.git", from: "0.5.0")
    ```

- [Carthage](https://github.com/Carthage/Carthage):

    ```ogdl
    github "tadija/AEAppVersion"
    ```

- [CocoaPods](http://cocoapods.org/):

    ```ruby
    pod 'AEAppVersion'
    ```

## License
AEAppVersion is released under the MIT license. See [LICENSE](LICENSE) for details.
