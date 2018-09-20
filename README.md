[![Swift 4.2](https://img.shields.io/badge/Swift-4.2-orange.svg?style=flat)](https://swift.org)
[![Platforms iOS](https://img.shields.io/badge/Platforms-iOS-lightgray.svg?style=flat)](http://www.apple.com)
[![License MIT](https://img.shields.io/badge/License-MIT-lightgrey.svg?style=flat)](LICENSE)
[![CocoaPods](https://img.shields.io/cocoapods/v/AEAppVersion.svg?style=flat)](https://cocoapods.org/pods/AEAppVersion)
[![Carthage](https://img.shields.io/badge/Carthage-compatible-brightgreen.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Swift Package Manager](https://img.shields.io/badge/SPM-compatible-brightgreen.svg)](https://github.com/apple/swift-package-manager)

# AEAppVersion
**Simple and lightweight iOS App Version Tracking written in Swift**

> Dead simple app version tracking. Add one line to your code and you're all set.  
> I recommend adding this to the project before you really need it (e.g. initial version),  
> so when you do have a need to change something on particular version update, it's already there.

## Index
- [Features](#features)
- [Usage](#usage)
- [Requirements](#requirements)
- [Installation](#installation)
- [License](#license)

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

## Requirements
- Xcode 8.0+
- iOS 8.0+

## Installation

- [Swift Package Manager](https://swift.org/package-manager/):

    ```
    .Package(url: "https://github.com/tadija/AEAppVersion.git", majorVersion: 0)
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
