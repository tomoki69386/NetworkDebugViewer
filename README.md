# NetowrkDebugViewer

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

## Installation


### [Carthage](https://github.com/Carthage/Carthage)

Add this to `Cartfile`

```
github "tomoki69386/NetworkDebugViewer"
```

```bash
$ carthage update
```



# Usage

```swift
let networkDebug = NetworkDebug(response, request: request, data: data)
let viewController = NetworkDebugListViewController([networkDebug])
let navigationController = UINavigationController(rootViewController: viewController)
present(navigationController, animated: true)
```