# KeyPathIterable
Swift macro that can get KeyPath of all properties of struct, class, enum or macro

## Installation
```Swift
.package(url: "https://github.com/Ryu0118/KeyPathIterable.git", exact: "0.1.0")
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
