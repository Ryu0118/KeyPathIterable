public protocol KeyPathIterable {
    static var allKeyPath: [PartialKeyPath<Self>] { get }
}
