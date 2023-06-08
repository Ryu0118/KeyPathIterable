# KeyPathIterable
Swift macro that can get KeyPath of all properties of struct, class, enum or actor

## Installation
```Swift
.package(url: "https://github.com/Ryu0118/KeyPathIterable.git", branch: "main")
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
### Recursively get KeyPath of all properties
```Swift
@KeyPathIterable
struct Person {
  let name: String
  let age: Int
}

@KeyPathIterable 
struct Parents {
  let mother: Person
  let father: Person
}

let parents = Parents(
  mother: .init(name: "Mary", age: 30),
  father: .init(name: "Jon", age: 30)
)

parents.recursivelyAllKeyPaths // [\.mother, \.mother.name, \.mother.age, \.father, \.father.name, \.father.age]
```

## Known Issue
Computed properties added by extension are not included in `allKeyPaths` due to macro specifications.
You need to add them manually in this way.
```Swift
@KeyPathIterable
struct Hoge {
  let hoge: String
}

extension Hoge {
  var fuga: Int { 0 }
  static var additionalKeyPaths: [PartialKeyPath<Self>] {
    [\.fuga]
  }
}

Hoge.allKeyPaths // [\.hoge, \.fuga]
```
