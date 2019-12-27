# NetowrkDebugViewer

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

Library that provides a view to view API communication information
API通信情報を見れるViewを提供するライブラリ

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

| <img src='./Assets/image1.png' width='320'/> | <img src='./Assets/image2.png' width='320'/> |
| :------------------------------------------: | :------------------------------------------: |
| <img src='./Assets/image3.png' width='320'/> | <img src='./Assets/image4.png' width='320'/> |
