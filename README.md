# ImageTransition

[![Cocoapods](https://img.shields.io/cocoapods/v/ImageTransition.svg)](https://github.com/shtnkgm/ImageTransition)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Swift Version](https://img.shields.io/badge/Swift-5.5-F16D39.svg)](https://developer.apple.com/swift)
[![GitHub](https://img.shields.io/github/license/shtnkgm/ImageTransition.svg)](https://github.com/shtnkgm/ImageTransition/blob/master/LICENSE)

**ImageTransition** is a library for smooth animation of images during transitions.

Something looks like below:

|e.g. UIImageView|e.g. UIImageView in UICollectionView|
|:---:|:---:|
|<img src="https://github.com/shtnkgm/ImageTransition/raw/master/docs/assets/sample_01.gif" alt="sample_01.gif" width="200px" /> | <img src="https://github.com/shtnkgm/ImageTransition/raw/master/docs/assets/sample_02.gif" alt="sample_02.gif" width="200px" />|

## Feature
 - [x] Transition zooming animation like the iOS Photos app and the "Pinterest", and so on
 - [x] Easy to use (conform to `ImageTransitionable` protocol)
 - [x] Swifty (protocol-oriented)
 - [x] Animation configuration customizable (animation duration, UIView.AnimationOptions)
 - [x] CornerRadius animation (e.g. from a round image to a square Image)

## Installation

 - Swift Package Manager: `https://github.com/shtnkgm/ImageTransition.git`
 - Carthage: `github "shtnkgm/ImageTransition"` 
 - CocoaPods: `pod "ImageTransition"`

## Usage

 - Confirm `ImageTransitionable` protocol
```swift
// Source UIViewController
import ImageTransition
extension SourceViewController: ImageTransitionable {
    var imageViewForTransition: UIImageView? {
        return imageView
    }
}
// Destination UIViewController
import ImageTransition
extension DestinationViewController: ImageTransitionable {
    var imageViewForTransition: UIImageView? {
        return imageView
    }
}
```
 - Set Delegate
```swift
    // present / dismiss transition
    @objc private func imageViewDidTapped() {
        let destinationViewController = DestinationViewController.make()
        destinationViewController.transitioningDelegate = ImageTransitionDelegate.shared
        present(destinationViewController, animated: true, completion: nil)
    }

    // push / pop transition
    @objc private func imageViewDidTapped() {
        let destinationViewController = DestinationViewController.make()
        // Set ImageTransitionDelegate.shared to `delegate` property of UINavigationContoller
        navigationController?.delegate = ImageTransitionDelegate.shared
        navigationController?.pushViewController(destinationViewController, animated: true)
    }
```

## Customize

You can customize the configuration of animation.

```swift
ImageTransitionDelegate.shared.presentDuration = 0.5
ImageTransitionDelegate.shared.dismissDuration = 0.5
ImageTransitionDelegate.shared.pushDuration = 0.5
ImageTransitionDelegate.shared.popDuration = 0.5
ImageTransitionDelegate.shared.presentAnimationOptions = [.curveLinear]
ImageTransitionDelegate.shared.dismissAnimationOptions = [.curveEaseIn]
ImageTransitionDelegate.shared.pushAnimationOptions = [.curveLinear]
ImageTransitionDelegate.shared.popAnimationOptions = [.curveEaseIn]
```

## Requirements

 - iOS 14.0 or later

## Contributing

Pull requests and stars are always welcome.

For bugs and feature requests, please create an issue.

1. Fork it!
2. Create your feature branch: git checkout -b my-new-feature
3. Commit your changes: git commit -am 'Add some feature'
4. Push to the branch: git push origin my-new-feature
5. Submit a pull request :D

## Author

 - [@shtnkgm](https://github.com/shtnkgm) / Shota Nakagami [![Twitter](https://img.shields.io/twitter/follow/shtnkgm?style=social)](https://twitter.com/shtnkgm)

## License

ImageTransition is released under the MIT license. See [LICENSE](https://github.com/shtnkgm/ImageTransition/blob/master/LICENSE) for details.
