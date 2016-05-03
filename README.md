# AEAppVersion
**Simple and Lightweight App Version Tracking**

[![Language Swift 2.2](https://img.shields.io/badge/Language-Swift%202.2-orange.svg?style=flat)](https://swift.org)
[![Platforms iOS](https://img.shields.io/badge/Platforms-iOS-lightgray.svg?style=flat)](http://www.apple.com)
[![License MIT](https://img.shields.io/badge/License-MIT-lightgrey.svg?style=flat)](https://github.com/tadija/AEAppVersion/blob/master/LICENSE)

[![CocoaPods Version](https://img.shields.io/cocoapods/v/AEAppVersion.svg?style=flat)](https://cocoapods.org/pods/AEAppVersion)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-brightgreen.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Swift Package Manager compatible](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg)](https://github.com/apple/swift-package-manager)

> Dead simple app version tracking. Add one line to your code and you're all set. 

**AEAppVersion** is a [minion](http://tadija.net/public/minion.png) which consists of two classes:  

- **AEVersionComparator**  
Base class for comparing given version strings via built in `compare` with `NSStringCompareOptions.NumericSearch`.  
It holds version state **(clean install, not changed, update, rollback)** inside `state` enum property.  

- **AEAppVersion**  
Subclass of `AEVersionComparator` with static properties for `version` and `build` strings from main bundle info dictionary.  
When initialized it checks if previous version exists in user defaults and set version `state` accordingly, after which it saves current version to user defaults dictionary.

## Features
- Check **app version state** via enum property
- Get **app version information** via static properties
- Covered with **unit tests**
- Covered with [docs](http://cocoadocs.org/docsets/AEAppVersion)

## Usage
You should just initialize it from your AppDelegate's `didFinishLaunchingWithOptions` and that's it.

```swift
func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
   AEAppVersion.launch()
   return true
}
```

Anytime later you can check version state like this:

```swift
switch AEAppVersion.sharedInstance.state {
case .New:
  return "Clean Install"
case .Equal:
  return "Not Changed"
case .Update(let previousVersion):
  return "Update from: \(previousVersion)"
case .Rollback(let previousVersion):
  return "Rollback from: \(previousVersion)"
}
```

You can also check out the example project and unit tests for more information.

## Requirements
- Xcode 7.0+
- iOS 8.0+

## Installation

- [CocoaPods](http://cocoapods.org/):

    ```ruby
    pod 'AEAppVersion'
    ```

- [Carthage](https://github.com/Carthage/Carthage):

    ```ogdl
    github "tadija/AEAppVersion"
    ```

- Manually:

  Just drag *AEAppVersion.swift* into your project and that's it.

## License
AEAppVersion is released under the MIT license. See [LICENSE](LICENSE) for details.
