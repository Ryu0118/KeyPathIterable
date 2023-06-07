# KeyPathIterable
Macro that allows you to get the KeyPath of all properties of struct, class, enum, and actor

## Installation
```Swift
.package(url: "https://github.com/Ryu0118/KeyPathIterable.git", exact: 0.0.1)
```

## Usage
```Swift
import KeyPathIterable

@KeyPathIterable
struct Hoge {
  let hoge: Int
  let fuga: Int
}

Hoge.allKeyPaths // [\.hoge, \.fuga]
```
